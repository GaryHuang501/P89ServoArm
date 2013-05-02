#ifndef Positioning_H_
#define Positioning_H_

void set_Angle(unsigned char servo_Index, unsigned int angle)
{
	if(servo_Offset[servo_Index] < 0 && abs(servo_Offset[servo_Index]) > angle){
		angle = 0;
	}
	else if( (servo_Offset[servo_Index] + angle) > MAX_ANGLE){
		angle = MAX_ANGLE;
	}
	else{
		angle += servo_Offset[servo_Index];
	}
	
	max_Servo_Set_Angle[servo_Index] = angle;
	
}

#endif