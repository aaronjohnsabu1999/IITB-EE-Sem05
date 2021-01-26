org 0000h
ljmp main
org 0050h

zeroOut:
		mov  R1,   0x51
		mov  R3,  #0x00
CP1:	mov  A,    R1
		add  A,    R3
		mov  R0,   A
		mov  @R0, #0x00
		inc  R3
		mov  A,  R3
		cjne A,  0x50, CP1
ret

main:	lcall zeroOut
here:	sjmp  here
end