#include <stdlib.h>
#include <stdio.h>
#include <p89lpc9351.h>
#include "Global.h"
#include "Servo_PWM.h"
#include "Serial.h"
#include "Positioning.h"

//======Constants 

#define XTAL 7373000L
#define BAUD 115200L

void set_Timer0 (void);
void set_Timer1 (void);
void init_Servo(void);
void init_ADC(void);
void init_fans(void);

void init_Servo(void){

	unsigned char ii = 0; 
 	unsigned char starting_Angles[] = {WRIST_ANGLE + SERVO_WRIST_OFFSET, ELBOW_ANGLE + SERVO_ELBOW_OFFSET,
 										  BICEP_ANGLE + SERVO_BICEP_OFFSET, SHOULDER_ANGLE + SERVO_SHOULDER_OFFSET};
 	
	P0M1 = 0x00;//set low to 0 and high to 1 for output
	P0M2 = 0xFF;
	P0 = 0;
	
	for(ii =0; ii < NUM_OF_SERVOS; ii++){
		max_Servo_Set_Angle[ii] = starting_Angles[ii];
		servo_Set_Angle[ii] = starting_Angles[ii];
	}
}

void set_Timer0 (void) 
{ 
	TR0 = 0; // Stop timer 0 
   	TL0 = 0;
   	TH0 = 0; 
   	TMOD = (TMOD|0x01);
	ET0 = 1; // Enable timer 0 interrupt 
	EA = 1; // Enable global interrupts 
	TR0 = 1; // Start timer 0 
} 

void set_Timer1 (void) 
{ 
	TR1 = 0; // Stop timer 1 
   	TL1 = 0;
   	TH1 = 0; 
   	TMOD = (TMOD|0x10);
	ET1 = 1; // Enable timer 1 interrupt 
	EA = 1; // Enable global interrupts 
	TR1 = 1; // Start timer 1  
}

//P1.0 and P1.1 are used for serial
void init_Serial_Port(void)
{
	BRGCON = 0x00; //Make sure the baud rate generator is off
	BRGR1 = ((XTAL/BAUD)-16)/0x100;
	BRGR0 = ((XTAL/BAUD)-16)%0x100;
	BRGCON = 0x03; //Turn-on the baud rate generator
	SCON = 0x52; //Serial port in mode 1, ren, txrdy, rxempty
	P1M1 = 0x00; //Enable pins RxD and Txd
	P1M2 = 0x00; //Enable pins RxD and Txd
}

void init_ADC(void)
{
	//Add interrupt remember
	//Adcon
	P1M1 = (0xE0|P1M1);
	P1M2 = (0x1F&P1M2);
	
	BURST0 = 1;
	ADMODB = CLK0; //ADC1 clock is 7.3728MHz/2
	ADINS  = 0x08; // Select the four channels for conversion
	ADCON0 = 0x05;//Enable the converter and start immediately
	//while((ADCI1 & ADCON1) ==0 ); //Wait for first conversion to complete
}

void init_Fans(void)
{
	P2M1 = 0x00;
	P2M2 = 0xFF;
	
	P2_0 = 1;
	P2_1 = 1;
	P2_2 = 1;
	P2_3 = 1;
	P2_4 = 0;
}

void main(void)
{	
	EA = 0;
	init_Servo();
	set_Pulse_Width();
	set_Timer0();
	set_Timer1();
	init_Serial_Port();
	Wait1S();
	init_Fans();
	printf_tiny("Ready for commands!\n");
	
	while(1)
	{		
		
		if (RI == 1)
		{
			get_Command();
		}
		
		set_Pulse_Width();
	}
	
}
