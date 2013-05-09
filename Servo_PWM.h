//Overview: Generates the PWM signal to control the servos
//Angles are converted to timer values to decide Pulse width
//Smallest timer values stored into an array left to right, to decide which servos to turn off first
//It only uses Timer0 and does this by calculating the difference between the varying pulse width for each angle
//Servos are slowed down, updating every 20ms

#ifndef Servo_PWM_H_
#define Servo_PWM_H_

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <p89lpc9351.h>
#include "Global.h"
#include "Util.h"

#define SERVO_PORTS P0 //PWM PORTS

//PWM generator phases
#define START_OVER 20
#define DELAY_5MS_PHASE (NUM_OF_SERVOS - 1)
#define DELAY_15MS_PHASE NUM_OF_SERVOS
	
//Timer Reload Constants --Change this
#define RELOAD_15MS_HIGH 0x27
#define RELOAD_15MS_LOW 0xCA
#define RELOAD_5MS 18450L

#define CLOCK_CYCLE_PERIOD 271
#define MINIMUM_WIDTH_LENGTH 60000L
#define TIMER_MAX_VALUE 65535L

void set_Pulse_Width (void);

static void set_Servo_Priority(void); 
static void calculate_Timer_Cycle(void);
static void set_Phases(void);
static void slow_Down_Servo(void);
static void set_Index_to_Servo_Port(void);

//Stores angle converted to clock cycles
static data unsigned int timer0_Servo_PWM_Width[NUM_OF_SERVOS]; 

//Length of each pulse for timer
static volatile data unsigned int TH0_Phase[NUM_OF_SERVOS]; 
static volatile data unsigned int TL0_Phase[NUM_OF_SERVOS];

//15ms last phase
static volatile data unsigned int TH0_Phase_FirstDelay;
static volatile data unsigned int TL0_Phase_FirstDelay;

//Which servo to turn off
static data unsigned char servo_Priority[NUM_OF_SERVOS]; //The one the interrupt uses, can't use servo_Index, don't want interrrupt to trigger during calculations 

//Interrupt phases 
static volatile char phase = 0;

//Calculates and sets up the registers for interrupt to use PWM
void set_Pulse_Width(void)
{
	slow_Down_Servo();
	calculate_Timer_Cycle();
	set_Servo_Priority();
	set_Phases();	
}	

//Generates the PWM
//Servo period is 20ms and due to p89 timer's longest timer interrupt being < 20ms
//The delays must be split into 2 phases for 15ms and 5ms
static void Timer0_ISR (void) interrupt 1 using 0
{
	TR0 = 0;
	

	if(phase  == START_OVER) //Turn all pulses on and restart pwm generation
	{
		SERVO_PORTS = 0xFF;	
		TH0 = TH0_Phase[0];
		TL0 = TL0_Phase[0];
		phase = 0;

	}
	else if(phase  ==  DELAY_5MS_PHASE) // == # servo - 1)
	{
		SERVO_PORTS = 0; //ALL OFF
		TH0 = TH0_Phase_FirstDelay;
		TL0 = TL0_Phase_FirstDelay; 
		phase = DELAY_15MS_PHASE;		
	}
	
	else if(phase  ==  DELAY_15MS_PHASE ) // == #servo)
	{
		SERVO_PORTS = 0; //ALL OFF
		TH0 = RELOAD_15MS_HIGH;
		TL0 = RELOAD_15MS_LOW;
		phase = START_OVER;		
	}

	else //Turn servos off starting from smallest pulse width one at a time
	{

		SERVO_PORTS = servo_Priority[phase]; 
		phase++;
		TH0 = TH0_Phase[phase];
		TL0 = TL0_Phase[phase];		
	}
	
	TF0 = 0;
	TR0 = 1;
} 

static void Timer1_ISR (void) interrupt 3 using 1
{

}


//Slows down servos, adding 1 degree per 20ms
static void slow_Down_Servo(void)
{

	unsigned char ii = 0;
	
	wait30ms();

	for (ii = 0; ii < NUM_OF_SERVOS; ii++)
	{
		
		if (max_Servo_Angle[ii] >   servo_Angle[ii])
		{
			 servo_Angle[ii]++;
		}
		else if (max_Servo_Angle[ii] <   servo_Angle[ii])
		{
			 servo_Angle[ii]--;
		}
	}

}

//timer0_Servo_PWM_Width is sorted from small to big using insert
//Then stores what servo should be turn off first (smallest)
static void set_Servo_Priority(void)
{
	unsigned char servo_Index[NUM_OF_SERVOS]; //keep track of which servo is which when sorting
	unsigned char ii = 0;  // temp calculations for loops
	unsigned char jj = 0; //
	unsigned char min_Index = 0;
	unsigned int min = 0;
	unsigned int temp = 0;

	//--------------------------Set indexes
	for (ii = 0; ii < NUM_OF_SERVOS; ii++)
	{
		servo_Index[ii] = ii;
	}

	//-----------------Start sorting 
	for (jj = 0; jj < NUM_OF_SERVOS; jj++)
	{

		min = timer0_Servo_PWM_Width[jj];
		min_Index = jj;
		
		for ( ii = jj; ii < NUM_OF_SERVOS; ii++)
		{
			//find element with smallest value and its index
			if( timer0_Servo_PWM_Width[ii] < min)
			{
				min = timer0_Servo_PWM_Width[ii];
				min_Index = ii;
			}
		}
		
		//swap places
		temp = timer0_Servo_PWM_Width[jj];
		timer0_Servo_PWM_Width[jj] = timer0_Servo_PWM_Width[min_Index]; 
		timer0_Servo_PWM_Width[min_Index] = temp; 
		
		temp = servo_Index[jj];
		servo_Index[jj] = servo_Index[min_Index];
		servo_Index[min_Index] = temp;
	}
	
	temp = 0xFF;
	
	//Sets the bytes to store into Servo ports to signal which ports to turn off
	//Note: Index corresponds to Servo port bit index
	for (ii = 0; ii < NUM_OF_SERVOS; ii++)
	{	
		servo_Index[ii] = 1 << servo_Index[ii]; 
		temp = temp & (~servo_Index[ii]); //Flip since 0 turns servo off
		servo_Index[ii] = temp;
	}
	
	//Stoe into one to use in interrupt
	for (ii = 0; ii < NUM_OF_SERVOS; ii++)
	{
		servo_Priority[ii] = servo_Index[ii];
	}
		
}


//Postcondition: calculates the cycles for the timer phases corresponding to each servo.
static void calculate_Timer_Cycle(void)
{
	//Could manually set servo timer cycles to  get rid of consts.

	unsigned char ii = 0;  // temp calculations for loops
	unsigned long pulse_Calculation_Temp;
	
	//Store number of clock cycles into timer0_Servo_PWM_Width
	for ( ii = 0; ii < NUM_OF_SERVOS; ii++)
	{

		pulse_Calculation_Temp =  servo_Angle[ii];	
		
		if(pulse_Calculation_Temp > MAX_ANGLE){
			pulse_Calculation_Temp = MAX_ANGLE;
		}	
		
		pulse_Calculation_Temp = (pulse_Calculation_Temp * 1000) + MINIMUM_WIDTH_LENGTH;
		pulse_Calculation_Temp *= 10;
		pulse_Calculation_Temp /= CLOCK_CYCLE_PERIOD;//contains timer count to make pulse width for the angle for Right servo
		timer0_Servo_PWM_Width[ii] = pulse_Calculation_Temp;
	}
	
}

//Precondition: Timer values have been sorted
//Postcondition: Stores timer values into correct phases
static void set_Phases(void)
{

	volatile unsigned char zz;
	unsigned int temp;

	//Store smallest as first phase
	temp = TIMER_MAX_VALUE - timer0_Servo_PWM_Width[0]; 
	TH0_Phase[0] = temp  / 0x100; //HIGH_BYTE
	TL0_Phase[0] = temp  % 0x100; //LOW_BYTE

	//last phase 5 - largest [i;se
	temp =  TIMER_MAX_VALUE - (RELOAD_5MS - timer0_Servo_PWM_Width[NUM_OF_SERVOS - 1]); //TEMP store difference
	TH0_Phase_FirstDelay = temp / 0x100; //HIGH_BYTE
	TL0_Phase_FirstDelay = temp  % 0x100; //LOW_BYTE

	//Store rest
	for (zz = 1; zz < NUM_OF_SERVOS; zz++ )
	{
		//calculate difference, timer0_Servo_PWM_Width[zz - 1] temp storage after since not used again

		temp = TIMER_MAX_VALUE  - (timer0_Servo_PWM_Width[zz]  - timer0_Servo_PWM_Width[zz - 1]); 
		
		TH0_Phase[zz]= temp / 0x100; //HIGH BYTE
		TL0_Phase[zz] = temp  % 0x100; //LOW_BYTE
	}
		
}

#endif