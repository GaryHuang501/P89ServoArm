//change servo position and calculate position

//Front of Arm is +X. PSU is -X
//height is easily calculate by the sum of the sines of all limb lengths, X is similar
//To find the distance between the shoulder and the flame we can find the angle which the IR detects the flame (distance voltage reading is useless due to unreliability) to find the distance since candle height is fixed
//The IR angle is the sum of 270 - angle for each limb. However, if the angle is above 90 then we need to 180 - it.


#ifndef Positioning_H_
#define Positioning_H_

#include <stdlib.h>
#include <math.h>
#include <Trig
#include "Servo_PWM.h"
#include "IR.h"
#include "Util.h"

#define MAX_NUM_FLAMES 5
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
#define MAX_WIND_RADIUS_FROM_WRIST  166 //sinf(to_Rad(MAX_WRIST_SCAN) ) * WRIST_WITH_FAN_LENGTH  - cosf(to_Rad(MAX_WRIST_SCAN)) * (FAN_WIDTH / 2)  + sinf(to_Rad(MAX_WRIST_SCAN)) * MAX_FAN_RANGE;
#define INCREASE_X_WITH_BICEP_ADJUSTMENT 145 //Found by setting height from horizontal to elbow bottom, where elbow is parallel to horizontal, to MAX_SAFE_HEIGHT_ABOVE_CANDLE
#define MAX_SHOULDER_SCAN 145
#define MIN_SHOULDER_SCAN  45
#define MIN_WRIST_SCAN 15
#define MAX_WRIST_SCAN  60
#define SHOULDER_SCAN_DECREMENT  10

#define FAN_ANGLE_ADJUSTMENT 35 //since fan is below IR need to raise it up
#define DEFAULT_SCAN_Y 250
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
float to_Rad(unsigned char);
void sortFlame(void);

static void initial_Scan_Position();
static void begin_Scanning();
static unsigned int calculate_X_Flame_Position(void);
static void extinguish(void);
static unsigned int get_Max_Arm_Radius(unsigned char);
static unsigned int get_Fan_To_Flame_Angle(unsigned char);



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
	
	if(servo_Index == SHOULDER)
		printf_tiny("shoulder at %d\n", angle);
		
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
	//sortFlame();
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

	idata unsigned char flame_Count = 0;
	idata char foundFlame = 0; //If the person found flame at certain shoudler rotation
	
	//Need counter for wrist and shoulder max angle or else offset may get cancelled and the limbs won't move
	idata unsigned char wrist_Temp;
	idata unsigned char shoulder_Temp = MAX_SHOULDER_SCAN;
	
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
				flame.shoulder_Angle[flame_Count] = to_Rad(shoulder_Temp);
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
static unsigned int calculate_X_Flame_Position(void)
{
	idata const unsigned char NUM_LIMBS = 4;
	idata unsigned char ii = 0;
	idata int y_IR = 0;
	idata int x_IR = 0;
	idata unsigned int angle_IR = 0;

	for(ii = 0; ii < NUM_LIMBS; ii++)
	{
		if(ii == BICEP)
			angle_IR = servo_Angle[ii];
		else if(servo_Angle[ii] > 90)
			angle_IR += 270 - (180 - servo_Angle[ii]); //270 for third quadrant 
		else
			angle_IR += 270 - servo_Angle[ii];
		
		y_IR += sinf(to_Rad(angle_IR));
		x_IR += cosf(to_Rad(angle_IR));
	
	}
	
	//If arm is not at 90 shoulder then we have to find relative to X horizontal
	x_IR = x_IR * sinf(to_Rad(servo_Angle[SHOULDER]));
	
	return ( abs( ((y_IR - CANDLE_HEIGHT)/tanf(to_Rad(angle_IR))) + x_IR));
	
}

static float to_Rad(idata unsigned char angle)
{
	return (( (float)angle / 180 )* 3.14159);	
}

//Moves arm into position and blow it out the flames
static void extinguish(void)
{
	
	idata unsigned char ii = 0;
	idata unsigned int max_Arm_Radius = 0;
	idata unsigned int x_Needed = 0;
	
	//default position : crane
	set_Max_Servo_Angle(BICEP, 90, 1);
	set_Max_Servo_Angle(WRIST, MIN_WRIST_SCAN , 1);
	set_Max_Servo_Angle(ELBOW, 0, 1);
	
	for(ii = 0; ii < MAX_NUM_FLAMES; ii++)
	{
		
		max_Arm_Radius = get_Max_Arm_Radius(ii);
			
		printf_tiny("distance is %d at %d", flame.distance[ii], flame.shoulder_Angle[ii]);
		
		//flame further than default arm position can reach but within max range,  Then lets move bicep to cover the X while still being above a min value
		if( flame.distance[ii] > max_Arm_Radius && flame.distance[ii] <  (max_Arm_Radius + sinf(flame.shoulder_Angle[ii]) * INCREASE_X_WITH_BICEP_ADJUSTMENT)){
			
		}
		//Then we only need to the wrist
		else if (flame.distance[ii] <= max_Arm_Radius && flame.distance[ii] > 0){
			//set_Max_Servo_Angle(WRIST, atanf(DEFAULT_SCAN_HEIGHT /(flame.distance[ii] - (sinf(flame.shoulder_Angle[ii]) * ELBOW_LENGTH))+ FAN_ANGLE_ADJUSTMENT), 1) ;
			FIRE_FAN_PORT = 1;
			wait1S();
			wait1S();
			FIRE_FAN_PORT = 0;
		}
			

	
	}
}



//find arm's reach at given shoulder angle
static unsigned int get_Max_Arm_Radius(unsigned char ii)
{
	return  sinf(flame.shoulder_Angle[ii]) *  (ELBOW  + MAX_WIND_RADIUS_FROM_WRIST);
	
}
//selection sort for 2 arrays
void sortFlame(void)
{
	/*
	idata unsigned char ii = 0;
	idata unsigned char jj = 0;
	idata unsigned int temp = 0;
	idata unsigned int min;
	idata unsigned char min_Index;

	//-----------------Start sorting
	for (jj = 0; jj < MAX_NUM_FLAMES; jj++)
	{

		min = flame.distance[jj];
		min_Index = jj;
		
		for ( ii = jj; ii < MAX_NUM_FLAMES;  ii++)
		{
			//find element with smallest value and its index
			if( flame.distance[ii] < min)
			{
				min = flame.distance[ii];
				min_Index = ii;
			}
		}
		
		//swap places
		temp = flame.distance[jj];
		flame.distance[jj] = flame.distance[min_Index]; 
		flame.distance[min_Index] = temp; 
		
		temp = flame.shoulder_Angle[jj];
		flame.shoulder_Angle[jj] = flame.shoulder_Angle[min_Index];
		flame.shoulder_Angle[min_Index] = temp;
	}*/
}
#endif