#ifndef Global_H_
#define Global_H_

#include <p89lpc9351.h>

#define MAX_ANGLE 175
#define FIRE_FAN_PORT P2_4

//Servo constants
#define NUM_OF_SERVOS 4 //if change this got to manually change servo offset 
#define SERVO_WRIST_OFFSET 0
#define SERVO_ELBOW_OFFSET 0
#define SERVO_BICEP_OFFSET 10
#define SERVO_SHOULDER_OFFSET 5

//servo limb reference
#define SHOULDER 3
#define BICEP 2
#define ELBOW 1
#define WRIST 0
#define FIRE_FAN_TOGGLE -1
#define NONE -2
#define SAFETY 10

//safety position
#define SHOULDER_ANGLE 90
#define BICEP_ANGLE 25
#define ELBOW_ANGLE 30
#define WRIST_ANGLE 150

//Set angles
idata unsigned char servo_Angle[NUM_OF_SERVOS];
idata unsigned char max_Servo_Angle[NUM_OF_SERVOS];
idata const char servo_Offset[NUM_OF_SERVOS] = {SERVO_WRIST_OFFSET, SERVO_ELBOW_OFFSET, SERVO_BICEP_OFFSET, SERVO_SHOULDER_OFFSET};

void Wait1S (void)
{
	_asm
	mov R2, #40
L03: mov R1, #250
L02: mov R0, #184
L01: djnz R0, L01 ; 2 machine cycles-> 2*0.27126us*184=100us
    djnz R1, L02 ; 100us*250=0.025s
    djnz R2, L03 ; 0.025s*40=1s
    _endasm;
}

#endif