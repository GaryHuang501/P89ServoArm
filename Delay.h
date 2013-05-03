//Overview: Contains delay functions in assembly (non interrupt)

#ifndef Delay_H_
#define Delay_H_

#include <p89lpc9351.h>

void wait5ms(void);
void wait30ms(void);
void wait50ms(void);
void wait1S (void);


void wait5ms (void)
{
	_asm
	mov R2, #2
L33: mov R1, #25
L32: mov R0, #184
L31: djnz R0, L31 ; 2 machine cycles-> 2*0.27126us*184=100us
    djnz R1, L32 ; 100us*25=0.0025s
    djnz R2, L33 ; 0.025s*2=50ms
    _endasm;
}

void wait30ms (void)
{
	_asm
	mov R2, #2
L13: mov R1, #150
L12: mov R0, #184
L11: djnz R0, L11 ; 2 machine cycles-> 2*0.27126us*184=100us
    djnz R1, L12 ; 100us*150=0.015s
    djnz R2, L13 ; 0.015s * 2 = 0.030s
    _endasm;
}


void wait50ms (void)
{
	_asm
	mov R2, #2
L23: mov R1, #250
L22: mov R0, #184
L21: djnz R0, L21 ; 2 machine cycles-> 2*0.27126us*184=100us
    djnz R1, L22 ; 100us*250=0.025s
    djnz R2, L23 ; 0.025s*2=50ms
    _endasm;
}

void wait1S (void)
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