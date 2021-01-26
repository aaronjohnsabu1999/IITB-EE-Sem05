org 0000h
ljmp main
org 0050h

bin2ascii:		
	using 1
		mov  A,   0x40
		anl  A,  #0xF0
		mov  R3, A
		
		mov  A,  0x40
		anl  A,  #0x0F
		mov  R4, A
		
		mov  A,  R3
		rr   A
		rr   A
		rr   A
		rr   A
		mov  R3, A
		mov  B,  #0x0A
		div  AB
		cjne A,  #0x00, CP1
		mov  A,  R3
		add  A,  #0x30
		sjmp CP2
CP1:	mov  A,  R3
		add  A,  #0x37
CP2:	mov  0x20, A

		mov  A,  R4
		mov  B,  #0x0A
		div  AB
		cjne A,  #0x00, CP3
		mov  A,  R4
		add  A,  #0x30
		sjmp CP4
CP3:	mov  A,  R4
		add  A,  #0x37
CP4:	mov  0x21, A
ret

bin2ascii_checksumbyte:
	using 0
		mov  R0,  0x50
		mov  R1,  0x51
		clr  A
CP5:	add  A,   @R1
		inc  R1
		djnz R0,  CP5
		mov 0x40, A
		
		lcall bin2ascii
	using 0
		mov  R3,  0x20
		mov  R4,  0x21
		mov  R0,  0x52
		mov  A,  R3
		mov @R0, A
		mov  A,  R4
		inc  R0
		mov @R0, A
ret

init:
		mov 0x50, #0x05
		mov 0x51, #0x60
		mov 0x52, #0x73
		
		mov 0x60, #0x21
		mov 0x61, #0x57
		mov 0x62, #0x3D
		mov 0x63, #0x8B
		mov 0x64, #0x12
		mov 0x65, #0x4A
		mov 0x66, #0x26
ret

main:	lcall init
		lcall bin2ascii_checksumbyte
here:	sjmp  here
end