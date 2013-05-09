//change servo position and calculate position

//Front of Arm is +X. PSU is -X
//height is easily calculate by the sum of the sines of all limb lengths, X is similar
//To find the distance between the shoulder and the flame we can find the angle which the IR detects the flame (distance voltage reading is useless due to unreliability) to find the distance since candle height is fixed
//The IR angle is the sum of 270 - angle for each limb. However, if the angle is above 90 then we need to 180 - it.


#ifndef Positioning_H_
#define Positioning_H_

#include <stdlib.h>
#include "Trig.h"
#include "Servo_PWM.h"
#include "IR.h"
#include "Util.h"

#define MAX_NUM_FLAMES 3
//mm,
#define MIN_HEIGHT_EXTINGUISH 150
#define CANDLE_HEIGHT 40 //up to top of candle wick
#define FAN_LENGTH_WRIST 45
#define WRIST_LENGTH 60
#define WRIST_WITH_FAN_LENGTH 85
#define BICEP_LENGTH 160
#define ELBOW_LENGTH 200
#define SHOULDER_LENGTH 97

#define MAX_FAN_RANGE 150
#define MAX_SAFE_HEIGHT_ABOVE_CANDLE 170
#define FAN_WIDTH 80 //it's a 80 x 80 mm square fan
#define MAX_WIND_RADIUS_FROM_WRIST  166 //sin(to_Rad(MAX_WRIST_SCAN) ) * WRIST_WITH_FAN_LENGTH  - cos(to_Rad(MAX_WRIST_SCAN)) * (FAN_WIDTH / 2)  + sin(to_Rad(MAX_WRIST_SCAN)) * MAX_FAN_RANGE;
#define INCREASE_X_WITH_BICEP_ADJUSTMENT 145 //Found by setting height from horizontal to elbow bottom, where elbow is parallel to horizontal, to MAX_SAFE_HEIGHT_ABOVE_CANDLE
#define MAX_SHOULDER_SCAN 145
#define MIN_SHOULDER_SCAN  45
#define MIN_WRIST_SCAN 15
#define MAX_WRIST_SCAN  60
#define SHOULDER_SCAN_DECREMENT  5

#define FAN_ANGLE_ADJUSTMENT 35 //since fan is below IR need to raise it up
#define DEFAULT_SCAN_Y 262
#define DEFAULT_SCAN_X ELBOW_LENGTH 
								
idata const unsigned char limb_Length[] = {WRIST_LENGTH, BICEP_LENGTH, ELBOW_LENGTH, SHOULDER_LENGTH};

idata struct Flame
{
	unsigned int distance[MAX_NUM_FLAMES];
	unsigned int shoulder_Angle[MAX_NUM_FLAMES];	//store as rad
} flame;

void set_Max_Servo_Angle(unsigned char, unsigned int, char);
void safety_Position(void);
void wait_Servo_Finish(unsigned char ii);
void scan_Destroy();
void sortFlame(void);

static void initial_Scan_Position();
static void begin_Scanning();
static unsigned int calculate_X_Flame_Position(void);
static void extinguish(void);
static unsigned int get_Fan_To_Flame_Angle(unsigned char);
static void point_Fan_To_Flame(unsigned int, unsigned int);

//make servo rotate up to the passed angle
//@param: shouldWait if true means control flow will not leave the function until servo has finished moving
void set_Max_Servo_Angle(unsigned char servo_Index, unsigned int angle, char shouldWait)
{
	if(servo_Index == ELBOW){
		angle = 180 - angle;
	}
	
	if(servo_Offset[servo_Index] < 0 && abs(servo_Offset[servo_Index]) > angle){
		angle = 0;
	}
	else if( (servo_Offset[servo_Index] + angle) > MAX_ANGLE){
		angle = MAX_ANGLE;
	}
	else{
		angle += servo_Offset[servo_Index];
	}
	
	max_Servo_Angle[servo_Index] = angle;
	
	if(shouldWait == 1){
		wait_Servo_Finish(servo_Index);
	}
		
}

void safety_Position(void){
	
	set_Max_Servo_Angle(SHOULDER, SHOULDER_ANGLE, 1);
	set_Max_Servo_Angle(WRIST, WRIST_ANGLE, 1);
	set_Max_Servo_Angle(ELBOW, 100, 1);
	set_Max_Servo_Angle(BICEP, BICEP_ANGLE, 1);
	set_Max_Servo_Angle(ELBOW, ELBOW_ANGLE, 1);

}

void wait_Servo_Finish(unsigned char ii){
	
	while(max_Servo_Angle[ii] != servo_Angle[ii])
		set_Pulse_Width();
}

//begin searching for the flame
void scan_Destroy(void)
{
	idata unsigned char ii = 0;
	
	for(ii = 0; ii < MAX_NUM_FLAMES; ii++)
	{
		flame.distance[ii] = 0;
	}
	
	initial_Scan_Position();
	begin_Scanning();
	sortFlame();
	extinguish();
}

static void initial_Scan_Position(void)
{
	set_Max_Servo_Angle(BICEP, 90, 1);
	set_Max_Servo_Angle(WRIST, 90, 1);
	set_Max_Servo_Angle(ELBOW, 0, 1);

}

//scan high angle to low angle for flame and calculate the X distance relative to x axis
static void begin_Scanning(void)
{

	data unsigned char flame_Count = 0;
	data char foundFlame = 0; //If the person found flame at certain shoudler rotation
	
	//Need counter for wrist and shoulder max angle or else offset may get cancelled and the limbs won't move
	data unsigned char wrist_Temp;
	data unsigned char shoulder_Temp = MAX_SHOULDER_SCAN;
	
	set_Max_Servo_Angle(SHOULDER, MAX_SHOULDER_SCAN, 1);
	
	while( shoulder_Temp > MIN_SHOULDER_SCAN)
	{
		set_Max_Servo_Angle(WRIST, MAX_WRIST_SCAN , 1);
		wrist_Temp = MAX_WRIST_SCAN;
		foundFlame = 0;
		
		while(wrist_Temp  > MIN_WRIST_SCAN)
		{
			if(RI == 1)
				return;
			
			if (checkForFlame() > 0 && foundFlame == 0 && flame_Count < MAX_NUM_FLAMES){
				flame.distance[flame_Count] = calculate_X_Flame_Position();
				flame.shoulder_Angle[flame_Count] = shoulder_Temp;
				flame_Count++;
				foundFlame = 1;
			}
			
			set_Max_Servo_Angle(WRIST, --wrist_Temp, 1);
		}
		
		shoulder_Temp -= SHOULDER_SCAN_DECREMENT;
		set_Max_Servo_Angle(SHOULDER, shoulder_Temp , 1);
	}
}

//Returns the X position of the flame relative to the shoulder servo and X axis
//Req: scanning is always done in the positive direction
//The angle of the limbs are always >= -90 && <= 180
static unsigned int calculate_X_Flame_Position(void)
{
	data const unsigned char NUM_LIMBS = 4;
	data char ii = 0;
	data float y_IR = SHOULDER_LENGTH;
	data float x_IR = 0;
	data unsigned int angle_IR = 0;

	for(ii = BICEP; ii >= WRIST; ii--)
	{
		if(ii == BICEP)
			angle_IR = servo_Angle[BICEP];
		else if(ii == ELBOW)
			angle_IR = (180 - (servo_Angle[ELBOW] - servo_Offset[ELBOW])) - (90 - angle_IR);
		else 
			angle_IR = (servo_Angle[ii] - servo_Offset[ii]) - (90 - angle_IR); 
		
		printf_tiny("angle wrist found is %d\n", angle_IR);
		
		y_IR += sin(angle_IR) * limb_Length[ii];
		x_IR += cos(angle_IR) * limb_Length[ii];
		
	//	printf_tiny("X is %f\n", x_IR);
	//	printf_tiny("Y %f\n", y_IR);
	
	}
	
	// have to find relative to X horizontal
	x_IR = x_IR * sin(servo_Angle[SHOULDER]);
	
	//expect angle_IR never to be 0 or 90, but if it is the distance will be too big anyway
	return (int)( abs(((y_IR - CANDLE_HEIGHT)/tan(angle_IR)) + x_IR));
	
}

//Moves arm into position and blow it out the flames
static void extinguish(void)
{
	
	data unsigned char ii = 0;
	data unsigned int max_Default_Arm_Radius = 0;
	data unsigned int adjusted_Angle = 0;
	data unsigned int x_Needed = 0;
	//default position : crane
	set_Max_Servo_Angle(BICEP, 90, 1);
	set_Max_Servo_Angle(WRIST, MIN_WRIST_SCAN , 1);
	set_Max_Servo_Angle(ELBOW, 0, 1);
	
	for(ii = 0; ii < MAX_NUM_FLAMES; ii++)
	{
		
		max_Default_Arm_Radius = sin(flame.shoulder_Angle[ii]) *  (ELBOW  + MAX_WIND_RADIUS_FROM_WRIST);
			
		//printf_tiny("distance is %d at %d\n", flame.distance[ii], flame.shoulder_Angle[ii]);
		
		//flame further than default arm position can reach but within max range,  Then lets move bicep to cover the X while still being above a min value
		if( flame.distance[ii] > max_Default_Arm_Radius && flame.distance[ii] <  (max_Default_Arm_Radius + sin(flame.shoulder_Angle[ii]) * INCREASE_X_WITH_BICEP_ADJUSTMENT)){
			x_Needed = flame.distance[ii] - max_Default_Arm_Radius;
			adjusted_Angle = asin(x_Needed / BICEP_LENGTH);
			set_Max_Servo_Angle(BICEP, 90 - adjusted_Angle, 1);
			set_Max_Servo_Angle(ELBOW, max_Servo_Angle[ELBOW] + adjusted_Angle, 1); //make elbow parallel again 												
			point_Fan_To_Flame((sin(max_Servo_Angle[BICEP]) * BICEP_LENGTH) + SHOULDER_LENGTH, 
									flame.distance[ii] - ( sin(flame.shoulder_Angle[ii]) * ELBOW_LENGTH) + x_Needed);
		}
		else if (flame.distance[ii] <=max_Default_Arm_Radius&& flame.distance[ii] > 0){ //Then we only need move to the wrist
			point_Fan_To_Flame(DEFAULT_SCAN_Y, flame.distance[ii] - (sin(flame.shoulder_Angle[ii]) * ELBOW_LENGTH));
		}
			
	}
}


static void point_Fan_To_Flame(unsigned int height, unsigned int x_Needed)
{
	set_Max_Servo_Angle(WRIST, (int)(atan(height / x_Needed)+ FAN_ANGLE_ADJUSTMENT + 0.5), 1);		
	FIRE_FAN_PORT = 1;
	wait1S();
	wait1S();
	FIRE_FAN_PORT = 0;

}


//bubble sort
void sortFlame(void)
{
/* not enough memory	
	data unsigned char ii = 0;
	data unsigned char jj = 0;
	data unsigned int temp = 0;

	//-----------------Start sorting
	for (jj = 0; jj < MAX_NUM_FLAMES - 1; jj++)
	{

		for ( ii = 0; ii < MAX_NUM_FLAMES - jj;  ii++)
		{
			//find element with smallest value and its index
			if( flame.distance[ii] > flame.distance[ii + 1])
			{
				temp = flame.distance[ii + 1];
				flame.distance[ii + 1] = flame.distance[ii];
				flame.distance[ii] = temp;
				
				temp = flame.shoulder_Angle[ii + 1];
				flame.shoulder_Angle[ii + 1] = flame.shoulder_Angle[ii];
				flame.shoulder_Angle[ii] = temp;
			}
		}
		
	}
	*/
} 
#endif