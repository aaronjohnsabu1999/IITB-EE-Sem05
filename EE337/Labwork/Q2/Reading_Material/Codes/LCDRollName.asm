LCD_rs   equ P0.0
LCD_rw   equ P0.1
LCD_en   equ P0.2
LCD_data equ P2

org	 0000h
ljmp main

org  0100h
fname:	mov  R0, #0xE1
		mov @R0, #0x31
		inc  R0
		mov @R0, #0x37
		inc  R0
		mov @R0, #0x30
		inc  R0
		mov @R0, #0x30
		inc  R0
		mov @R0, #0x37
		inc  R0
		mov @R0, #0x30
		inc  R0
		mov @R0, #0x30
		inc  R0
		mov @R0, #0x35
		inc  R0
		mov @R0, #0x30
		inc  R0
		mov @R0, #0x00
ret
roll:	mov  R0, #0xF1
		mov @R0, #0x41
		inc  R0
		mov @R0, #0x61
		inc  R0
		mov @R0, #0x72
		inc  R0
		mov @R0, #0x6F
		inc  R0
		mov @R0, #0x6E
		inc  R0
		mov @R0, #0x20
		inc  R0
		mov @R0, #0x4A
		inc  R0
		mov @R0, #0x6F
		inc  R0
		mov @R0, #0x68
		inc  R0
		mov @R0, #0x6E
		inc  R0
		mov @R0, #0x20
		inc  R0
		mov @R0, #0x53
		inc  R0
		mov @R0, #0x61
		inc  R0
		mov @R0, #0x62
		inc  R0
		mov @R0, #0x75
		inc  R0
		mov @R0, #0x00
ret
initSeq:db 0x38, 0x0C, 0x01, 0x06

org	 0200h
main:	mov P2,#0x00
		mov P1,#0x00
		acall fname
		acall roll
		acall delay
		acall delay
		
		acall lcd_init
		acall delay
		acall delay
		acall delay
		
		mov   A,  #0x80
		acall lcd_command
		acall delay
		mov   R1, #0xE1
		acall lcd_sendstring
		acall delay

		mov   A,  #0xC0
		acall lcd_command
		acall delay
		mov   R1, #0xF1
		acall lcd_sendstring
here:	sjmp  here

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