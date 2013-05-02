
//**Reads command from serial 

#ifndef Serial_H_
#define Serial_H_

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>
#include <p89lpc9351.h>
#include "Global.h"
#include "Positioning.h"

void get_Command(void);



//check if any commands from serial
void get_Command(void)
{
	unsigned int angle = 0;
	char buffer[5];
	char command = NONE;
	printf_tiny("command\n");
	gets(buffer);
	buffer[4] = '\0';
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
			break;
		case('w'):
			command = WRIST;
			break;
		case('f'):
			command = FIRE_FAN_TOGGLE;
			break;
		case('x'):
			command = SAFETY;
			break;
	}
	
	if(command == FIRE_FAN_TOGGLE){
		FIRE_FAN_PORT ^= 1;
	}
	else if(command == SAFETY){
		safety_Position();
	}
	else if(command != NONE){
		set_Max_Servo_Angle(command % NUM_OF_SERVOS, angle);
	}
			
}


#endif
