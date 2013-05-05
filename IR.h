//ADC for IR to detect flames

#ifndef IR_H_
#define IR_H_

#include <stdlib.h>
#include <stdio.h>
#include <p89lpc9351.h>
#include "Util.h"

#define ADC_VALUE AD0DAT2
#define NUM_READINGS 8
#define THRESHOLD_ADC 200 //Each Step is 0.014

void init_ADC(void);
unsigned char checkForFlame();

static unsigned char getMedian(unsigned char[]);

void init_ADC(void)
{
	P2M1 |= 0x020;
	P2M1 &=0xFD;
	BURST0 = 1;
	ADMODB = CLK0; //ADC1 clock is 7.3728MHz/2
	ADINS = 0x04; // Select the P2_1 for conversion
	ADCON0 = 0x05; //Enable the converter and start immediately
}

//Return ADC value of sensor, 0 if no reading about threshold value
unsigned char checkForFlame()
{
	unsigned char result = ADC_VALUE;
	
	if (result < THRESHOLD_ADC){
		result = 0;
	}

	return result;

}

/* Readings were pretty clean so took this out
unsigned char checkForFlame()
{
	// This does  X amount of readings, sorts it and returns the median
	idata unsigned char reading[NUM_READINGS];
	idata unsigned char ii = 0;
	idata unsigned char jj = 0;
	idata unsigned char result = 0;
	idata unsigned char temp = 0;
	idata unsigned char min;
	idata unsigned char min_Index;
	
	for(ii = 0; ii < NUM_READINGS; ii++)
	{
		reading[ii] = ADC_VALUE;
		wait5ms();
	}
	
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
*/
#endif