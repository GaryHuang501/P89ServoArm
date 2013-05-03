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

//servo limb reference index
#define SHOULDER 3
#define BICEP 2
#define ELBOW 1
#define WRIST 0

//safety position
#define SHOULDER_ANGLE 90
#define BICEP_ANGLE 25
#define ELBOW_ANGLE 30
#define WRIST_ANGLE 150

//Set angles
idata unsigned char servo_Angle[NUM_OF_SERVOS];
idata unsigned char max_Servo_Angle[NUM_OF_SERVOS];
idata const char servo_Offset[NUM_OF_SERVOS] = {SERVO_WRIST_OFFSET, SERVO_ELBOW_OFFSET, SERVO_BICEP_OFFSET, SERVO_SHOULDER_OFFSET};


#endif