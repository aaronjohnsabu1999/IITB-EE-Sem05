org 0000h
ljmp main
org 0050h

delay:
		mov  R3, #0x14
back1:	mov  R2, #0xC8
back2:	mov  R1, #0xFF
back3:	djnz R1, back3
		djnz R2, back2
		djnz R3, back1
RET

display:
		mov   R5,  0x51
		mov   R4, #0x00
CP1:	mov   A,  R5
		add   A,  R4
		mov   R0, A
		mov   A,  @R0
		anl   A,  #0xF0
		mov   P1, A
		inc   R4
		lcall delay
		mov   A,  R4
		cjne  A,  0x50, CP1
ret

init:
		mov   0x50, #0x06
		mov   0x51, #0x60
		mov   0x60, #0x5F
		mov   0x61, #0x4D
		mov   0x62, #0x3B
		mov   0x63, #0x29
		mov   0x64, #0x17
		mov   0x65, #0x05
ret

main:	lcall init
		lcall display
here: 	sjmp  here
end