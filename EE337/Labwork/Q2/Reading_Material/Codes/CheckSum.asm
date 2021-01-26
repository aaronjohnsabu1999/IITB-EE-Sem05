ORG 00H
LJMP MAIN
ORG 50H

INIT:
	clr A
	mov R0, #0x01
	mov R1, #0x40
	
	CP1:
	mov A,   R0
	mov @R1, A
	mov A,   R1
	add A,   #0x01
	mov R1,  A
	mov A,   R0
	add A,   #0x01
	mov R0,  A
	cjne A,  #41, CP1
RET

ADD_40:
	mov  R0,  #0x40
	mov  R2,  #0x00
	
	CP2:
	mov  A,   @R0
	add  A,   R2
	mov  R2,  A
	mov  A,   R0
	add  A,   #0x01
	mov  R0,  A
	cjne A,   #0x68, CP2
	
	mov  0x68, R2
RET
	
TWOS_COMP:
	mov  A,   0x68
	cpl  A
	add  A,   #0x01
	mov  0x68, A	
RET

ADD_41:
    mov  R0,  #0x40
	mov  R2,  #0x00
	
	CP3:
	mov  A,   @R0
	add  A,   R2
	mov  R2,  A
	mov  A,   R0
	add  A,   #0x01
	mov  R0,  A
	cjne A,   #0x69, CP3
	
	mov  0x69, R2
RET

ORG 0200H
MAIN:
	ACALL INIT
	ACALL ADD_40
	ACALL TWOS_COMP
	ACALL ADD_41
	HERE:SJMP HERE
END