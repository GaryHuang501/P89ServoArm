//ADC for IR to detect flames

#ifndef IR_H_
#define IR_H_

#include <stdlib.h>
#include <stdio.h>
#include <p89lpc9351.h>
#include "Delay.h"

#define ADC_VALUE AD0DAT3
#define NUM_READINGS 8
#define THRESHOLD_ADC 80 //Each Step is 0.014

void init_ADC(void);
unsigned char checkForFlame();

static unsigned char getMedian(unsigned char[]);

void init_ADC(void)
{
	P2M1 |= 0x01;
	P2M1 &=0xFE;
	BURST0 = 1;
	ADMODB = CLK0; //ADC1 clock is 7.3728MHz/2
	ADINS = 0x08; // Select the P2_0 for conversion
	ADCON0 = 0x05; //Enable the converter and start immediately
}

//Return ADC value of sensor, 0 if none found
unsigned char checkForFlame()
{
	unsigned char ii = 0;
	unsigned char reading[NUM_READINGS];
	unsigned char result = 0;
	
	for(ii = 0; ii < NUM_READINGS; ii++)
	{
		reading[ii] = ADC_VALUE;
		printf_tiny(reading[ii]);
		wait5ms();
	}
	
	return getMedian(reading);
}

//Return the lower median of the 8 sensor readings 
static unsigned char getMedian(unsigned char reading[])
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
	result = reading[NUM_READINGS / 2 - 1];
	
	if (result < THRESHOLD_ADC){
		result = 0;
	}

	
	return result;
}


#endif