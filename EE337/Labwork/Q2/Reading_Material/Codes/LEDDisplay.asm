org 0000h
ljmp main
org 0100h

read:	mov A,  P1
		anl A, #0x0F
		mov R1, A
ret

delayBy4:
		mov  B,   R1
		mov  R4,  B
back0:	mov  R5, #0x05
back1:	mov  R6, #0xC8
back2:	mov  R7, #0xFF
back3:	djnz R7,  back3
		djnz R6,  back2
		djnz R5,  back1
		djnz R4,  back0
ret

main:	mov  P1, #0xFF
		lcall read
mech:	lcall delayBy4
		cpl  P1.5
		lcall delayBy4
		cpl  P1.5
		cpl  P1.6
		lcall delayBy4
		cpl  P1.5
		lcall delayBy4
		cpl  P1.5
		cpl  P1.6
		cpl  P1.7
		lcall read
		sjmp  mech
end