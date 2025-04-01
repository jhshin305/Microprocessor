
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

RCGCUART			.equ	0x618
UARTCTL				.equ	0x030
UARTIBRD			.equ	0x024
UARTFBRD			.equ	0x028
UARTLCRH			.equ	0x02C

UARTFR				.equ	0x018
UARTDR				.equ	0x000

SW_UP				.equ	0x1E	;11110
SW_DOWN				.equ	0x1D	;11101
SW_LEFT				.equ	0x1B	;11011
SW_RIGHT			.equ	0x17	;10111
SW_SELECT			.equ	0x0F	;01111
;--------------------------------------------------
             .text                           ; Program Start
             .global RESET                   ; Define entry point
             .align	4
			 .sect ".text"

             .global Switch_Init
             .global LED_Init
             .global UART_Init
             .global Switch_Input
             .global LED_On
             .global LED_Off
             .global Blink_slow
             .global Blink_fast
             .global Printf
			 .global num_1
			 .global num_3

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

		mov r0, #GPIO_BASE	;AFSEL : Alternate Function Select
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOAFSEL
		add r1, r1, r0

		ldr r0, [r1]
		bic r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;PUR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOPUR
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;DEN
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f
		str r0, [r1]

		mov r0, #GPIO_BASE	;AMSEL : Analog Mode Select
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOAMSEL
		add r1, r1, r0

		mov r0, #0
		str r0, [r1]

		mov r0, #GPIO_BASE	;PCTL : Port Control
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOPCTL
		add r1, r1, r0

		ldr r0, [r1]
		orr r0, r0, #0x1f;#0x000f000f
		str r0, [r1]

		mov r0, #GPIO_BASE	;LOCK
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOLOCK
		add r1, r1, r0

		mov r0, #GPIO_BASE
		mov r2, #0xc400000
		add r2, r2, r0
		mov r0, #0xf4000
		add r2, r2, r0
		mov r0, #0x34b
		add r2, r2, r0

		ldr r0, [r1]
		orr r0, r0, r2
		str r0, [r1]

		mov r0, #GPIO_BASE	;CR
		mov r1, #0x63000
		add r1, r1, r0
		mov r0, #GPIOCR
		add r1, r1, r0

		ldr r0, [r1]
		mov r2, #0x00000000
		bic r0, r0, r2
		str r0, [r1]

		bx lr

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

		bx lr

UART_Init:
		;RCGCUART - enable UART 0
		mov r0, #GPIO_BASE
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #RCGCUART
		add r1, r1, r0
		ldr r0, [r1]
		orr r0, r0, #0x1
		str r0, [r1]
		nop
		nop

		;RCGCGPIO - enable GPIO A
		mov r0, #GPIO_BASE
		mov r1, #0xFE000
		add r1, r1, r0
		mov r0, #RCGCGPIO
		add r1, r1, r0
		ldr r0, [r1]
		orr r0, r0, #0x1
		str r0, [r1]
		nop
		nop

		;UARTCTL - disable UART
		mov r0, #GPIO_BASE
		mov r1, #0x0C000
		add r1, r1, r0
		mov r0, #UARTCTL
		add r1, r1, r0
		ldr r0, [r1]
		bic r0, r0, #0x1
		str r0, [r1]

		;UARTIBRD/ UARTFBRD - set baud rate
		; UARTSys CLK = 16MHz
		; UART Baud rate = 115200 baud rate
		mov r0, #GPIO_BASE
		mov r1, #0x0C000
		add r1, r1, r0
		mov r0, #UARTIBRD
		add r1, r1, r0
		ldr r0, [r1]
		orr r0, r0, #8
		str r0, [r1]

		mov r0, #GPIO_BASE
		mov r1, #0x0C000
		add r1, r1, r0
		mov r0, #UARTFBRD
		add r1, r1, r0
		ldr r0, [r1]
		orr r0, r0, #44
		str r0, [r1]	

		;UARTLCRH - 8-bit, no parity, 1 stop bit
		mov r0, #GPIO_BASE
		mov r1, #0x0C000
		add r1, r1, r0
		mov r0, #UARTLCRH
		add r1, r1, r0
		ldr r0, [r1]
		orr r0, r0, #0x60	;0110 0000
		str r0, [r1]

		;UARTCTL - enable UART/ENable TXE and RXE
		mov r0, #GPIO_BASE
		mov r1, #0x0C000
		add r1, r1, r0
		mov r0, #UARTCTL
		add r1, r1, r0
		ldr r0, [r1]
		orr r0, r0, #0x300
		orr r0, r0, #0x1
		str r0, [r1]

		;GPIO Port A (APB)
		;GPIOAFSEL - Peripheral signal
		mov r0, #GPIO_BASE	;AFSEL : Alternate Function Select
		mov r1, #0x04000
		add r1, r1, r0
		mov r0, #GPIOAFSEL
		add r1, r1, r0
		ldr r0, [r1]
		orr r0, r0, #0x3	;0011
		str r0, [r1]

		;GPIOPCTL - USE U0Rx, U0Tx (page 1396, table 23-5)
		; port A, pin 0,1 = U0Rx, U0Tx -> 0x01, 0x01
		mov r0, #GPIO_BASE	;PCTL : Port Control
		mov r1, #0x04000
		add r1, r1, r0
		mov r0, #GPIOPCTL
		add r1, r1, r0
		ldr r0, [r1]
		orr r0, r0, #0x11	;0001 0001
		str r0, [r1]

		;GPIODEN - enable
		mov r0, #GPIO_BASE	;DEN : Digital Enable
		mov r1, #0x04000
		add r1, r1, r0
		mov r0, #GPIODEN
		add r1, r1, r0
		ldr r0, [r1]
		orr r0, r0, #0x3	;0011
		str r0, [r1]

		;GPIOAMSEL - disable
		mov r0, #GPIO_BASE	;AMSEL : Analog Mode Select
		mov r1, #0x04000
		add r1, r1, r0
		mov r0, #GPIOAMSEL
		add r1, r1, r0
		ldr r0, [r1]
		bic r0, r0, #0x11
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

		cmp r5, #SW_LEFT
		BEQ _left

		cmp r5, #SW_RIGHT
		BEQ _right

		mov r1, #'A'
		b _EXIT

_up:
		mov r1, #'B'
		b _EXIT

_down:
		mov r1, #'C'
		b _EXIT

_left:
		mov r1, #'D'
		b _EXIT

_right:
		mov r1, #'E'
		b _EXIT

_EXIT:
		bx lr

LED_On:
		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5

		ldr r5, [r1]
		orr r5, #0x4
		str r5, [r1]

		bx lr

LED_Off:
		mov r5, #GPIO_BASE
		mov r1, #0x26000
		add r1, r1, r5
		mov r5, #0x10
		add r1, r1, r5

		ldr r5, [r1]
		bic r5, #0x4
		str r5, [r1]

		bx lr

Blink_slow:
		MOVW r7, #0xffff
		b _Blink

Blink_fast:
		MOVW r7, #0x6000
		b _Blink

_Blink:
		mov r0, #5
		mov r2, lr

_Blink_LOOP:
		cbz r0, _Blink_Exit
		sub r0, r0, #1
		bl LED_On
		bl _Blink_DELAY
		bl LED_Off
		bl _Blink_DELAY
		B _Blink_LOOP

_Blink_Exit: bx r2

_Blink_DELAY: MOV r4, r7, LSL #5
_Blink_DELAY_LOOP1:
		cmp r4, #0
		beq _Blink_LOOP_Exit
		sub r4, r4, #1
		B _Blink_DELAY_LOOP1
_Blink_LOOP_Exit: bx lr

Printf:
		mov r1, lr
		bl _wait
		
		mov r2, #GPIO_BASE
		mov r3, #0x0C000
		add r3, r3, r2
		mov r2, #UARTDR
		add r3, r3, r2
		;mov r0, #'A'
		str r0, [r3]

		bx r1

_wait:
		mov r2, #GPIO_BASE
		mov r3, #0x0C000
		add r3, r3, r2
		mov r2, #UARTFR
		add r3, r3, r2

		ldr r2, [r3]
		ands r2, #0x20
		bne _wait

		bx lr

num_1:
		mov r0, r1
		bx lr

num_3:
		mov r0, #'D'
		bx lr

			.retain
			.retainrefs
