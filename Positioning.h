#ifndef Positioning_H_
#define Positioning_H_

#include <stdlib.h>
#include "Servo_PWM.h"

void set_Max_Servo_Angle(unsigned char, unsigned int);
void safety_Position(void);
void wait_Servo_Finish(unsigned char ii);

void set_Max_Servo_Angle(unsigned char servo_Index, unsigned int angle)
{
	if(servo_Index == ELBOW){
		angle = 180 - angle;
	}
	/*
	if(servo_Offset[servo_Index] < 0 && abs(servo_Offset[servo_Index]) > angle){
		angle = 0;
	}*/
	else if( (servo_Offset[servo_Index] + angle) > MAX_ANGLE){
		angle = MAX_ANGLE;
	}
	else{
		angle += servo_Offset[servo_Index];
	}
	
	max_Servo_Angle[servo_Index] = angle;
	printf_tiny("angle is %d and index is %d\n", angle, servo_Index);
	
}

void safety_Position(void){
	
	set_Max_Servo_Angle(SHOULDER, SHOULDER_ANGLE);
	wait_Servo_Finish(SHOULDER);
	set_Max_Servo_Angle(WRIST, WRIST_ANGLE);
	wait_Servo_Finish(WRIST);
	set_Max_Servo_Angle(ELBOW, 100);
	wait_Servo_Finish(ELBOW);
	set_Max_Servo_Angle(BICEP, BICEP_ANGLE);
	wait_Servo_Finish(BICEP);
	set_Max_Servo_Angle(ELBOW, ELBOW_ANGLE);
	wait_Servo_Finish(ELBOW);
}

void wait_Servo_Finish(unsigned char ii){
	while(max_Servo_Angle[ii] != servo_Angle[ii])
		set_Pulse_Width();
}

#endif