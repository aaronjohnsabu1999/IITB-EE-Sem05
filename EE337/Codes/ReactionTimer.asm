LCD_rs		equ P0.0
LCD_rw		equ P0.1
LCD_en		equ P0.2
LCD_data	equ P2

org		0000h
ljmp	main

org		000Bh
ljmp	T0ISR

org		0050h
T0ISR:	clr		TF0
		mov		TL0,	#00011100b
		mov		TH0,	#11111100b
		inc		R6
		cjne	R6,		#0x00,	ISREnd
		inc		R5
ISREnd:	reti

LinesA:	mov		R0,		#0x80
		mov		@R0,	#0x50		// P		0x80
		inc		R0
		mov		@R0,	#0x52		// R		0x81
		inc		R0
		mov		@R0,	#0x45		// E		0x82
		inc		R0
		mov		@R0,	#0x53		// S		0x83
		inc		R0
		mov		@R0,	#0x53		// S		0x84
		inc		R0
		mov		@R0,	#0x20		// (space)	0x85
		inc		R0
		mov		@R0,	#0x53		// S		0x86
		inc		R0
		mov		@R0,	#0x2F		// /		0x87
		inc		R0
		mov		@R0,	#0x57		// W		0x88
		inc		R0
		mov		@R0,	#0x20		// (space)	0x89
		inc		R0
		mov		@R0,	#0x50		// P		0x8A
		inc		R0
		mov		@R0,	#0x31		// 1		0x8B
		inc		R0
		mov		@R0,	#0x2E		// .		0x8C
		inc		R0
		mov		@R0,	#0x30		// 0		0x8D
		inc		R0
		mov		@R0,	#0x00		// NUL		0x8E
		inc		R0
		
		mov		@R0,	#0x41		// A		0x8F
		inc		R0
		mov		@R0,	#0x53		// S		0x90
		inc		R0
		mov		@R0,	#0x20		// (space)	0x91
		inc		R0
		mov		@R0,	#0x4C		// L		0x92
		inc		R0
		mov		@R0,	#0x45		// E		0x93
		inc		R0
		mov		@R0,	#0x44		// D		0x94
		inc		R0
		mov		@R0,	#0x20		// (space)	0x95
		inc		R0
		mov		@R0,	#0x47		// G		0x96
		inc		R0
		mov		@R0,	#0x4C		// L		0x97
		inc		R0
		mov		@R0,	#0x4F		// O		0x98
		inc		R0
		mov		@R0,	#0x57		// W		0x99
		inc		R0
		mov		@R0,	#0x53		// S		0x9A
		inc		R0
		mov		@R0,	#0x00		// NUL		0x9B
		inc		R0
ret
LinesB:	mov		@R0,	#0x52		// R		0x9C
		inc		R0
		mov		@R0,	#0x45		// E		0x9D
		inc		R0
		mov		@R0,	#0x41		// A		0x9E
		inc		R0
		mov		@R0,	#0x43		// C		0x9F
		inc		R0
		mov		@R0,	#0x54		// T		0xA0
		inc		R0
		mov		@R0,	#0x49		// I		0xA1
		inc		R0
		mov		@R0,	#0x4F		// 0		0xA2
		inc		R0
		mov		@R0,	#0x4E		// N		0xA3
		inc		R0
		mov		@R0,	#0x20		// (space)	0xA4
		inc		R0
		mov		@R0,	#0x54		// T		0xA5
		inc		R0
		mov		@R0,	#0x49		// I		0xA6
		inc		R0
		mov		@R0,	#0x4D		// M		0xA7
		inc		R0
		mov		@R0,	#0x45		// E		0xA8
		inc		R0
		mov		@R0,	#0x00		// NUL		0xA9
		inc		R0
		
		mov		@R0,	#0x43		// C		0xAA
		inc		R0
		mov		@R0,	#0x4F		// O		0xAB
		inc		R0
		mov		@R0,	#0x55		// U		0xAC
		inc		R0
		mov		@R0,	#0x4E		// N		0xAD
		inc		R0
		mov		@R0,	#0x54		// T		0xAE
		inc		R0
		mov		@R0,	#0x20		// (space)	0xAF
		inc		R0
		mov		@R0,	#0x49		// I		0xB0
		inc		R0
		mov		@R0,	#0x53		// S		0xB1
		inc		R0
		mov		@R0,	#0x20		// (space)	0xB2
		inc		R0
		mov		@R0,	#0x58		// X		0xB3
		inc		R0
		mov		@R0,	#0x58		// X		0xB4
		inc		R0
		mov		@R0,	#0x58		// X		0xB5
		inc		R0
		mov		@R0,	#0x58		// X		0xB6
		inc		R0
		mov		@R0,	#0x00		// NUL		0xB7
ret
initSeq:
		db	0x38, 0x0C, 0x01, 0x06
bin2ascii:
		db	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46

main:	mov		P2,		#0x00										//	Temp.Use:	P1,	P2,	A, R1
		mov		P1,		#0x00
		acall	LinesA
		acall	LinesB
		acall	delay
		acall	delay
		
		acall	lcd_init
		acall	delay
		acall	delay
		acall	delay
		
		mov		A,		#0x80
		acall	lcd_command
		acall	delay
		mov		R1,		#0x80
		acall	lcd_sendstring
		acall	delay

		mov		A,		#0xC0
		acall	lcd_command
		acall	delay
		mov		R1,		#0x8F
		acall	lcd_sendstring
		
		mov		R5,		#00000000b
		mov		R6,		#00000000b
		mov		TL0,	#00011100b
		mov		TH0,	#11111100b
		mov		TMOD,	#00000001b
		mov		IE,		#10000010b
		
		mov		P1,		#00011111b
		setb	TR0
repeat:	mov		A,		P1
		anl		A,		#00000001b
		cjne	A,		#00000001b,	repeat
		clr		TR0
		clr		P1.4
		mov		0x40,		R5
		mov		0x41,		R6
		
		mov		dptr,	#bin2ascii
		mov		R0,		#0xB3
		mov		A,		0x40
		anl		A,		#0xF0
		swap	A
		movc	A,		@A+DPTR
		mov		@R0,	A
		inc		R0
		mov		A,		0x40
		anl		A,		#0x0F
		movc	A,		@A+DPTR
		mov		@R0,	A
		inc		R0
		mov		A,		0x41
		anl		A,		#0xF0
		swap	A
		movc	A,		@A+DPTR
		mov		@R0,	A
		inc		R0
		mov		A,		0x41
		anl		A,		#0x0F
		movc	A,		@A+DPTR
		mov		@R0,	A
		
		mov		P2,		#0x00
		mov		P1,		#0x00
		acall	lcd_init
		acall	delay
		acall	delay
		acall	delay
		
		mov		A,		#0x80
		acall	lcd_command
		acall	delay
		mov		R1,		#0x9C
		acall	lcd_sendstring
		acall	delay

		mov		A,		#0xC0
		acall	lcd_command
		acall	delay
		mov		R1,		#0xAA
		acall	lcd_sendstring
		
		mov		R3,		#190
CP2:	mov		R2,		#100
CP3:	acall	delay
		djnz	R2,		CP3
		djnz	R3,		CP2

		ljmp	main

lcd_init:															//	Temp.Use:	R7, DPTR, A
		mov		R7,		#0x00
		mov		dptr,	#initSeq
CP1:	mov		A,		R7
		movc	A,		@A+dptr
		inc		R7
		mov		LCD_data,	A
		clr		LCD_rs
		clr		LCD_rw
		setb	LCD_en
		acall	delay
		clr		LCD_en
		acall	delay
		cjne	R7,		#0x04,	CP1
ret

lcd_command:
         mov   LCD_data, A
         clr   LCD_rs
         clr   LCD_rw
         setb  LCD_en
		 acall delay
         clr   LCD_en
		 acall delay
ret

lcd_senddata:
		mov   LCD_data, A
		setb  LCD_rs
		clr   LCD_rw
		setb  LCD_en
		acall delay
		clr   LCD_en
		acall delay
		acall delay
ret

lcd_sendstring:
		push  0x0E0
lcd_sendstring_loop:
		mov   A, @R1
		jz    exit
		acall lcd_senddata
		inc   R1
		sjmp  LCD_sendstring_loop
exit:	pop   0x0E0
ret

delay:	push 0
		push 1
		mov  R0, #0x01
loop2:	mov  R1, #0xFF
loop1:	djnz R1, loop1
		djnz R0, loop2
		pop  1
		pop  0 
ret

end