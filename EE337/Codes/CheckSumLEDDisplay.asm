org  0000h
ljmp main
org  0100h

readNibbles:
		mov P1, #0xFF		; set P1.7-P1.4 and configure P1.3-P1.0 as input
		mov R2, #0x05
		lcall delayT		; delay of 5 sec
		anl P1, #0x0F		; clear P1.7-P1.4
		mov R2, #0x01
		lcall delayT		; delay of 1 sec
		mov A,    P1		; accept input into accumulator
		mov R0,   A			; store input in R1
		swap A				; store P1.3-P1.0 in P1.7-P1.4 (and vice versa)
		mov P1, A
		mov R2, #0x05
		lcall delayT		; delay of 5 sec
ret

packNibbles:
		mov  A,  0x4E
		swap A
		anl  A, #0xF0
		mov  R1, A
		mov  A,  0x4F
		anl  A, #0x0F
		add  A,  R1
		mov @R0, A
ret

delayT:
back0:	mov  R5, #0x14
back1:	mov  R6, #0xC8
back2:	mov  R7, #0xF9
back3:	djnz R7,  back3
		djnz R6,  back2
		djnz R5,  back1
		djnz R2,  back0
ret

checkSum:
		mov A, 0x50
		add A, 0x51
		cpl A
		inc A
		mov 0x52, A
		mov  P1,  A
		mov R2, #0x02
		lcall delayT
		swap A
		mov  P1,  A
		mov R2, #0x02
		lcall delayT
ret

main: 	lcall readNibbles
		mov   0x4E, R0
		lcall readNibbles
		mov   0x4F, R0
		mov   R0,  #0x50
		lcall packNibbles
		
		lcall readNibbles
		mov   0x4E, R0
		lcall readNibbles
		mov   0x4F, R0
		mov   R0,  #0x51
		lcall packNibbles
		
		lcall checkSum
		
		ljmp main
end
	
	
	
	
	1010 1011 + 1100 1101
	1000 10000