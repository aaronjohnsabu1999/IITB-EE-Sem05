org  0000h
ljmp main

org  0050h
main:	mov TL0,  #00010000b
		mov TH0,  #11111100b
		mov TMOD, #00000001b
		setb TR0
loop:	clr  A
		mov  C, TF0
		rlc  A
		cjne A, #0x01, loop
		clr  TF0
		cpl  P3.2
		mov  TH0,  #11111100b
		mov  TL0,  #00000010b
		sjmp  loop

end