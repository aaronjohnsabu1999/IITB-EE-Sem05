org 0000H
ljmp main

org 0100H
delay:							;Delay of 50-60 ms
		mov  R7, #0xC8
back0:	mov  R6, #0xFF
back1:	djnz R6,  back1
		djnz R7,  back0
ret

main:
		mov  P1, #0x00	;Sets P1 as output
		mov  R5, #0x00	;Stores direction - 0x00 if inc, 0x01 if dec
		mov  R4, #0x00	;Stores value to be fed to P1
loop:	mov  P1, R4
		lcall delay
		
		mov  A,  R4
		cjne A,  #250,  decM
		mov  R5, #0x01
decM:	cjne A,  #0x00, incM
		mov  R5, #0x00
		
incM:	add  A,  #0x32
		cjne R5, #0x01, incCP
		subb A,  #0x64
		
incCP:	mov  R4, A
		ljmp loop
end