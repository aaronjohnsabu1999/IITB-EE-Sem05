org  0000h
ljmp main
org  0050h

matrix_transpose:
		mov  R2, #0x00
CP1:	mov  R3, #0x00
		mov  A,  R2
		cjne A,  0x40, CP2
		ljmp CP3
CP2:	mov  A,  0x41
		add  A,  R2
		add  A,  R2
		add  A,  R2
		add  A,  R2
		add  A,  R3
		mov  R0, A
		mov  A,  0x42
		add  A,  R3
		add  A,  R3
		add  A,  R3
		add  A,  R3
		add  A,  R2
		mov  R1, A
		mov  A, @R0
		mov @R1, A
		inc  R3
		mov  A,  R3
		cjne A,  0x40, CP2
		inc  R2
		ljmp CP1
CP3:
ret

init:
		mov 0x40, #0x04
		mov 0x41, #0x50
		mov 0x42, #0x60
		
		mov 0x50, #0x0C
		mov 0x51, #0x40
		mov 0x52, #0x6B
		mov 0x53, #0x16
		mov 0x54, #0xA3
		mov 0x55, #0x25
		mov 0x56, #0xD4
		mov 0x57, #0xC1
		mov 0x58, #0x87
		mov 0x59, #0xBD
		mov 0x5A, #0xF2
		mov 0x5B, #0x3A
		mov 0x5C, #0x6E
		mov 0x5D, #0x59
		mov 0x5E, #0xE8
		mov 0x5F, #0x9F
ret

main:	lcall init
		lcall matrix_transpose
here:	sjmp  here
end