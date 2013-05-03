//change servo position and calculate position

#ifndef Positioning_H_
#define Positioning_H_

#include <stdlib.h>
#include "Servo_PWM.h"
#include "IR.h"

#define MAX_NUM_FLAMES 5

struct Flame
{
	int distance[MAX_NUM_FLAMES];
	int shoulder_Angle[MAX_NUM_FLAMES];	
} flame;

void set_Max_Servo_Angle(unsigned char, unsigned int, char);
void safety_Position(void);
void wait_Servo_Finish(unsigned char ii);
void scan_Destroy();

static void initial_Scan_Position();
static void begin_Scanning();
static int calculate_Flame_Position(void);
static void extinguish(void);




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
	unsigned char ii = 0;
	
	for(ii = 0; ii < MAX_NUM_FLAMES; ii++)
	{
		flame.distance[ii] = -1;
	}
	
	initial_Scan_Position();
	begin_Scanning();
	extinguish();
}

static void initial_Scan_Position(void)
{
	const unsigned char MAX_SHOULDER_SCAN = 145;
	
	set_Max_Servo_Angle(WRIST, 90, 1);
	set_Max_Servo_Angle(ELBOW, 90, 1);
	set_Max_Servo_Angle(BICEP, 90, 1);
	set_Max_Servo_Angle(SHOULDER, MAX_SHOULDER_SCAN, 1);
}

static void begin_Scanning(void)
{
	const unsigned char MIN_SHOULDER_SCAN = 45;
	const unsigned char MAX_WRIST_SCAN = 60;
	const unsigned char SHOULDER_SCAN_INCREMENT = 5;
	unsigned char flame_Count = 0;
	char foundFlame = 0; //If the person found flame at certain shoudler rotation

	set_Max_Servo_Angle(ELBOW, 60, 1);
	set_Max_Servo_Angle(BICEP, 120, 1);
	
	while(max_Servo_Angle[SHOULDER] > MIN_SHOULDER_SCAN)
	{
		set_Max_Servo_Angle(WRIST, 60 , 1);
		foundFlame = 0;
		
		while(max_Servo_Angle[WRIST]  > 0)
		{
			if (checkForFlame() > 0 && foundFlame == 0){
				flame.distance[flame_Count++] = calculate_Flame_Position();
				flame.shoulder_Angle[flame_Count++] = max_Servo_Angle[WRIST];
				foundFlame = 1;
			}
			
			max_Servo_Angle[WRIST]--;
		}
		
		set_Max_Servo_Angle(SHOULDER, max_Servo_Angle[SHOULDER] - SHOULDER_SCAN_INCREMENT, 1);
	}
}

static int calculate_Flame_Position(void)
{
	return 0;
}

static void extinguish(void)
{
	unsigned char ii = 0;
	
	for(ii = 0; ii < MAX_NUM_FLAMES; ii++)
	{
		if(flame.distance[ii] != - 1)
		{
			
			
		}
	}
}
#endif