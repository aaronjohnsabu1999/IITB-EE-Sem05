org  0000h
ljmp main

org  000Bh
ljmp T0ISR

org  0050h
T0ISR:	clr  TF0
		mov  TL0,  #00110111b
		mov  TH0,  #11111111b
		inc  R1
		cjne R1, #00001010b, CP1
		cpl  P3.2
		mov  R1, #0x00
		mov  A,   P1
		anl  A,  #00000111b
		add  A,  #00000010b
CP1: 	cjne A,   0x01,   exit
		cpl  P3.2
exit:	reti

main:	mov  P1,   #0x07
		mov  P3,   #0x00
		mov  R1,   #0x00
		mov  TMOD, #00000001b
		mov  IE,   #10000010b
		mov  TL0,  #10011011b
		mov  TH0,  #11111111b
		setb TR0
loop:	sjmp loop
end