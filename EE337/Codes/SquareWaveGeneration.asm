org		0000h
ljmp	main

org		000Bh
ljmp	T0ISR

org		0050h
T0ISR:	clr		TF0
		mov		TL0,	#00011100b
		mov		TH0,	#11111100b
		djnz	R0,		ISREnd
		mov		R0,		#11111010b
		djnz	R1,		ISREnd
		mov		R1,		#00000100b
		cpl		P3.2
ISREnd:	reti

main:	mov		R0,		#11111010b
		mov		R1,		#00000100b
		mov		TL0,	#00011100b
		mov		TH0,	#11111100b
		mov		TMOD,	#00000001b
		mov		IE,		#10000010b
		setb	TR0
loop:	sjmp	loop
end