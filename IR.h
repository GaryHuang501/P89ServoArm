//ADC for IR to detect flames

#ifndef IR_H_
#define IR_H_

#include <stdlib.h>
#include <stdio.h>
#include <p89lpc9351.h>
#include "Delay.h"

#define IR_PORT P2_0 

#define  READ0 AD0DAT0
#define  READ1 AD0DAT1
#define  READ2 AD0DAT2
#define  READ3 AD0DAT3

#define NUM_READINGS 8
#define THRESHOLD_ADC 123 //Each Step is 0.014

void init_ADC(void);
unsigned char checkForFlame();

static unsigned char getMedian(float[]);

void init_ADC(void)
{
	P2M1 |= 0x01;
	P2M1 &=0xFE;
	BURST0 = 1;
	ADMODB = CLK0; //ADC1 clock is 7.3728MHz/2
	ADINS = 0x08; // Select the P2_0 for conversion
	ADCON0 = 0x05; //Enable the converter and start immediately
}

//Return ADC value of sensor
unsigned char checkForFlame()
{
	unsigned char ii = 0;
	float reading[NUM_READINGS];
	
	for(ii = 0; ii < NUM_READINGS; ii++)
	{
		reading[ii] = AD0DAT3;
		wait5ms();
	}

	return getMedian(reading);
}

//Return the lower median of the 8 sensor readings 
static unsigned char getMedian(float reading[])
{
	unsigned char ii = 0;
	unsigned char jj = 0;
	unsigned char temp = 0;
	unsigned char min;
	unsigned char min_Index;
	char result = 0;
	
	//selection sort
	for (jj = 0; jj < NUM_READINGS; jj++)
	{

		min = reading[jj];
		min_Index = jj;

		for ( ii = jj; ii < NUM_READINGS; ii++)
		{
			if( reading[ii] < min)
			{
				min = reading[ii];
				min_Index = ii;
			}
		}

		temp = reading[min_Index];
		reading[min_Index] = reading[jj];
		reading[jj] = temp;
	}

	//Test if voltage value > threshold
	if (reading[NUM_READINGS / 2 - 1] < THRESHOLD_ADC){
		result = 0;
	}
	else{
		result = 1;
	}
	
	return result;
}


#endif