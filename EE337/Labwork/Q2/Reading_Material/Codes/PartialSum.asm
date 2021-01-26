org  0h
ljmp main
org  100h
main:
	mov R3,  50h
	mov R1,  #1		;number
	mov R2,  #1		;present partial sum
	mov R0,  #51h	;location for partial sum
	mov A,	 50h
	jz  here
	mov A,   R2
	mov @R0, A
	mov A,	 50h
	subb A,  #1
	jz  here
	
here1:
	mov A,	 R1
	add A,	 #1
	mov R1,	 A
	add A,	 R2
	mov R2,	 A
	mov A,	 R0
	add A,	 #1
	mov R0,	 A
	mov A,	 R2
	mov @R0, A
	mov  A,	 R1
	cjne A,	 50h, here1
	
here:
	sjmp here

end