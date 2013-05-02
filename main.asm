;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #130501 (Feb 14 2012) (MSVC)
; This file was generated Wed May 01 18:48:33 2013
;--------------------------------------------------------
$name main
$optc51 --model-small
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _main
	public _init_Fans
	public _init_Serial_Port
	public _set_Angle
	public _Wait1S
	public _servo_Offset
	public _max_Servo_Set_Angle
	public _servo_Set_Angle
	public _set_Angle_PARM_2
	public _set_Pulse_Width
	public _get_Command
	public _safety_Position
	public _init_Servo
	public _set_Timer0
	public _set_Timer1
	public _init_ADC
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_ADCON0         DATA 0x8e
_ADCON1         DATA 0x97
_ADINS          DATA 0xa3
_ADMODA         DATA 0xc0
_ADMODB         DATA 0xa1
_AD0BH          DATA 0xbb
_AD0BL          DATA 0xa6
_AD0DAT0        DATA 0xc5
_AD0DAT1        DATA 0xc6
_AD0DAT2        DATA 0xc7
_AD0DAT3        DATA 0xf4
_AD1BH          DATA 0xc4
_AD1BL          DATA 0xbc
_AD1DAT0        DATA 0xd5
_AD1DAT1        DATA 0xd6
_AD1DAT2        DATA 0xd7
_AD1DAT3        DATA 0xf5
_AUXR1          DATA 0xa2
_B              DATA 0xf0
_BRGR0          DATA 0xbe
_BRGR1          DATA 0xbf
_BRGCON         DATA 0xbd
_CCCRA          DATA 0xea
_CCCRB          DATA 0xeb
_CCCRC          DATA 0xec
_CCCRD          DATA 0xed
_CMP1           DATA 0xac
_CMP2           DATA 0xad
_DEECON         DATA 0xf1
_DEEDAT         DATA 0xf2
_DEEADR         DATA 0xf3
_DIVM           DATA 0x95
_DPH            DATA 0x83
_DPL            DATA 0x82
_FMADRH         DATA 0xe7
_FMADRL         DATA 0xe6
_FMCON          DATA 0xe4
_FMDATA         DATA 0xe5
_I2ADR          DATA 0xdb
_I2CON          DATA 0xd8
_I2DAT          DATA 0xda
_I2SCLH         DATA 0xdd
_I2SCLL         DATA 0xdc
_I2STAT         DATA 0xd9
_ICRAH          DATA 0xab
_ICRAL          DATA 0xaa
_ICRBH          DATA 0xaf
_ICRBL          DATA 0xae
_IEN0           DATA 0xa8
_IEN1           DATA 0xe8
_IP0            DATA 0xb8
_IP0H           DATA 0xb7
_IP1            DATA 0xf8
_IP1H           DATA 0xf7
_KBCON          DATA 0x94
_KBMASK         DATA 0x86
_KBPATN         DATA 0x93
_OCRAH          DATA 0xef
_OCRAL          DATA 0xee
_OCRBH          DATA 0xfb
_OCRBL          DATA 0xfa
_OCRCH          DATA 0xfd
_OCRCL          DATA 0xfc
_OCRDH          DATA 0xff
_OCRDL          DATA 0xfe
_P0             DATA 0x80
_P1             DATA 0x90
_P2             DATA 0xa0
_P3             DATA 0xb0
_P0M1           DATA 0x84
_P0M2           DATA 0x85
_P1M1           DATA 0x91
_P1M2           DATA 0x92
_P2M1           DATA 0xa4
_P2M2           DATA 0xa5
_P3M1           DATA 0xb1
_P3M2           DATA 0xb2
_PCON           DATA 0x87
_PCONA          DATA 0xb5
_PSW            DATA 0xd0
_PT0AD          DATA 0xf6
_RSTSRC         DATA 0xdf
_RTCCON         DATA 0xd1
_RTCH           DATA 0xd2
_RTCL           DATA 0xd3
_SADDR          DATA 0xa9
_SADEN          DATA 0xb9
_SBUF           DATA 0x99
_SCON           DATA 0x98
_SSTAT          DATA 0xba
_SP             DATA 0x81
_SPCTL          DATA 0xe2
_SPSTAT         DATA 0xe1
_SPDAT          DATA 0xe3
_TAMOD          DATA 0x8f
_TCON           DATA 0x88
_TCR20          DATA 0xc8
_TCR21          DATA 0xf9
_TH0            DATA 0x8c
_TH1            DATA 0x8d
_TH2            DATA 0xcd
_TICR2          DATA 0xc9
_TIFR2          DATA 0xe9
_TISE2          DATA 0xde
_TL0            DATA 0x8a
_TL1            DATA 0x8b
_TL2            DATA 0xcc
_TMOD           DATA 0x89
_TOR2H          DATA 0xcf
_TOR2L          DATA 0xce
_TPCR2H         DATA 0xcb
_TPCR2L         DATA 0xca
_TRIM           DATA 0x96
_WDCON          DATA 0xa7
_WDL            DATA 0xc1
_WFEED1         DATA 0xc2
_WFEED2         DATA 0xc3
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_7          BIT 0xe7
_ACC_6          BIT 0xe6
_ACC_5          BIT 0xe5
_ACC_4          BIT 0xe4
_ACC_3          BIT 0xe3
_ACC_2          BIT 0xe2
_ACC_1          BIT 0xe1
_ACC_0          BIT 0xe0
_ADMODA_7       BIT 0xc7
_ADMODA_6       BIT 0xc6
_ADMODA_5       BIT 0xc5
_ADMODA_4       BIT 0xc4
_ADMODA_3       BIT 0xc3
_ADMODA_2       BIT 0xc2
_ADMODA_1       BIT 0xc1
_ADMODA_0       BIT 0xc0
_BNDI1          BIT 0xc7
_BURST1         BIT 0xc6
_SCC1           BIT 0xc5
_SCAN1          BIT 0xc4
_BNDI0          BIT 0xc3
_BURST0         BIT 0xc2
_SCC0           BIT 0xc1
_SCAN0          BIT 0xc0
_B_7            BIT 0xf7
_B_6            BIT 0xf6
_B_5            BIT 0xf5
_B_4            BIT 0xf4
_B_3            BIT 0xf3
_B_2            BIT 0xf2
_B_1            BIT 0xf1
_B_0            BIT 0xf0
_I2CON_7        BIT 0xdf
_I2CON_6        BIT 0xde
_I2CON_5        BIT 0xdd
_I2CON_4        BIT 0xdc
_I2CON_3        BIT 0xdb
_I2CON_2        BIT 0xda
_I2CON_1        BIT 0xd9
_I2CON_0        BIT 0xd8
_I2EN           BIT 0xde
_STA            BIT 0xdd
_STO            BIT 0xdc
_SI             BIT 0xdb
_AA             BIT 0xda
_CRSEL          BIT 0xd8
_IEN0_7         BIT 0xaf
_IEN0_6         BIT 0xae
_IEN0_5         BIT 0xad
_IEN0_4         BIT 0xac
_IEN0_3         BIT 0xab
_IEN0_2         BIT 0xaa
_IEN0_1         BIT 0xa9
_IEN0_0         BIT 0xa8
_EA             BIT 0xaf
_EWDRT          BIT 0xae
_EBO            BIT 0xad
_ES             BIT 0xac
_ESR            BIT 0xac
_ET1            BIT 0xab
_EX1            BIT 0xaa
_ET0            BIT 0xa9
_EX0            BIT 0xa8
_IEN1_7         BIT 0xef
_IEN1_6         BIT 0xee
_IEN1_5         BIT 0xed
_IEN1_4         BIT 0xec
_IEN1_3         BIT 0xeb
_IEN1_2         BIT 0xea
_IEN1_1         BIT 0xe9
_IEN1_0         BIT 0xe8
_EADEE          BIT 0xef
_EST            BIT 0xee
_ECCU           BIT 0xec
_ESPI           BIT 0xeb
_EC             BIT 0xea
_EKBI           BIT 0xe9
_EI2C           BIT 0xe8
_IP0_7          BIT 0xbf
_IP0_6          BIT 0xbe
_IP0_5          BIT 0xbd
_IP0_4          BIT 0xbc
_IP0_3          BIT 0xbb
_IP0_2          BIT 0xba
_IP0_1          BIT 0xb9
_IP0_0          BIT 0xb8
_PWDRT          BIT 0xbe
_PBO            BIT 0xbd
_PS             BIT 0xbc
_PSR            BIT 0xbc
_PT1            BIT 0xbb
_PX1            BIT 0xba
_PT0            BIT 0xb9
_PX0            BIT 0xb8
_IP1_7          BIT 0xff
_IP1_6          BIT 0xfe
_IP1_5          BIT 0xfd
_IP1_4          BIT 0xfc
_IP1_3          BIT 0xfb
_IP1_2          BIT 0xfa
_IP1_1          BIT 0xf9
_IP1_0          BIT 0xf8
_PADEE          BIT 0xff
_PST            BIT 0xfe
_PCCU           BIT 0xfc
_PSPI           BIT 0xfb
_PC             BIT 0xfa
_PKBI           BIT 0xf9
_PI2C           BIT 0xf8
_P0_7           BIT 0x87
_P0_6           BIT 0x86
_P0_5           BIT 0x85
_P0_4           BIT 0x84
_P0_3           BIT 0x83
_P0_2           BIT 0x82
_P0_1           BIT 0x81
_P0_0           BIT 0x80
_T1             BIT 0x87
_KB7            BIT 0x87
_CMP_1          BIT 0x86
_KB6            BIT 0x86
_CMPREF         BIT 0x85
_KB5            BIT 0x85
_CIN1A          BIT 0x84
_KB4            BIT 0x84
_CIN1B          BIT 0x83
_KB3            BIT 0x83
_CIN2A          BIT 0x82
_KB2            BIT 0x82
_CIN2B          BIT 0x81
_KB1            BIT 0x81
_CMP_2          BIT 0x80
_KB0            BIT 0x80
_P1_7           BIT 0x97
_P1_6           BIT 0x96
_P1_5           BIT 0x95
_P1_4           BIT 0x94
_P1_3           BIT 0x93
_P1_2           BIT 0x92
_P1_1           BIT 0x91
_P1_0           BIT 0x90
_OCC            BIT 0x97
_OCB            BIT 0x96
_RST            BIT 0x95
_INT1           BIT 0x94
_INT0           BIT 0x93
_SDA            BIT 0x93
_T0             BIT 0x92
_SCL            BIT 0x92
_RXD            BIT 0x91
_TXD            BIT 0x90
_P2_7           BIT 0xa7
_P2_6           BIT 0xa6
_P2_5           BIT 0xa5
_P2_4           BIT 0xa4
_P2_3           BIT 0xa3
_P2_2           BIT 0xa2
_P2_1           BIT 0xa1
_P2_0           BIT 0xa0
_ICA            BIT 0xa7
_OCA            BIT 0xa6
_SPICLK         BIT 0xa5
_SS             BIT 0xa4
_MISO           BIT 0xa3
_MOSI           BIT 0xa2
_OCD            BIT 0xa1
_ICB            BIT 0xa0
_P3_7           BIT 0xb7
_P3_6           BIT 0xb6
_P3_5           BIT 0xb5
_P3_4           BIT 0xb4
_P3_3           BIT 0xb3
_P3_2           BIT 0xb2
_P3_1           BIT 0xb1
_P3_0           BIT 0xb0
_XTAL1          BIT 0xb1
_XTAL2          BIT 0xb0
_PSW_7          BIT 0xd7
_PSW_6          BIT 0xd6
_PSW_5          BIT 0xd5
_PSW_4          BIT 0xd4
_PSW_3          BIT 0xd3
_PSW_2          BIT 0xd2
_PSW_1          BIT 0xd1
_PSW_0          BIT 0xd0
_CY             BIT 0xd7
_AC             BIT 0xd6
_F0             BIT 0xd5
_RS1            BIT 0xd4
_RS0            BIT 0xd3
_OV             BIT 0xd2
_F1             BIT 0xd1
_P              BIT 0xd0
_SCON_7         BIT 0x9f
_SCON_6         BIT 0x9e
_SCON_5         BIT 0x9d
_SCON_4         BIT 0x9c
_SCON_3         BIT 0x9b
_SCON_2         BIT 0x9a
_SCON_1         BIT 0x99
_SCON_0         BIT 0x98
_SM0            BIT 0x9f
_FE             BIT 0x9f
_SM1            BIT 0x9e
_SM2            BIT 0x9d
_REN            BIT 0x9c
_TB8            BIT 0x9b
_RB8            BIT 0x9a
_TI             BIT 0x99
_RI             BIT 0x98
_TCON_7         BIT 0x8f
_TCON_6         BIT 0x8e
_TCON_5         BIT 0x8d
_TCON_4         BIT 0x8c
_TCON_3         BIT 0x8b
_TCON_2         BIT 0x8a
_TCON_1         BIT 0x89
_TCON_0         BIT 0x88
_TF1            BIT 0x8f
_TR1            BIT 0x8e
_TF0            BIT 0x8d
_TR0            BIT 0x8c
_IE1            BIT 0x8b
_IT1            BIT 0x8a
_IE0            BIT 0x89
_IT0            BIT 0x88
_TCR20_7        BIT 0xcf
_TCR20_6        BIT 0xce
_TCR20_5        BIT 0xcd
_TCR20_4        BIT 0xcc
_TCR20_3        BIT 0xcb
_TCR20_2        BIT 0xca
_TCR20_1        BIT 0xc9
_TCR20_0        BIT 0xc8
_PLEEN          BIT 0xcf
_HLTRN          BIT 0xce
_HLTEN          BIT 0xcd
_ALTCD          BIT 0xcc
_ALTAB          BIT 0xcb
_TDIR2          BIT 0xca
_TMOD21         BIT 0xc9
_TMOD20         BIT 0xc8
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
	rbank1 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_TH0_Phase:
	ds 8
_TL0_Phase:
	ds 8
_TH0_Phase_FirstDelay:
	ds 2
_TL0_Phase_FirstDelay:
	ds 2
_servo_Priority:
	ds 4
_phase:
	ds 1
_calculate_Timer_Cycle_ii_1_1:
	ds 1
_calculate_Timer_Cycle_sloc0_1_0:
	ds 4
_get_Command_buffer_1_1:
	ds 4
_set_Angle_PARM_2:
	ds 2
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
_set_Servo_Priority_servo_Index_1_1:
	ds 4
_set_Servo_Priority_sloc0_1_0:
	ds 2
	rseg	R_OSEG
_set_Phases_zz_1_1:
	ds 1
	rseg	R_OSEG
_init_Servo_starting_Angles_1_1:
	ds 4
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
_timer0_Servo_PWM_Width:
	ds 8
_servo_Set_Angle:
	ds 8
_max_Servo_Set_Angle:
	ds 4
_servo_Offset:
	ds 4
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
_BODCFG         XDATA 0xffc8
_CLKCON         XDATA 0xffde
_PGACON1        XDATA 0xffe1
_PGACON1B       XDATA 0xffe4
_PGA1TRIM8X16X  XDATA 0xffe3
_PGA1TRIM2X4X   XDATA 0xffe2
_PGACON0        XDATA 0xffca
_PGACON0B       XDATA 0xffce
_PGA0TRIM8X16X  XDATA 0xffcd
_PGA0TRIM2X4X   XDATA 0xffcc
_RTCDATH        XDATA 0xffbf
_RTCDATL        XDATA 0xffbe
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
	CSEG at 0x000b
	ljmp	_Timer0_ISR
	CSEG at 0x001b
	ljmp	_Timer1_ISR
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:61: static volatile char phase = 0;
	mov	_phase,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:58: idata const char servo_Offset[NUM_OF_SERVOS] = {SERVO_WRIST_OFFSET, SERVO_ELBOW_OFFSET, SERVO_BICEP_OFFSET, SERVO_SHOULDER_OFFSET};
	mov	r0,#_servo_Offset
	mov	@r0,#0x00
	mov	r0,#(_servo_Offset + 0x0001)
	mov	@r0,#0x00
	mov	r0,#(_servo_Offset + 0x0002)
	mov	@r0,#0x0A
	mov	r0,#(_servo_Offset + 0x0003)
	mov	@r0,#0xFB
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function 'Wait1S'
;------------------------------------------------------------
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Global.h:29: void Wait1S (void)
;	-----------------------------------------
;	 function Wait1S
;	-----------------------------------------
_Wait1S:
	using	0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Global.h:38: _endasm;
	
	 mov R2, #40
	L03:
	mov R1, #250
	L02:
	mov R0, #184
	L01:
	djnz R0, L01 ; 2 machine cycles-> 2*0.27126us*184=100us
	    djnz R1, L02 ; 100us*250=0.025s
	    djnz R2, L03 ; 0.025s*40=1s
	    
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'set_Pulse_Width'
;------------------------------------------------------------
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:64: void set_Pulse_Width(void)
;	-----------------------------------------
;	 function set_Pulse_Width
;	-----------------------------------------
_set_Pulse_Width:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:66: slow_Down_Servo();
	lcall	_slow_Down_Servo
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:67: calculate_Timer_Cycle();
	lcall	_calculate_Timer_Cycle
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:68: set_Servo_Priority();
	lcall	_set_Servo_Priority
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:69: set_Phases();	
	ljmp	_set_Phases
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer0_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:75: static void Timer0_ISR (void) interrupt 1 using 0
;	-----------------------------------------
;	 function Timer0_ISR
;	-----------------------------------------
_Timer0_ISR:
	push	acc
	push	ar2
	push	ar3
	push	ar0
	push	psw
	mov	psw,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:77: TR0 = 0;
	clr	_TR0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:80: if(phase  == START_OVER) //Turn all pulses on and restart pwm generation
	mov	a,#0x14
	cjne	a,_phase,L004008?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:82: SERVO_PORTS = 0xFF;	
	mov	_P0,#0xFF
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:83: TH0 = TH0_Phase[0];
	mov	_TH0,_TH0_Phase
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:84: TL0 = TL0_Phase[0];
	mov	_TL0,_TL0_Phase
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:85: phase = 0;
	mov	_phase,#0x00
	sjmp	L004009?
L004008?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:88: else if(phase  ==  DELAY_5MS_PHASE) // == # servo - 1)
	mov	a,#0x03
	cjne	a,_phase,L004005?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:90: SERVO_PORTS = 0; //ALL OFF
	mov	_P0,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:91: TH0 = TH0_Phase_FirstDelay;
	mov	_TH0,_TH0_Phase_FirstDelay
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:92: TL0 = TL0_Phase_FirstDelay; 
	mov	_TL0,_TL0_Phase_FirstDelay
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:93: phase = DELAY_15MS_PHASE;		
	mov	_phase,#0x04
	sjmp	L004009?
L004005?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:96: else if(phase  ==  DELAY_15MS_PHASE ) // == #servo)
	mov	a,#0x04
	cjne	a,_phase,L004002?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:98: SERVO_PORTS = 0; //ALL OFF
	mov	_P0,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:99: TH0 = RELOAD_15MS_HIGH;
	mov	_TH0,#0x27
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:100: TL0 = RELOAD_15MS_LOW;
	mov	_TL0,#0xCA
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:101: phase = START_OVER;		
	mov	_phase,#0x14
	sjmp	L004009?
L004002?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:107: SERVO_PORTS = servo_Priority[phase]; 
	mov	a,_phase
	add	a,#_servo_Priority
	mov	r0,a
	mov	_P0,@r0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:108: phase++;
	inc	_phase
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:109: TH0 = TH0_Phase[phase];
	mov	a,_phase
	add	a,acc
	add	a,#_TH0_Phase
	mov	r0,a
	mov	ar2,@r0
	inc	r0
	mov	ar3,@r0
	mov	_TH0,r2
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:110: TL0 = TL0_Phase[phase];		
	mov	a,_phase
	add	a,acc
	add	a,#_TL0_Phase
	mov	r0,a
	mov	ar2,@r0
	inc	r0
	mov	ar3,@r0
	mov	_TL0,r2
L004009?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:113: TF0 = 0;
	clr	_TF0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:114: TR0 = 1;
	setb	_TR0
	pop	psw
	pop	ar0
	pop	ar3
	pop	ar2
	pop	acc
	reti
;	eliminated unneeded push/pop ar1
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer1_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:117: static void Timer1_ISR (void) interrupt 3 using 1
;	-----------------------------------------
;	 function Timer1_ISR
;	-----------------------------------------
_Timer1_ISR:
	using	1
	push	psw
	mov	psw,#0x08
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:120: }
	pop	psw
	reti
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;	eliminated unneeded push/pop acc
;------------------------------------------------------------
;Allocation info for local variables in function 'Wait20ms'
;------------------------------------------------------------
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:122: static void Wait20ms (void)
;	-----------------------------------------
;	 function Wait20ms
;	-----------------------------------------
_Wait20ms:
	using	0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:131: _endasm;
	
	 mov R2, #1
	L13:
	mov R1, #200
	L12:
	mov R0, #184
	L11:
	djnz R0, L11 ; 2 machine cycles-> 2*0.27126us*184=100us
	    djnz R1, L12 ; 100us*200=0.020s
	    djnz R2, L13 ; 0.020s * 1
	    
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'slow_Down_Servo'
;------------------------------------------------------------
;ii                        Allocated to registers r2 
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:136: static void slow_Down_Servo(void)
;	-----------------------------------------
;	 function slow_Down_Servo
;	-----------------------------------------
_slow_Down_Servo:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:141: Wait20ms();
	lcall	_Wait20ms
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:143: for (ii = 0; ii < NUM_OF_SERVOS; ii++)
	mov	r2,#0x00
L007006?:
	cjne	r2,#0x04,L007017?
L007017?:
	jnc	L007010?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:146: if (max_Servo_Set_Angle[ii] >  servo_Set_Angle[ii])
	mov	a,r2
	add	a,#_max_Servo_Set_Angle
	mov	r0,a
	mov	ar3,@r0
	mov	a,r2
	add	a,r2
	add	a,#_servo_Set_Angle
	mov	r0,a
	mov	ar4,@r0
	inc	r0
	mov	ar5,@r0
	dec	r0
	mov	r6,#0x00
	clr	c
	mov	a,r4
	subb	a,r3
	mov	a,r5
	subb	a,r6
	jnc	L007004?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:148: servo_Set_Angle[ii]++;
	inc	r4
	cjne	r4,#0x00,L007020?
	inc	r5
L007020?:
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
	dec	r0
	sjmp	L007008?
L007004?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:150: else if (max_Servo_Set_Angle[ii] <  servo_Set_Angle[ii])
	mov	ar4,@r0
	inc	r0
	mov	ar5,@r0
	dec	r0
	clr	c
	mov	a,r3
	subb	a,r4
	mov	a,r6
	subb	a,r5
	jnc	L007008?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:152: servo_Set_Angle[ii]--;
	dec	r4
	cjne	r4,#0xff,L007022?
	dec	r5
L007022?:
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
	dec	r0
L007008?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:143: for (ii = 0; ii < NUM_OF_SERVOS; ii++)
	inc	r2
	sjmp	L007006?
L007010?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'set_Servo_Priority'
;------------------------------------------------------------
;servo_Index               Allocated with name '_set_Servo_Priority_servo_Index_1_1'
;ii                        Allocated to registers r2 
;jj                        Allocated to registers 
;min_Index                 Allocated to registers r5 
;min                       Allocated to registers r3 r4 
;temp                      Allocated to registers r3 r4 
;sloc0                     Allocated with name '_set_Servo_Priority_sloc0_1_0'
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:160: static void set_Servo_Priority(void)
;	-----------------------------------------
;	 function set_Servo_Priority
;	-----------------------------------------
_set_Servo_Priority:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:170: for (ii = 0; ii < NUM_OF_SERVOS; ii++)
	mov	r2,#0x00
L008003?:
	cjne	r2,#0x04,L008041?
L008041?:
	jnc	L008006?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:172: servo_Index[ii] = ii;
	mov	a,r2
	add	a,#_set_Servo_Priority_servo_Index_1_1
	mov	r0,a
	mov	@r0,ar2
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:170: for (ii = 0; ii < NUM_OF_SERVOS; ii++)
	inc	r2
	sjmp	L008003?
L008006?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:176: for (jj = 0; jj < NUM_OF_SERVOS; jj++)
	mov	r2,#0x00
L008011?:
	cjne	r2,#0x04,L008043?
L008043?:
	jc	L008044?
	ljmp	L008014?
L008044?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:179: min = timer0_Servo_PWM_Width[jj];
	mov	a,r2
	add	a,r2
	add	a,#_timer0_Servo_PWM_Width
	mov	r0,a
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
	dec	r0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:180: min_Index = jj;
	mov	ar5,r2
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:182: for ( ii = jj; ii < NUM_OF_SERVOS; ii++)
	mov	ar6,r2
L008007?:
	cjne	r6,#0x04,L008045?
L008045?:
	jnc	L008010?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:185: if( timer0_Servo_PWM_Width[ii] < min)
	mov	a,r6
	add	a,r6
	mov	r7,a
	add	a,#_timer0_Servo_PWM_Width
	mov	r0,a
	mov	_set_Servo_Priority_sloc0_1_0,@r0
	inc	r0
	mov	(_set_Servo_Priority_sloc0_1_0 + 1),@r0
	dec	r0
	clr	c
	mov	a,_set_Servo_Priority_sloc0_1_0
	subb	a,r3
	mov	a,(_set_Servo_Priority_sloc0_1_0 + 1)
	subb	a,r4
	jnc	L008009?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:187: min = timer0_Servo_PWM_Width[ii];
	mov	r3,_set_Servo_Priority_sloc0_1_0
	mov	r4,(_set_Servo_Priority_sloc0_1_0 + 1)
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:188: min_Index = ii;
	mov	ar5,r6
L008009?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:182: for ( ii = jj; ii < NUM_OF_SERVOS; ii++)
	inc	r6
	sjmp	L008007?
L008010?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:193: temp = timer0_Servo_PWM_Width[jj];
	mov	a,r2
	add	a,r2
	add	a,#_timer0_Servo_PWM_Width
	mov	r0,a
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
	dec	r0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:194: timer0_Servo_PWM_Width[jj] = timer0_Servo_PWM_Width[min_Index]; 
	mov	a,r5
	add	a,r5
	add	a,#_timer0_Servo_PWM_Width
	mov	r1,a
	mov	ar6,@r1
	inc	r1
	mov	ar7,@r1
	dec	r1
	mov	@r0,ar6
	inc	r0
	mov	@r0,ar7
	dec	r0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:195: timer0_Servo_PWM_Width[min_Index] = temp; 
	mov	@r1,ar3
	inc	r1
	mov	@r1,ar4
	dec	r1
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:197: temp = servo_Index[jj];
	mov	a,r2
	add	a,#_set_Servo_Priority_servo_Index_1_1
	mov	r0,a
	mov	ar6,@r0
	mov	ar3,r6
	mov	r4,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:198: servo_Index[jj] = servo_Index[min_Index];
	mov	a,r5
	add	a,#_set_Servo_Priority_servo_Index_1_1
	mov	r1,a
	mov	ar5,@r1
	mov	@r0,ar5
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:199: servo_Index[min_Index] = temp;
	mov	ar5,r3
	mov	@r1,ar5
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:176: for (jj = 0; jj < NUM_OF_SERVOS; jj++)
	inc	r2
	ljmp	L008011?
L008014?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:202: temp = 0xFF;
	mov	r3,#0xFF
	mov	r4,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:206: for (ii = 0; ii < NUM_OF_SERVOS; ii++)
	mov	r2,#0x00
L008015?:
	cjne	r2,#0x04,L008048?
L008048?:
	jnc	L008018?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:208: servo_Index[ii] = 1 << servo_Index[ii]; 
	mov	a,r2
	add	a,#_set_Servo_Priority_servo_Index_1_1
	mov	r0,a
	mov	ar5,@r0
	mov	b,r5
	inc	b
	mov	a,#0x01
	sjmp	L008052?
L008050?:
	add	a,acc
L008052?:
	djnz	b,L008050?
	mov	r5,a
	mov	@r0,a
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:209: temp = temp & (~servo_Index[ii]); //Flip since 0 turns servo off
	mov	r6,#0x00
	mov	a,r5
	cpl	a
	mov	r5,a
	mov	a,r6
	cpl	a
	mov	r6,a
	mov	a,r5
	anl	ar3,a
	mov	a,r6
	anl	ar4,a
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:210: servo_Index[ii] = temp;
	mov	ar5,r3
	mov	@r0,ar5
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:206: for (ii = 0; ii < NUM_OF_SERVOS; ii++)
	inc	r2
	sjmp	L008015?
L008018?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:214: for (ii = 0; ii < NUM_OF_SERVOS; ii++)
	mov	r2,#0x00
L008019?:
	cjne	r2,#0x04,L008053?
L008053?:
	jnc	L008023?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:216: servo_Priority[ii] = servo_Index[ii];
	mov	a,r2
	add	a,#_servo_Priority
	mov	r0,a
	mov	a,r2
	add	a,#_set_Servo_Priority_servo_Index_1_1
	mov	r1,a
	mov	ar3,@r1
	mov	@r0,ar3
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:214: for (ii = 0; ii < NUM_OF_SERVOS; ii++)
	inc	r2
	sjmp	L008019?
L008023?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'calculate_Timer_Cycle'
;------------------------------------------------------------
;ii                        Allocated with name '_calculate_Timer_Cycle_ii_1_1'
;pulse_Calculation_Temp    Allocated to registers r3 r4 r5 r6 
;sloc0                     Allocated with name '_calculate_Timer_Cycle_sloc0_1_0'
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:223: static void calculate_Timer_Cycle(void)
;	-----------------------------------------
;	 function calculate_Timer_Cycle
;	-----------------------------------------
_calculate_Timer_Cycle:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:231: for ( ii = 0; ii < NUM_OF_SERVOS; ii++)
	mov	_calculate_Timer_Cycle_ii_1_1,#0x00
L009003?:
	mov	a,#0x100 - 0x04
	add	a,_calculate_Timer_Cycle_ii_1_1
	jnc	L009013?
	ret
L009013?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:234: pulse_Calculation_Temp = servo_Set_Angle[ii] + servo_Offset[ii];	
	mov	a,_calculate_Timer_Cycle_ii_1_1
	add	a,_calculate_Timer_Cycle_ii_1_1
	add	a,#_servo_Set_Angle
	mov	r0,a
	mov	ar3,@r0
	inc	r0
	mov	ar4,@r0
	dec	r0
	mov	a,_calculate_Timer_Cycle_ii_1_1
	add	a,#_servo_Offset
	mov	r0,a
	mov	a,@r0
	mov	r5,a
	rlc	a
	subb	a,acc
	mov	r6,a
	mov	a,r5
	add	a,r3
	mov	r3,a
	mov	a,r6
	addc	a,r4
	mov	r4,a
	mov	r5,#0x00
	mov	r6,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:235: if(pulse_Calculation_Temp > MAX_ANGLE){
	clr	c
	mov	a,#0xAF
	subb	a,r3
	clr	a
	subb	a,r4
	clr	a
	subb	a,r5
	clr	a
	subb	a,r6
	jnc	L009002?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:236: pulse_Calculation_Temp = MAX_ANGLE;
	mov	r3,#0xAF
	mov	r4,#0x00
	mov	r5,#0x00
	mov	r6,#0x00
L009002?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:239: pulse_Calculation_Temp = (pulse_Calculation_Temp * 1000) + MINIMUM_WIDTH_LENGTH;
	mov	__mullong_PARM_2,r3
	mov	(__mullong_PARM_2 + 1),r4
	mov	(__mullong_PARM_2 + 2),r5
	mov	(__mullong_PARM_2 + 3),r6
	mov	dptr,#0x03E8
	clr	a
	mov	b,a
	lcall	__mullong
	mov	_calculate_Timer_Cycle_sloc0_1_0,dpl
	mov	(_calculate_Timer_Cycle_sloc0_1_0 + 1),dph
	mov	(_calculate_Timer_Cycle_sloc0_1_0 + 2),b
	mov	(_calculate_Timer_Cycle_sloc0_1_0 + 3),a
	mov	a,#0x60
	add	a,_calculate_Timer_Cycle_sloc0_1_0
	mov	r3,a
	mov	a,#0xEA
	addc	a,(_calculate_Timer_Cycle_sloc0_1_0 + 1)
	mov	r4,a
	clr	a
	addc	a,(_calculate_Timer_Cycle_sloc0_1_0 + 2)
	mov	r5,a
	clr	a
	addc	a,(_calculate_Timer_Cycle_sloc0_1_0 + 3)
	mov	r6,a
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:240: pulse_Calculation_Temp *= 10;
	mov	__mullong_PARM_2,r3
	mov	(__mullong_PARM_2 + 1),r4
	mov	(__mullong_PARM_2 + 2),r5
	mov	(__mullong_PARM_2 + 3),r6
	mov	dptr,#(0x0A&0x00ff)
	clr	a
	mov	b,a
	lcall	__mullong
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:241: pulse_Calculation_Temp /= CLOCK_CYCLE_PERIOD;//contains timer count to make pulse width for the angle for Right servo
	mov	__divulong_PARM_2,#0x0F
	mov	(__divulong_PARM_2 + 1),#0x01
	mov	(__divulong_PARM_2 + 2),#0x00
	mov	(__divulong_PARM_2 + 3),#0x00
	lcall	__divulong
	mov	r3,dpl
	mov	r4,dph
	mov	r5,b
	mov	r6,a
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:242: timer0_Servo_PWM_Width[ii] = pulse_Calculation_Temp;
	mov	a,_calculate_Timer_Cycle_ii_1_1
	add	a,_calculate_Timer_Cycle_ii_1_1
	mov	r2,a
	add	a,#_timer0_Servo_PWM_Width
	mov	r0,a
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	dec	r0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:231: for ( ii = 0; ii < NUM_OF_SERVOS; ii++)
	inc	_calculate_Timer_Cycle_ii_1_1
	ljmp	L009003?
;------------------------------------------------------------
;Allocation info for local variables in function 'set_Phases'
;------------------------------------------------------------
;zz                        Allocated with name '_set_Phases_zz_1_1'
;temp                      Allocated to registers r2 r3 
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:249: static void set_Phases(void)
;	-----------------------------------------
;	 function set_Phases
;	-----------------------------------------
_set_Phases:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:256: temp = TIMER_MAX_VALUE - timer0_Servo_PWM_Width[0]; 
	mov	r0,#_timer0_Servo_PWM_Width
	mov	ar2,@r0
	inc	r0
	mov	ar3,@r0
	clr	a
	mov	r4,a
	mov	r5,a
	mov	a,#0xFF
	clr	c
	subb	a,r2
	mov	r2,a
	mov	a,#0xFF
	subb	a,r3
	mov	r3,a
	clr	a
	subb	a,r4
	clr	a
	subb	a,r5
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:257: TH0_Phase[0] = temp  / 0x100; //HIGH_BYTE
	mov	ar4,r3
	mov	r5,#0x00
	mov	_TH0_Phase,r4
	mov	(_TH0_Phase + 1),r5
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:258: TL0_Phase[0] = temp  % 0x100; //LOW_BYTE
	mov	ar4,r2
	mov	r5,#0x00
	mov	_TL0_Phase,r4
	mov	(_TL0_Phase + 1),r5
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:261: temp =  TIMER_MAX_VALUE - (RELOAD_5MS - timer0_Servo_PWM_Width[NUM_OF_SERVOS - 1]); //TEMP store difference
	mov	r0,#(_timer0_Servo_PWM_Width + 0x0006)
	mov	ar4,@r0
	inc	r0
	mov	ar5,@r0
	clr	a
	mov	r6,a
	mov	r7,a
	mov	a,#0x12
	clr	c
	subb	a,r4
	mov	r4,a
	mov	a,#0x48
	subb	a,r5
	mov	r5,a
	clr	a
	subb	a,r6
	mov	r6,a
	clr	a
	subb	a,r7
	mov	r7,a
	mov	a,#0xFF
	clr	c
	subb	a,r4
	mov	r4,a
	mov	a,#0xFF
	subb	a,r5
	mov	r5,a
	clr	a
	subb	a,r6
	mov	r6,a
	clr	a
	subb	a,r7
	mov	r7,a
	mov	ar2,r4
	mov	ar3,r5
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:262: TH0_Phase_FirstDelay = temp / 0x100; //HIGH_BYTE
	mov	_TH0_Phase_FirstDelay,r3
	mov	(_TH0_Phase_FirstDelay + 1),#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:263: TL0_Phase_FirstDelay = temp  % 0x100; //LOW_BYTE
	mov	_TL0_Phase_FirstDelay,r2
	mov	(_TL0_Phase_FirstDelay + 1),#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:266: for (zz = 1; zz < NUM_OF_SERVOS; zz++ )
	mov	_set_Phases_zz_1_1,#0x01
L010001?:
	mov	a,#0x100 - 0x04
	add	a,_set_Phases_zz_1_1
	jc	L010005?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:270: temp = TIMER_MAX_VALUE  - (timer0_Servo_PWM_Width[zz]  - timer0_Servo_PWM_Width[zz - 1]); 
	mov	a,_set_Phases_zz_1_1
	add	a,acc
	add	a,#_timer0_Servo_PWM_Width
	mov	r0,a
	mov	ar4,@r0
	inc	r0
	mov	ar5,@r0
	dec	r0
	mov	a,_set_Phases_zz_1_1
	dec	a
	add	a,acc
	add	a,#_timer0_Servo_PWM_Width
	mov	r0,a
	mov	ar6,@r0
	inc	r0
	mov	ar7,@r0
	dec	r0
	mov	a,r4
	clr	c
	subb	a,r6
	mov	r4,a
	mov	a,r5
	subb	a,r7
	mov	r5,a
	clr	a
	mov	r6,a
	mov	r7,a
	mov	a,#0xFF
	clr	c
	subb	a,r4
	mov	r4,a
	mov	a,#0xFF
	subb	a,r5
	mov	r5,a
	clr	a
	subb	a,r6
	mov	r6,a
	clr	a
	subb	a,r7
	mov	r7,a
	mov	ar2,r4
	mov	ar3,r5
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:272: TH0_Phase[zz]= temp / 0x100; //HIGH BYTE
	mov	a,_set_Phases_zz_1_1
	add	a,acc
	add	a,#_TH0_Phase
	mov	r0,a
	mov	ar4,r3
	mov	r5,#0x00
	mov	@r0,ar4
	inc	r0
	mov	@r0,ar5
	dec	r0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:273: TL0_Phase[zz] = temp  % 0x100; //LOW_BYTE
	mov	a,_set_Phases_zz_1_1
	add	a,acc
	mov	r4,a
	add	a,#_TL0_Phase
	mov	r0,a
	mov	r3,#0x00
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
	dec	r0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Servo_PWM.h:266: for (zz = 1; zz < NUM_OF_SERVOS; zz++ )
	inc	_set_Phases_zz_1_1
	sjmp	L010001?
L010005?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'get_Command'
;------------------------------------------------------------
;angle                     Allocated to registers r2 r3 
;buffer                    Allocated with name '_get_Command_buffer_1_1'
;command                   Allocated to registers r4 
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:20: void get_Command(void)
;	-----------------------------------------
;	 function get_Command
;	-----------------------------------------
_get_Command:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:22: unsigned int angle = 0;
	mov	r2,#0x00
	mov	r3,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:24: char command = NONE;
	mov	r4,#0xFE
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:26: gets(buffer);
	mov	dptr,#_get_Command_buffer_1_1
	mov	b,#0x40
	push	ar2
	push	ar3
	push	ar4
	lcall	_gets
	pop	ar4
	pop	ar3
	pop	ar2
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:27: RI = 0;
	clr	_RI
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:29: if(buffer[0] != 'f' && buffer[0] != 'x'){
	mov	r5,_get_Command_buffer_1_1
	cjne	r5,#0x66,L011040?
	sjmp	L011005?
L011040?:
	cjne	r5,#0x78,L011041?
	sjmp	L011005?
L011041?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:30: if(strlen(buffer) < 2){
	mov	dptr,#_get_Command_buffer_1_1
	mov	b,#0x40
	push	ar4
	lcall	_strlen
	mov	r5,dpl
	mov	r6,dph
	pop	ar4
	clr	c
	mov	a,r5
	subb	a,#0x02
	mov	a,r6
	subb	a,#0x00
	jnc	L011002?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:31: return;
	ret
L011002?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:34: angle = atoi(buffer + 1);
	mov	dptr,#(_get_Command_buffer_1_1 + 0x0001)
	mov	b,#0x40
	push	ar4
	lcall	_atoi
	mov	r2,dpl
	mov	r3,dph
	pop	ar4
L011005?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:39: switch(buffer[0])
	mov	r5,_get_Command_buffer_1_1
	cjne	r5,#0x62,L011043?
	sjmp	L011008?
L011043?:
	cjne	r5,#0x65,L011044?
	sjmp	L011012?
L011044?:
	cjne	r5,#0x66,L011045?
	sjmp	L011014?
L011045?:
	cjne	r5,#0x73,L011046?
	sjmp	L011007?
L011046?:
	cjne	r5,#0x77,L011047?
	sjmp	L011013?
L011047?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:41: case('s'):
	cjne	r5,#0x78,L011016?
	sjmp	L011015?
L011007?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:42: command = SHOULDER;	
	mov	r4,#0x03
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:43: break;
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:44: case('b'):					
	sjmp	L011016?
L011008?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:45: if(angle <= 135){
	clr	c
	mov	a,#0x87
	subb	a,r2
	clr	a
	subb	a,r3
	jc	L011010?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:46: command = BICEP;
	mov	r4,#0x02
	sjmp	L011016?
L011010?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:49: printf_tiny("Bicep max angle of 145");
	push	ar2
	push	ar3
	push	ar4
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	lcall	_printf_tiny
	dec	sp
	dec	sp
	pop	ar4
	pop	ar3
	pop	ar2
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:51: break;
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:52: case('e'):
	sjmp	L011016?
L011012?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:53: command = ELBOW;
	mov	r4,#0x01
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:54: angle = 180 - angle;
	mov	a,#0xB4
	clr	c
	subb	a,r2
	mov	r2,a
	clr	a
	subb	a,r3
	mov	r3,a
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:55: break;
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:56: case('w'):
	sjmp	L011016?
L011013?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:57: command = WRIST;
	mov	r4,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:58: break;
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:59: case('f'):
	sjmp	L011016?
L011014?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:60: command = FAN;
	mov	r4,#0xFF
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:61: break;
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:62: case('x'):
	sjmp	L011016?
L011015?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:63: command = SAFETY;
	mov	r4,#0x0A
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:65: }
L011016?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:67: if(command == FAN){
	cjne	r4,#0xFF,L011023?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:68: P2_4 ^= 1;
	cpl	_P2_4
	ret
L011023?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:70: else if(command == SAFETY){
	cjne	r4,#0x0A,L011020?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:71: safety_Position();
	ljmp	_safety_Position
L011020?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:73: else if(command != NONE){
	cjne	r4,#0xFE,L011054?
	ret
L011054?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:74: max_Servo_Set_Angle[command % NUM_OF_SERVOS] = angle;
	mov	a,r4
	mov	c,acc.7
	anl	a,#0x03
	jz	L011055?
	jnc	L011055?
	orl	a,#0xfc
L011055?:
	add	a,#_max_Servo_Set_Angle
	mov	r0,a
	mov	@r0,ar2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'safety_Position'
;------------------------------------------------------------
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:79: void safety_Position(void){
;	-----------------------------------------
;	 function safety_Position
;	-----------------------------------------
_safety_Position:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:81: max_Servo_Set_Angle[SHOULDER] = SHOULDER_ANGLE;
	mov	r0,#(_max_Servo_Set_Angle + 0x0003)
	mov	@r0,#0x5A
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:82: Wait1S();
	lcall	_Wait1S
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:83: Wait1S();
	lcall	_Wait1S
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:84: max_Servo_Set_Angle[WRIST] = WRIST_ANGLE;
	mov	r0,#_max_Servo_Set_Angle
	mov	@r0,#0x8C
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:85: Wait1S();
	lcall	_Wait1S
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:86: Wait1S();
	lcall	_Wait1S
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:87: max_Servo_Set_Angle[ELBOW] = 100; //intermediate angle
	mov	r0,#(_max_Servo_Set_Angle + 0x0001)
	mov	@r0,#0x64
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:88: Wait1S();
	lcall	_Wait1S
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:89: Wait1S();
	lcall	_Wait1S
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:90: max_Servo_Set_Angle[BICEP] = BICEP_ANGLE;
	mov	r0,#(_max_Servo_Set_Angle + 0x0002)
	mov	@r0,#0x30
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:91: Wait1S();
	lcall	_Wait1S
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:92: Wait1S();
	lcall	_Wait1S
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Serial.h:93: max_Servo_Set_Angle[ELBOW] = ELBOW_ANGLE;
	mov	r0,#(_max_Servo_Set_Angle + 0x0001)
	mov	@r0,#0xAA
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'set_Angle'
;------------------------------------------------------------
;angle                     Allocated with name '_set_Angle_PARM_2'
;servo_Index               Allocated to registers r2 
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Positioning.h:4: void set_Angle(unsigned char servo_Index, unsigned int angle)
;	-----------------------------------------
;	 function set_Angle
;	-----------------------------------------
_set_Angle:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Positioning.h:6: if(servo_Offset[servo_Index] < 0 && abs(servo_Offset[servo_Index]) > angle){
	mov	a,dpl
	mov	r2,a
	add	a,#_servo_Offset
	mov	r0,a
	mov	a,@r0
	mov	r3,a
	jnb	acc.7,L013005?
	mov	a,r3
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	dpl,r3
	mov	dph,r4
	push	ar2
	lcall	_abs
	mov	r3,dpl
	mov	r4,dph
	pop	ar2
	clr	c
	mov	a,_set_Angle_PARM_2
	subb	a,r3
	mov	a,(_set_Angle_PARM_2 + 1)
	subb	a,r4
	jnc	L013005?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Positioning.h:7: angle = 0;
	clr	a
	mov	_set_Angle_PARM_2,a
	mov	(_set_Angle_PARM_2 + 1),a
	sjmp	L013006?
L013005?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Positioning.h:9: else if( (servo_Offset[servo_Index] + angle) > MAX_ANGLE){
	mov	a,r2
	add	a,#_servo_Offset
	mov	r0,a
	mov	a,@r0
	mov	r3,a
	rlc	a
	subb	a,acc
	mov	r4,a
	mov	a,_set_Angle_PARM_2
	add	a,r3
	mov	r5,a
	mov	a,(_set_Angle_PARM_2 + 1)
	addc	a,r4
	mov	r6,a
	clr	c
	mov	a,#0xAF
	subb	a,r5
	clr	a
	subb	a,r6
	jnc	L013002?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Positioning.h:10: angle = MAX_ANGLE;
	mov	_set_Angle_PARM_2,#0xAF
	clr	a
	mov	(_set_Angle_PARM_2 + 1),a
	sjmp	L013006?
L013002?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Positioning.h:13: angle += servo_Offset[servo_Index];
	mov	a,r3
	add	a,_set_Angle_PARM_2
	mov	_set_Angle_PARM_2,a
	mov	a,r4
	addc	a,(_set_Angle_PARM_2 + 1)
	mov	(_set_Angle_PARM_2 + 1),a
L013006?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\/Positioning.h:16: max_Servo_Set_Angle[servo_Index] = angle;
	mov	a,r2
	add	a,#_max_Servo_Set_Angle
	mov	r0,a
	mov	r2,_set_Angle_PARM_2
	mov	@r0,ar2
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'init_Servo'
;------------------------------------------------------------
;ii                        Allocated to registers r2 
;starting_Angles           Allocated with name '_init_Servo_starting_Angles_1_1'
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:20: void init_Servo(void){
;	-----------------------------------------
;	 function init_Servo
;	-----------------------------------------
_init_Servo:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:23: unsigned char starting_Angles[] = {WRIST_ANGLE + SERVO_WRIST_OFFSET, ELBOW_ANGLE + SERVO_ELBOW_OFFSET,
	mov	_init_Servo_starting_Angles_1_1,#0x8C
	mov	(_init_Servo_starting_Angles_1_1 + 0x0001),#0xAA
	mov	(_init_Servo_starting_Angles_1_1 + 0x0002),#0x3A
	mov	(_init_Servo_starting_Angles_1_1 + 0x0003),#0x55
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:26: P0M1 = 0x00;//set low to 0 and high to 1 for output
	mov	_P0M1,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:27: P0M2 = 0xFF;
	mov	_P0M2,#0xFF
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:28: P0 = 0;
	mov	_P0,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:30: for(ii =0; ii < NUM_OF_SERVOS; ii++){
	mov	r2,#0x00
L014001?:
	cjne	r2,#0x04,L014010?
L014010?:
	jnc	L014005?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:31: max_Servo_Set_Angle[ii] = starting_Angles[ii];
	mov	a,r2
	add	a,#_max_Servo_Set_Angle
	mov	r0,a
	mov	a,r2
	add	a,#_init_Servo_starting_Angles_1_1
	mov	r1,a
	mov	ar3,@r1
	mov	@r0,ar3
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:32: servo_Set_Angle[ii] = starting_Angles[ii];
	mov	a,r2
	add	a,r2
	add	a,#_servo_Set_Angle
	mov	r0,a
	mov	r4,#0x00
	mov	@r0,ar3
	inc	r0
	mov	@r0,ar4
	dec	r0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:30: for(ii =0; ii < NUM_OF_SERVOS; ii++){
	inc	r2
	sjmp	L014001?
L014005?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'set_Timer0'
;------------------------------------------------------------
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:36: void set_Timer0 (void) 
;	-----------------------------------------
;	 function set_Timer0
;	-----------------------------------------
_set_Timer0:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:38: TR0 = 0; // Stop timer 0 
	clr	_TR0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:39: TL0 = 0;
	mov	_TL0,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:40: TH0 = 0; 
	mov	_TH0,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:41: TMOD = (TMOD|0x01);
	orl	_TMOD,#0x01
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:42: ET0 = 1; // Enable timer 0 interrupt 
	setb	_ET0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:43: EA = 1; // Enable global interrupts 
	setb	_EA
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:44: TR0 = 1; // Start timer 0 
	setb	_TR0
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'set_Timer1'
;------------------------------------------------------------
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:47: void set_Timer1 (void) 
;	-----------------------------------------
;	 function set_Timer1
;	-----------------------------------------
_set_Timer1:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:49: TR1 = 0; // Stop timer 1 
	clr	_TR1
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:50: TL1 = 0;
	mov	_TL1,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:51: TH1 = 0; 
	mov	_TH1,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:52: TMOD = (TMOD|0x10);
	orl	_TMOD,#0x10
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:53: ET1 = 1; // Enable timer 1 interrupt 
	setb	_ET1
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:54: EA = 1; // Enable global interrupts 
	setb	_EA
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:55: TR1 = 1; // Start timer 1  
	setb	_TR1
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'init_Serial_Port'
;------------------------------------------------------------
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:59: void init_Serial_Port(void)
;	-----------------------------------------
;	 function init_Serial_Port
;	-----------------------------------------
_init_Serial_Port:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:61: BRGCON = 0x00; //Make sure the baud rate generator is off
	mov	_BRGCON,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:62: BRGR1 = ((XTAL/BAUD)-16)/0x100;
	mov	_BRGR1,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:63: BRGR0 = ((XTAL/BAUD)-16)%0x100;
	mov	_BRGR0,#0x30
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:64: BRGCON = 0x03; //Turn-on the baud rate generator
	mov	_BRGCON,#0x03
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:65: SCON = 0x52; //Serial port in mode 1, ren, txrdy, rxempty
	mov	_SCON,#0x52
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:66: P1M1 = 0x00; //Enable pins RxD and Txd
	mov	_P1M1,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:67: P1M2 = 0x00; //Enable pins RxD and Txd
	mov	_P1M2,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'init_ADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:70: void init_ADC(void)
;	-----------------------------------------
;	 function init_ADC
;	-----------------------------------------
_init_ADC:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:74: P1M1 = (0xE0|P1M1);
	orl	_P1M1,#0xE0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:75: P1M2 = (0x1F&P1M2);
	anl	_P1M2,#0x1F
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:77: BURST0 = 1;
	setb	_BURST0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:78: ADMODB = CLK0; //ADC1 clock is 7.3728MHz/2
	mov	_ADMODB,#0x20
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:79: ADINS  = 0x08; // Select the four channels for conversion
	mov	_ADINS,#0x08
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:80: ADCON0 = 0x05;//Enable the converter and start immediately
	mov	_ADCON0,#0x05
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'init_Fans'
;------------------------------------------------------------
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:84: void init_Fans(void)
;	-----------------------------------------
;	 function init_Fans
;	-----------------------------------------
_init_Fans:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:86: P2M1 = 0x00;
	mov	_P2M1,#0x00
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:87: P2M2 = 0xFF;
	mov	_P2M2,#0xFF
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:89: P2_0 = 1;
	setb	_P2_0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:90: P2_1 = 1;
	setb	_P2_1
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:91: P2_2 = 1;
	setb	_P2_2
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:92: P2_3 = 1;
	setb	_P2_3
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:93: P2_4 = 0;
	clr	_P2_4
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;------------------------------------------------------------
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:96: void main(void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:98: EA = 0;
	clr	_EA
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:99: init_Servo();
	lcall	_init_Servo
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:100: set_Pulse_Width();
	lcall	_set_Pulse_Width
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:101: set_Timer0();
	lcall	_set_Timer0
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:102: set_Timer1();
	lcall	_set_Timer1
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:103: init_Serial_Port();
	lcall	_init_Serial_Port
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:104: Wait1S();
	lcall	_Wait1S
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:105: init_Fans();
	lcall	_init_Fans
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:106: printf_tiny("Ready for commands!\n");
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	lcall	_printf_tiny
	dec	sp
	dec	sp
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:108: while(1)
L020004?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:111: if (RI == 1)
	jnb	_RI,L020002?
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:113: get_Command();
	lcall	_get_Command
L020002?:
;	D:\Gary\Workspace\UBC\Dropbox\Self Projects\P89Servo Arm\main.c:116: set_Pulse_Width();
	lcall	_set_Pulse_Width
	sjmp	L020004?
	rseg R_CSEG

	rseg R_CONST
__str_0:
	db 'Bicep max angle of 145'
	db 0x00
__str_1:
	db 'Ready for commands!'
	db 0x0A
	db 0x00

	rseg R_XINIT

	CSEG

end
