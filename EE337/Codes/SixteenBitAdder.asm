ORG  0H
LJMP MAIN
ORG  50H
ADDER_16BIT:
	mov  A,   61h	
	add  A,   71h
	mov  64h, A
	mov  A,   60h
	addc A,   70h
	mov  63h, A
	mov  A,   #0x00
	addc A,   #0x00
	mov  R0,  A
	
	mov  A,   60h
	rl   A
	anl  A,   #0x01
	mov  B,   #0xFF
	mul  AB
	mov  R1,  A
	mov  A,   70h
	rl   A
	anl  A,   #0x01
	mov  B,   #0xFF
	mul  AB
	
	add  A,   R1
	add  A,   R0
	anl  A,   #0x01
	mov  62h, A
RET

INIT:
	mov 60h, #0xFE
	mov 61h, #0xBE
	mov 70h, #0xFF
	mov 71h, #0xFF
RET

CLR_DATA:
	mov R0,  #0x40
	repeat_CP:
	mov @R0, #0x00
	mov A,   R0
	add A,   #0x01
	mov R0,  A
	cjne R0, #0xFF, repeat_CP
RET

ORG 0200H
MAIN:
	ACALL INIT
	ACALL ADDER_16BIT
	
 HERE:SJMP HERE
END