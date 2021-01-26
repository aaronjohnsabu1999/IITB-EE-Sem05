org  0000h
ljmp main
org  0100h

readNibbles:
		mov P1,  #0xFF		; set P1.7-P1.4 and configure P1.3-P1.0 as input
		lcall delayFive		; delay of 5 sec
		anl P1,  #0x0F		; clear P1.7-P1.4
		lcall delayOne		; delay of 1 sec
		mov A,    P1		; accept input into accumulator
		mov R0,   A			; store input in R1
		swap A				; store P1.3-P1.0 in P1.7-P1.4 (and vice versa)
		mov  P1, A
		lcall delayFive		; delay of 5 sec
ret

packNibbles:
		mov  A,    0x4E
		swap A
		anl  A,   #0xF0
		mov  R1,   A
		mov  A,    0x4F
		anl  A,   #0x0F
		add  A,    R1
		mov  0x50, A
ret

delayFive:
		mov R2, #0x05
CP1:	lcall delayOne
		djnz R2, CP1
ret

delayOne:
		mov  R5, #0x14
back1:	mov  R6, #0xC8
back2:	mov  R7, #0xF9
back3:	djnz R7,  back3
		djnz R6,  back2
		djnz R5,  back1
ret

main: 	lcall readNibbles
		mov   0x4E, R0
		lcall readNibbles
		mov   0x4F, R0
		lcall packNibbles
		ljmp main
end