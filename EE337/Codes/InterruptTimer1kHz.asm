org  0000h
ljmp main

org  000Bh
ljmp T0ISR

org  0050h
T0ISR:	clr  TF0
		mov TL0,  #00011000b
		mov TH0,  #11111100b
		cpl  P3.2
reti
		
main:	mov  TL0,  #00000010b
		mov  TH0,  #11111100b
		mov  TMOD, #00000001b
		mov  IE,   #10000010b
		setb TR0
loop:	sjmp loop
end