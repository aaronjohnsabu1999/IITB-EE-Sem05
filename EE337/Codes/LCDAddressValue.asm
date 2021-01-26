LCD_rs   equ P0.0
LCD_rw   equ P0.1
LCD_en   equ P0.2
LCD_data equ P2

org	 0000h
ljmp main

org  0050h
initSeq:db 0x38, 0x0C, 0x01, 0x06
ascii:	db 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46

bin2ascii:
		mov  dptr, #ascii
		mov  R5, A
		anl  A,  #0xF0
		swap A
		movc A, @A+dptr
		mov @R1, A
		inc  R1
		mov  A,  R5
		anl  A,  #0x0F
		movc A, @A+dptr
		mov @R1, A
		inc  R1
		mov @R1, #0xFF
ret

rand:	mov  R0, #0x21
		mov @R0, #0x1E	;21
		inc  R0
		mov @R0, #0x2D	;22
		inc  R0
		mov @R0, #0x3C	;23
		inc  R0
		mov @R0, #0x4B	;24
		inc  R0
		mov @R0, #0x5A	;25
		inc  R0
		mov @R0, #0x69	;26
		inc  R0
		mov @R0, #0x78	;27
		inc  R0
		mov @R0, #0x87	;28
		inc  R0
		mov @R0, #0x96	;29
		inc  R0
		mov @R0, #0xA5	;2A
		inc  R0
		mov @R0, #0xB4	;2B
		inc  R0
		mov @R0, #0xC3	;2C
		inc  R0
		mov @R0, #0xD2	;2D
		inc  R0
		mov @R0, #0xE1	;2E
		inc  R0
		mov @R0, #0xF0	;2F
		inc  R0
		mov @R0, #0x9E	;30
		inc  R0
		mov @R0, #0x0F	;31
		inc  R0
		mov @R0, #0xF8	;32
		inc  R0
		mov @R0, #0x87	;33
		inc  R0
		mov @R0, #0xE2	;34
		inc  R0
		mov @R0, #0x7D	;35
		inc  R0
		mov @R0, #0xC9	;36
		inc  R0
		mov @R0, #0x14	;37
		inc  R0
		mov @R0, #0xD6	;38
		inc  R0
		mov @R0, #0x33	;39
		inc  R0
		mov @R0, #0xB5	;3A
		inc  R0
		mov @R0, #0x2C	;3B
		inc  R0
		mov @R0, #0xA1	;3C
		inc  R0
		mov @R0, #0x6D	;3D
		inc  R0
		mov @R0, #0x5B	;3E
		inc  R0
		mov @R0, #0x40	;3F
ret

desc:	mov  R0, #0x41
		mov @R0, #0x4C	;41
		inc  R0
		mov @R0, #0x6F	;42
		inc  R0
		mov @R0, #0x63	;43
		inc  R0
		mov @R0, #0x61	;44
		inc  R0
		mov @R0, #0x74	;45
		inc  R0
		mov @R0, #0x69	;46
		inc  R0
		mov @R0, #0x6F	;47
		inc  R0
		mov @R0, #0x6E	;48
		inc  R0
		mov @R0, #0x3A	;49
		inc  R0
		mov @R0, #0x20	;4A
		inc  R0
		inc  R0
		inc  R0
		mov @R0, #0xFF	;4D
		
		inc  R0
		mov @R0, #0x43	;4E
		inc  R0
		mov @R0, #0x6F	;4F
		inc  R0
		mov @R0, #0x6E	;50
		inc  R0
		mov @R0, #0x74	;51
		inc  R0
		mov @R0, #0x65	;52
		inc  R0
		mov @R0, #0x6E	;53
		inc  R0
		mov @R0, #0x74	;54
		inc  R0
		mov @R0, #0x73	;55
		inc  R0
		mov @R0, #0x3A	;56
		inc  R0
		mov @R0, #0x20	;57
		inc  R0
		inc  R0
		inc  R0
		mov @R0, #0xFF	;60
ret

readNibbles:
		mov P1,  #0xFF
		lcall delayThree
		anl P1,  #0x0F
		lcall delay
		mov  A,   P1
		mov  TL1, A
		swap A
		mov  P1, A
		acall delayOne
ret

packNibbles:
		mov  A,    0x61
		swap A
		anl  A,   #0xF0
		mov  R0,   A
		mov  A,    0x62
		anl  A,   #0x0F
		add  A,    R0
		mov  R0,   A
		mov  0x60, A
		mov  0x63, #0xFF		
		acall bin2ascii
ret

main:	mov P2, #0x00
		mov P1, #0x00
		mov R3, #0x00
		acall desc
		acall delay
		acall delay
		
		acall lcd_init
repeat:	acall delay
		acall delay
		acall delay
		
		lcall readNibbles
		mov   0x61,  TL1
		lcall readNibbles
		mov   0x62,  TL1
		mov  R1,  #0x4B
		lcall packNibbles
		
		acall rand
		mov  R0,   0x60
		mov  A,   @R0
		anl  A,   #0xF0
		swap A
		mov  0x61, A
		mov  A,   @R0
		anl  A,   #0x0F
		mov  0x62, A
		mov  R1,  #0x58
		lcall packNibbles
		
		mov   A,  #0x80
		acall lcd_command
		acall delay
		mov   R1, #0x41
		acall lcd_sendstring
		acall delay

		mov   A,  #0xC0
		acall lcd_command
		acall delay
		mov   R1, #0x4E
		acall lcd_sendstring
		acall delay
		
		acall delayThree
		ljmp  repeat

lcd_init:
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
		push  0e0h
lcd_sendstring_loop:
		mov   A, @R1
		cjne  A, #0xFF, CP2
		ljmp  exit
CP2:	acall lcd_senddata
		inc   R1
		sjmp  lcd_sendstring_loop
exit:	pop   0e0h
ret

delayThree:
		mov  B, #0x03
loop4:	lcall delayOne
		djnz B, loop4
ret

delayOne:
		mov  R5,  #0x14
loop3:	mov  R6,  #0xC8
loop2:	acall delay
		djnz R6,   loop2
		djnz R5,   loop3
ret

delay:	mov  TL0, #0xFF
loop1:	djnz TL0,  loop1
ret

end