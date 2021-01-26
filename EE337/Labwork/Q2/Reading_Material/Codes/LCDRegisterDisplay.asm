LCD_rs   equ P0.0
LCD_rw   equ P0.1
LCD_en   equ P0.2
LCD_data equ P2

org	 0000h
ljmp main

org  0050h
initSeq:db 0x38, 0x0C, 0x01, 0x06
ascii:	db 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46
text:	db 0x41, 0x50, 0x5E, 0x6C, 0x00

bin2ascii:								;MODIFY DPTR, A, R1, R2, R5
		mov  dptr, #ascii
		mov  R2, #0x00
CP3:	mov  A, @R0
		mov  R5, A
		anl  A, #0xF0
		swap A
		movc A, @A+dptr
		mov @R1, A
		inc  R1
		mov  A,  R5
		anl  A, #0x0F
		movc A, @A+dptr
		mov @R1, A
		inc  R0
		inc  R1
		inc  R2
		cjne R2, #0x03, CP3
ret

desc:	mov  R0, #0x41					;MODIFY: R0, 0x41 to 0x77
		mov @R0, #0x41	;41
		inc  R0
		mov @R0, #0x42	;42
		inc  R0
		mov @R0, #0x50	;43
		inc  R0
		mov @R0, #0x53	;44
		inc  R0
		mov @R0, #0x57	;45
		inc  R0
		mov @R0, #0x20	;46
		inc  R0
		mov @R0, #0x3D	;47
		inc  R0
		mov @R0, #0x20	;48
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		mov @R0, #0xFF	;4F
		
		inc  R0
		mov @R0, #0x52	;50
		inc  R0
		mov @R0, #0x30	;51
		inc  R0
		mov @R0, #0x31	;52
		inc  R0
		mov @R0, #0x32	;53
		inc  R0
		mov @R0, #0x20	;54
		inc  R0
		mov @R0, #0x3D	;55
		inc  R0
		mov @R0, #0x20	;56
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		mov @R0, #0xFF	;5D
	
		inc  R0
		mov @R0, #0x52	;5E
		inc  R0
		mov @R0, #0x33	;5F
		inc  R0
		mov @R0, #0x34	;60
		inc  R0
		mov @R0, #0x35	;61
		inc  R0
		mov @R0, #0x20	;62
		inc  R0
		mov @R0, #0x3D	;63
		inc  R0
		mov @R0, #0x20	;64
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		mov @R0, #0xFF	;6B
		
		inc  R0
		mov @R0, #0x52	;6C
		inc  R0
		mov @R0, #0x36	;6D
		inc  R0
		mov @R0, #0x37	;6E
		inc  R0
		mov @R0, #0x53	;6F
		inc  R0
		mov @R0, #0x50	;70
		inc  R0
		mov @R0, #0x3D	;71
		inc  R0
		mov @R0, #0x20	;72
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		inc  R0
		mov @R0, #0xFF	;79
ret
roll:	mov  0x24, R0				;MODIFY: R0, 0x11 to 0x30; 0x11 to 0x16 - SHOW1, 0x19 to 0x1E - SHOW2, 0x21 to 0x26 - SHOW3, 0x29 to 0x2E - SHOW4
		mov  0x25, R1
		mov  0x26, R2
		mov  0x27, R5
		mov  R0, #0x21
		mov @R0, A		;21
		inc  R0
		mov @R0, B		;22
		inc  R0
		mov @R0, PSW	;23
		inc  R0
		mov  R0, #0x21
		mov  R1, #0x49
		acall bin2ascii
		
		mov  R0, #0x21
		mov @R0, 0x24
		inc  R0
		mov @R0, 0x25
		inc  R0
		mov  A,  0x26
		mov @R0, A
		inc  R0
		mov  R0, #0x21
		mov  R1, #0x57
		acall bin2ascii
		
		mov  R0, #0x21
		mov  A,  R3
		mov @R0, A
		inc  R0
		mov  A,  R4
		mov @R0, A
		inc  R0
		mov @R0, 0x27
		inc  R0
		mov  R0, #0x21
		mov  R1, #0x65
		acall bin2ascii
		
		mov  R0, #0x21
		mov  A,  R6
		mov @R0, A
		inc  R0
		mov  A,  R7
		mov @R0, A
		inc  R0
		mov @R0, SP
		inc  R0
		mov  R0, #0x21
		mov  R1, #0x73
		acall bin2ascii
ret

main:	mov P2, #0x00				;MODIFY: DPTR, A, B, R1, R3, R7, P1, P2
		mov P1, #0x00
		mov R3, #0x00
		acall desc
		acall delay
		acall delay
		
		acall lcd_init
repeat:	acall roll
		acall delay
		acall delay
		acall delay
		
		mov   A,  #0x80
		acall lcd_command
		acall delay
		mov   dptr, #text
		mov   A,  R3
		movc  A, @A+dptr
		jz    main
		mov   R1, A
		acall lcd_sendstring
		
		inc R3
		
		mov   A,  #0xC0
		acall lcd_command
		acall delay
		mov   dptr, #text
		mov   A,  R3
		movc  A, @A+dptr
		mov   R1, A
		acall lcd_sendstring
		
		mov TL0, #0xC8
CP4:	mov   B, #0x32
CP5:	acall delay
		djnz  B,  CP5
		djnz TL0, CP4
		
		inc   R3
		ljmp  repeat

lcd_init:							;MODIFY: DPTR, A, R7
		mov   R7, #0x00
		mov   dptr, #initSeq
CP1:	mov   A,  R7
		movc  A,  @A+dptr
		inc   R7
		mov   LCD_data, A
		clr   LCD_rs
		clr   LCD_rw
		setb  LCD_en
		acall delay
		clr   LCD_en
		acall delay
		cjne  R7, #0x04, CP1
ret

lcd_command:						;MODIFY: P0
         mov   LCD_data, A
         clr   LCD_rs
         clr   LCD_rw
         setb  LCD_en
		 acall delay
         clr   LCD_en
		 acall delay
ret

lcd_senddata:						;MODIFY: P0
		mov   LCD_data, A
		setb  LCD_rs
		clr   LCD_rw
		setb  LCD_en
		acall delay
		clr   LCD_en
		acall delay
		acall delay
ret

lcd_sendstring:						;MODIFY: A, R1
		push  0x0E0
lcd_sendstring_loop:
		mov   A, @R1
		cjne  A, #0xFF, CP2
		ljmp  exit
CP2:	acall lcd_senddata
		inc   R1
		sjmp  lcd_sendstring_loop
exit:	pop   0x0E0
ret

delay:	push 0						;MODIFY: R5, R6
		push 1
		mov  R5, #0x01
loop2:	mov  R6, #0xFF
loop1:	djnz R6, loop1
		djnz R5, loop2
		pop  1
		pop  0 
ret

end