org  0000h
ljmp main
org  0100h

check:						;RESERVE: R3, R4, R7, USE: A, B
		mov R3, #0x00			;Stores instantaneous number of divisors of the number of interest
		mov R4, #0x00			;Stores instantaneous divisor
		
CP1:	inc R4
		mov A,  R2				;Stores number of interest
		mov B,  R4				;Stores instantaneous divisor
		subb A, B
		jz CPx					;If A=B, end check
		mov A,  R2
		div AB					;If it divides, B=0
		mov R7, B				;R7 stores B (temp)
		cjne R7, #0x00, CP2		;If B!=0, it is not a proper divisor
		inc  R3					;If B==0, it is a proper divisor
CP2:	ljmp CP1				;repeat the check with a new divisor
CPx:	mov A, R3
ret

main:						;RESERVE: R0, R1, R2, 50h, 51h, 52h ..., USE: A
		mov R1,   50h			;Stores value of N
		;mov 51h, #0x02			;Stores initial prime
		mov R2,  #0x01			;Stores number of interest
		mov R0,  #0x51			;Stores storage location
nextNo: inc R2
		lcall check
		cjne A, #0x01, isNotPm
;isPrm:	
		mov  A,   R2
		mov @R0,  A
		inc  R0
isNotPm:mov  A, R2
		cjne A, 50h, nextNo
here:	sjmp here
end