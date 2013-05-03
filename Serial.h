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


#define XTAL 7373000L
#define BAUD 115200L

#define FIRE_FAN_TOGGLE -1
#define EXTINGUISH -2
#define SAFETY -3
#define NONE -4

void get_Command(void);
void init_Serial_Port(void);

//P1.0 and P1.1 are used for serial
void init_Serial_Port(void){
	
	BRGCON = 0x00; //Make sure the baud rate generator is off
	BRGR1 = ((XTAL/BAUD)-16)/0x100;
	BRGR0 = ((XTAL/BAUD)-16)%0x100;
	BRGCON = 0x03; //Turn-on the baud rate generator
	SCON = 0x52; //Serial port in mode 1, ren, txrdy, rxempty
	P1M1 = 0x00; //Enable pins RxD and Txd
	P1M2 = 0x00; //Enable pins RxD and Txd
}
//check if any commands from serial
void get_Command(void)
{
	unsigned int angle = 0;
	char buffer[5];
	char command = NONE;
	
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
		case('t'):
			command = FIRE_FAN_TOGGLE;
			break;
		case('x'):
			command = SAFETY;
			break;
		case('f'):
			command = EXTINGUISH;
			break;
	}
	
	if(command == FIRE_FAN_TOGGLE){
		FIRE_FAN_PORT ^= 1;
	}
	else if(command == EXTINGUISH){
		//TODO:
	}
	else if(command == SAFETY){
		safety_Position();
	}
	else if(command != NONE){
		set_Max_Servo_Angle(command % NUM_OF_SERVOS, angle);
	}
			
}


#endif
