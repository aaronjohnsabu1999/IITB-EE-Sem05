LED equ P1
org  0x00
ljmp MAIN
org  0x50

DELAY_SP:					; Delays for D/2 seconds
		mov  R0,  0x4F
BACK1:	mov  R3, #0x0A
BACK2:	mov  R2, #200
BACK3:	mov  R1, #0x0FF
BACK4:	djnz R1, BACK4
		djnz R2, BACK3
		djnz R3, BACK2
		djnz R0, BACK1
RET

MAIN:
		mov   LED, #0x00	; Makes P1 output port
		mov   A,   #0x80	; 0b10000000 C
		mov   R5,  #0x00
BACK:	mov   LED, A
		lcall DELAY_SP
		rlc   A				; 0b0000000C 1
		cpl   C				; 0b0C00000C 0
		rrc   A				; 0b00000000 C
		inc   R5
		sjmp  BACK
END