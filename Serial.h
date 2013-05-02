
//**Reads command from serial 

#ifndef Serial_H_
#define Serial_H_

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include <p89lpc9351.h>
#include "Global.h"

void get_Command(void);
void safety_Position(void);
void Wait1S(void);


//check if any commands from serial
void get_Command(void)
{
	unsigned int angle = 0;
	char buffer[4];
	char command = NONE;
	
	gets(buffer);
	RI = 0;
	
	if(buffer[0] != 'f' && buffer[0] != 'x'){
		if(strlen(buffer) < 2){
			return;
		}
		else{
			angle = atoi(buffer + 1);
		}
	}
	

	switch(buffer[0])
	{
		case('s'):
			command = SHOULDER;	
			break;
		case('b'):					
			if(angle <= 135){
				command = BICEP;
			}
			else{
				printf_tiny("Bicep max angle of 145");
			}
			break;
		case('e'):
			command = ELBOW;
			angle = 180 - angle;
			break;
		case('w'):
			command = WRIST;
			break;
		case('f'):
			command = FAN;
			break;
		case('x'):
			command = SAFETY;
			break;
	}
	
	if(command == FAN){
		P2_4 ^= 1;
	}
	else if(command == SAFETY){
		safety_Position();
	}
	else if(command != NONE){
		max_Servo_Set_Angle[command % NUM_OF_SERVOS] = angle;
	}
			
}

void safety_Position(void){
	
	max_Servo_Set_Angle[SHOULDER] = SHOULDER_ANGLE;
	Wait1S();
	Wait1S();
	max_Servo_Set_Angle[WRIST] = WRIST_ANGLE;
	Wait1S();
	Wait1S();
	max_Servo_Set_Angle[ELBOW] = 100; //intermediate angle
	Wait1S();
	Wait1S();
	max_Servo_Set_Angle[BICEP] = BICEP_ANGLE;
	Wait1S();
	Wait1S();
	max_Servo_Set_Angle[ELBOW] = ELBOW_ANGLE;
	
}


#endif
