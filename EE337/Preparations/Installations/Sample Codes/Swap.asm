Org 0h
ljmp main
Org 100h
main:
	MOV 70H,#20H    ;Loading value 20h in memory location 70h
	MOV 71H,#21H	;Loading value 21h in memory location 71h

	MOV A,70H	;Moving the content of memory location 70h to accumulator
	MOV 70H,71H	;Moving the content of memory location 71h to memory location 70h
	MOV 71H,A	;Moving accumulator content into memory location 71h
 
HERE:SJMP HERE		
END
