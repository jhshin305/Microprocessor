
	.cdecls C, LIST, "Compiler.h"
;------------------------------------------------
;		.data
;------------------------------------------------
GPIO_BASE			.equ	0x40000000
NVIC_BASE			.equ	0xe0000000
RCGCGPIO			.equ	0x608
GPIOHBCTL			.equ	0x06C
GPIODIR				.equ	0x400
GPIOAFSEL			.equ	0x420
GPIOPUR				.equ	0x510
GPIODEN				.equ	0x51C
GPIOAMSEL			.equ	0x528
GPIOPCTL			.equ	0x52C
GPIOLOCK			.equ	0x520
GPIOCR				.equ	0x524
GPIODR8R			.equ	0x508

GPIODATA			.equ	0x000
EN3					.equ	0x10C
GPIOIM				.equ	0x410
GPIOICR				.equ	0x41C
GPIOIS				.equ	0x404
GPIOIBE				.equ	0x408
GPIOIEV				.equ	0x40C
GPIOMIS				.equ	0x418

SW_UP				.equ	0x1E
SW_DOWN				.equ	0x1D
;--------------------------------------------------
             .text                           ; Program Start
             .global RESET                   ; Define entry point
             .align	4
			 .sect ".text"

             .global Switch_Init
             .global Switch_Input
			 .global num_1
			 .global num_3
			 .global stack
_stack:
;------------------------------------------------------------------------------
            			 ; Interrupt Vectors
;------------------------------------------------------------------------------
						.sect	".intvecs"
						.align	4
						.field	IntDefaultHandler,32		; g_pfnVectors[0] @ 0
						.field	IntDefaultHandler,32		; g_pfnVectors[1] @ 32
						.field	IntDefaultHandler,32		; g_pfnVectors[2] @ 64
						.field	IntDefaultHandler,32		; g_pfnVectors[3] @ 96
						.field	IntDefaultHandler,32		; g_pfnVectors[4] @ 128
						.field	IntDefaultHandler,32		; g_pfnVectors[5] @ 160
						.field	IntDefaultHandler,32		; g_pfnVectors[6] @ 192
						.field	0,32			; g_pfnVectors[7] @ 224
						.field	0,32			; g_pfnVectors[8] @ 256
						.field	0,32			; g_pfnVectors[9] @ 288
						.field	0,32			; g_pfnVectors[10] @ 320
						.field	IntDefaultHandler,32		; g_pfnVectors[11] @ 352
						.field	IntDefaultHandler,32		; g_pfnVectors[12] @ 384
						.field	0,32			; g_pfnVectors[13] @ 416
						.field	IntDefaultHandler,32		; g_pfnVectors[14] @ 448
						.field	IntDefaultHandler,32		; g_pfnVectors[15] @ 480
						.field	IntDefaultHandler,32		; g_pfnVectors[16] @ 512
						.field	IntDefaultHandler,32		; g_pfnVectors[17] @ 544
						.field	IntDefaultHandler,32		; g_pfnVectors[18] @ 576
						.field	IntDefaultHandler,32		; g_pfnVectors[19] @ 608
						.field	IntDefaultHandler,32		; g_pfnVectors[20] @ 640
						.field	IntDefaultHandler,32		; g_pfnVectors[21] @ 672
						.field	IntDefaultHandler,32		; g_pfnVectors[22] @ 704
						.field	IntDefaultHandler,32		; g_pfnVectors[23] @ 736
						.field	IntDefaultHandler,32		; g_pfnVectors[24] @ 768
						.field	IntDefaultHandler,32		; g_pfnVectors[25] @ 800
						.field	IntDefaultHandler,32		; g_pfnVectors[26] @ 832
						.field	IntDefaultHandler,32		; g_pfnVectors[27] @ 864
						.field	IntDefaultHandler,32		; g_pfnVectors[28] @ 896
						.field	IntDefaultHandler,32		; g_pfnVectors[29] @ 928
						.field	IntDefaultHandler,32		; g_pfnVectors[30] @ 960
						.field	IntDefaultHandler,32		; g_pfnVectors[31] @ 992
						.field	IntDefaultHandler,32		; g_pfnVectors[32] @ 1024
						.field	IntDefaultHandler,32		; g_pfnVectors[33] @ 1056
						.field	IntDefaultHandler,32		; g_pfnVectors[34] @ 1088
						.field	IntDefaultHandler,32		; g_pfnVectors[35] @ 1120
						.field	IntDefaultHandler,32		; g_pfnVectors[36] @ 1152
						.field	IntDefaultHandler,32		; g_pfnVectors[37] @ 1184
						.field	IntDefaultHandler,32		; g_pfnVectors[38] @ 1216
						.field	IntDefaultHandler,32		; g_pfnVectors[39] @ 1248
						.field	IntDefaultHandler,32		; g_pfnVectors[40] @ 1280
						.field	IntDefaultHandler,32		; g_pfnVectors[41] @ 1312
						.field	IntDefaultHandler,32		; g_pfnVectors[42] @ 1344
						.field	IntDefaultHandler,32		; g_pfnVectors[43] @ 1376
						.field	IntDefaultHandler,32		; g_pfnVectors[44] @ 1408
						.field	IntDefaultHandler,32		; g_pfnVectors[45] @ 1440
						.field	IntDefaultHandler,32		; g_pfnVectors[46] @ 1472
						.field	IntDefaultHandler,32		; g_pfnVectors[47] @ 1504
						.field	IntDefaultHandler,32		; g_pfnVectors[48] @ 1536
						.field	IntDefaultHandler,32		; g_pfnVectors[49] @ 1568
						.field	IntDefaultHandler,32		; g_pfnVectors[50] @ 1600
						.field	IntDefaultHandler,32		; g_pfnVectors[51] @ 1632
						.field	IntDefaultHandler,32		; g_pfnVectors[52] @ 1664
						.field	IntDefaultHandler,32		; g_pfnVectors[53] @ 1696
						.field	IntDefaultHandler,32		; g_pfnVectors[54] @ 1728
						.field	IntDefaultHandler,32		; g_pfnVectors[55] @ 1760
						.field	IntDefaultHandler,32		; g_pfnVectors[56] @ 1792
						.field	IntDefaultHandler,32		; g_pfnVectors[57] @ 1824
						.field	0,32			; g_pfnVectors[58] @ 1856
						.field	IntDefaultHandler,32		; g_pfnVectors[59] @ 1888
						.field	IntDefaultHandler,32		; g_pfnVectors[60] @ 1920
						.field	IntDefaultHandler,32		; g_pfnVectors[61] @ 1952
						.field	IntDefaultHandler,32		; g_pfnVectors[62] @ 1984
						.field	IntDefaultHandler,32		; g_pfnVectors[63] @ 2016
						.field	IntDefaultHandler,32		; g_pfnVectors[64] @ 2048
						.field	IntDefaultHandler,32		; g_pfnVectors[65] @ 2080
						.field	IntDefaultHandler,32		; g_pfnVectors[66] @ 2112
						.field	IntDefaultHandler,32		; g_pfnVectors[67] @ 2144
						.field	0,32			; g_pfnVectors[68] @ 2176
						.field	0,32			; g_pfnVectors[69] @ 2208
						.field	IntDefaultHandler,32		; g_pfnVectors[70] @ 2240
						.field	IntDefaultHandler,32		; g_pfnVectors[71] @ 2272
						.field	IntDefaultHandler,32		; g_pfnVectors[72] @ 2304
						.field	IntDefaultHandler,32		; g_pfnVectors[73] @ 2336
						.field	IntDefaultHandler,32		; g_pfnVectors[74] @ 2368
						.field	IntDefaultHandler,32		; g_pfnVectors[75] @ 2400
						.field	IntDefaultHandler,32		; g_pfnVectors[76] @ 2432
						.field	IntDefaultHandler,32		; g_pfnVectors[77] @ 2464
						.field	IntDefaultHandler,32		; g_pfnVectors[78] @ 2496
						.field	IntDefaultHandler,32		; g_pfnVectors[79] @ 2528
						.field	0,32			; g_pfnVectors[80] @ 2560
						.field	0,32			; g_pfnVectors[81] @ 2592
						.field	0,32			; g_pfnVectors[82] @ 2624
						.field	0,32			; g_pfnVectors[83] @ 2656
						.field	IntDefaultHandler,32		; g_pfnVectors[84] @ 2688
						.field	IntDefaultHandler,32		; g_pfnVectors[85] @ 2720
						.field	IntDefaultHandler,32		; g_pfnVectors[86] @ 2752
						.field	IntDefaultHandler,32		; g_pfnVectors[87] @ 2784
						.field	0,32			; g_pfnVectors[88] @ 2816
						.field	0,32			; g_pfnVectors[89] @ 2848
						.field	0,32			; g_pfnVectors[90] @ 2880
						.field	0,32			; g_pfnVectors[91] @ 2912
						.field	0,32			; g_pfnVectors[92] @ 2944
						.field	0,32			; g_pfnVectors[93] @ 2976
						.field	0,32			; g_pfnVectors[94] @ 3008
						.field	0,32			; g_pfnVectors[95] @ 3040
						.field	0,32			; g_pfnVectors[96] @ 3072
						.field	0,32			; g_pfnVectors[97] @ 3104
						.field	0,32			; g_pfnVectors[98] @ 3136
						.field	0,32			; g_pfnVectors[99] @ 3168
						.field	0,32			; g_pfnVectors[100] @ 3200
						.field	0,32			; g_pfnVectors[101] @ 3232
						.field	0,32			; g_pfnVectors[102] @ 3264
						.field	0,32			; g_pfnVectors[103] @ 3296
						.field	0,32			; g_pfnVectors[104] @ 3328
						.field	0,32			; g_pfnVectors[105] @ 3360
						.field	0,32			; g_pfnVectors[106] @ 3392
						.field	0,32			; g_pfnVectors[107] @ 3424
						.field	IntDefaultHandler,32		; g_pfnVectors[108] @ 3456
						.field	IntDefaultHandler,32		; g_pfnVectors[109] @ 3488
						.field	IntDefaultHandler,32		; g_pfnVectors[110] @ 3520
						.field	IntDefaultHandler,32		; g_pfnVectors[111] @ 3552
						.field	IntDefaultHandler,32		; g_pfnVectors[112] @ 3584
						.field	IntDefaultHandler,32		; g_pfnVectors[113] @ 3616
						.field	IntDefaultHandler,32		; g_pfnVectors[114] @ 3648
						.field	IntDefaultHandler,32		; g_pfnVectors[115] @ 3680
						.field	IntDefaultHandler,32		; g_pfnVectors[116] @ 3712
						.field	IntDefaultHandler,32		; g_pfnVectors[117] @ 3744
						.field	IntDefaultHandler,32		; g_pfnVectors[118] @ 3776
						.field	IntDefaultHandler,32		; g_pfnVectors[119] @ 3808
						.field	IntDefaultHandler,32		; g_pfnVectors[120] @ 3840
						.field	IntDefaultHandler,32		; g_pfnVectors[121] @ 3872
						.field	IntDefaultHandler,32		; g_pfnVectors[122] @ 3904
						.field	0,32			; g_pfnVectors[123] @ 3936
						.field	0,32			; g_pfnVectors[124] @ 3968
						.field	IntDefaultHandler,32		; g_pfnVectors[125] @ 4000
						.field	IntDefaultHandler,32		; g_pfnVectors[126] @ 4032
						.field	IntGPIOm,32		; g_pfnVectors[127] @ 4064
						.field	IntDefaultHandler,32		; g_pfnVectors[128] @ 4096
						.field	IntDefaultHandler,32		; g_pfnVectors[129] @ 4128
						.field	0,32			; g_pfnVectors[130] @ 4160
						.field	0,32			; g_pfnVectors[131] @ 4192
						.field	IntDefaultHandler,32		; g_pfnVectors[132] @ 4224
						.field	IntDefaultHandler,32		; g_pfnVectors[133] @ 4256
						.field	IntDefaultHandler,32		; g_pfnVectors[134] @ 4288
						.field	IntDefaultHandler,32		; g_pfnVectors[135] @ 4320
						.field	IntDefaultHandler,32		; g_pfnVectors[136] @ 4352
						.field	IntDefaultHandler,32		; g_pfnVectors[137] @ 4384
						.field	IntDefaultHandler,32		; g_pfnVectors[138] @ 4416
						.field	IntDefaultHandler,32		; g_pfnVectors[139] @ 4448
						.field	IntDefaultHandler,32		; g_pfnVectors[140] @ 4480
						.field	IntDefaultHandler,32		; g_pfnVectors[141] @ 4512
						.field	IntDefaultHandler,32		; g_pfnVectors[142] @ 4544
						.field	IntDefaultHandler,32		; g_pfnVectors[143] @ 4576
						.field	IntDefaultHandler,32		; g_pfnVectors[144] @ 4608
						.field	IntDefaultHandler,32		; g_pfnVectors[145] @ 4640
						.field	IntDefaultHandler,32		; g_pfnVectors[146] @ 4672
						.field	IntDefaultHandler,32		; g_pfnVectors[147] @ 4704
						.field	IntDefaultHandler,32		; g_pfnVectors[148] @ 4736
						.field	IntDefaultHandler,32		; g_pfnVectors[149] @ 4768
						.field	IntDefaultHandler,32		; g_pfnVectors[150] @ 4800
						.field	IntDefaultHandler,32		; g_pfnVectors[151] @ 4832
						.field	IntDefaultHandler,32		; g_pfnVectors[152] @ 4864
						.field	IntDefaultHandler,32		; g_pfnVectors[153] @ 4896
						.field	IntDefaultHandler,32		; g_pfnVectors[154] @ 4928


;------------------------------------------------
;			switch initializition
;------------------------------------------------

Switch_Init:
		mov r0, #GPIO_BASE	;RCGC : General-Purpose Input/Output Run Mode Clock Gating Control
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #RCGCGPIO
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x800
		str r0, [r1]
		nop
		nop

		mov r0, #GPIO_BASE	;HBCTL : High-Performance Bus Control
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #GPIOHBCTL
		add r1, r1, r0

		mov r0, #0x800
		str r0, [r1]
		nop
		nop

		mov r0, #GPIO_BASE	;DIR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIODIR
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;DEN
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;PUR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOPUR
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f
		str r0, [r1]

LED_Init:
		;RCGC2 - enable
		mov r0, #GPIO_BASE	;RCGC : General-Purpose Input/Output Run Mode Clock Gating Control
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #RCGCGPIO
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x40
		str r0, [r1]
		nop
		nop
		;GPIODIR - output
		mov r0, #GPIO_BASE	;DIR
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIODIR
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x4
		str r0, [r1]
		;GPIOAFSEL - GPIO
		mov r0, #GPIO_BASE	;AFSEL : Alternate Function Select
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIOAFSEL
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x4
		str r0, [r1]
		;GPIODR8R - 8-mA
		mov r0, #GPIO_BASE	;AFSEL : Alternate Function Select
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIODR8R
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x4
		str r0, [r1]
		;GPIODEN - enable
		mov r0, #GPIO_BASE	;AFSEL : Alternate Function Select
		mov r1, #0x26000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x4
		str r0, [r1]

		;bx lr

INTCONF:
			mov r0, #GPIO_BASE	;ICR : Interrupt Clear
			mov r1, #0x63000
			add r1, r1, r0
			mov r0, #GPIOICR
			add r1, r1, r0

			ldr r0, [r1]
			orr r0, r0, #0xff
			str r0, [r1]

		mov r0, #GPIO_BASE	;GPIOIS : detect edge
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOIS
		add r1, r1, r0
		
		ldr r0, [r1]
		bic r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;GPIOIEV : pm0, 1 - detect rising edge
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOIEV
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x0f
		str r0, [r1]

		mov r0, #GPIO_BASE	;GPIOIBE : pm4 - detect both edges
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOIBE
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x10
		str r0, [r1]


;int127 enable
INTEN:
		mov r0, #NVIC_BASE
		mov r1, #0xE000
		add r1, r1, r0
		mov r0, #EN3
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x8000
		str r0, [r1]

		;bx lr

;portm interrupt unmasking
UNMSK:
		mov r0, #GPIO_BASE	;IM : Interrupt Mask
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOIM
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0xff
		str r0, [r1]

		bx lr

Switch_Input:

		mov r5, #GPIO_BASE
		mov r1, #0x63000
		add r1, r1, r5
		mov r5, #0x7c
		add r1, r1, r5

		ldr r5, [r1]

DELAY:	MOVW r3,#0xffff

_DELAY_LOOP:
		CBZ r3,_DELAY_EXIT		;Compare and Branch on Zero
		sub r3,r3,#1
		B _DELAY_LOOP
_DELAY_EXIT:

		cmp r5, #SW_UP
		BEQ _up

		cmp r5, #SW_DOWN
		BEQ _down

		mov r1, #'A'
		b _EXIT

_up:
		mov r1, #'B'
		b _EXIT

_down:
		mov r1, #'C'
		b _EXIT

_EXIT:
		bx lr

num_1:
		mov r0, r1
		bx lr

num_3:
		mov r0, #'D'
		bx lr


IntDefaultHandler:
		b IntDefaultHandler

IntGPIOm:	.asmfunc
			stmfd sp!, {a1-a4, lr}
ICL:
			mov r0, #GPIO_BASE	;ICR : Interrupt Clear
			mov r1, #0x63000
			add r1, r1, r0
			mov r0, #GPIOICR
			add r1, r1, r0

			ldr r0, [r1]
			orr r0, r0, #0xff
			str r0, [r1]
_Switch_input:
			mov r0, #GPIO_BASE
    		mov r1, #0x63000
    		add r1, r1, r0
    		mov r0, #GPIODATA
    		add r1, r1, r0
    		mov r0, #0x7c
    		add r1, r0
    		ldr r0, [r1]

			tst r0, #0x10
			beq _LED_On
			tst r0, #0x01
			beq _LED_On
			tst r0, #0x02
			beq _LED_Off
			b _LED_Off
_LED_On:
		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5

		ldr r5, [r1]
		orr r5, #0x4
		str r5, [r1]

		b _Exit
_LED_Off:
		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5

		ldr r5, [r1]
		bic r5, #0x4
		str r5, [r1]

		b _Exit
_Exit:
			
			ldmfd sp!,{a1-a4,lr}
			bx lr
			.endasmfunc

		


			.retain
			.retainrefs
