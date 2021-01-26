org 0H
ljmp main

org 100H
main:
		mov r2, #1          
		mov r1, 50H			;was #50h instead of 50h
		mov r0, 51H			;was #51h instead of 51h, r3 instead of r0
		mov a,	50H
		jz here

loop:	mov a, r2			;was #0h instead of r2
		mov b, r2
		mul ab				;was mul a b instead of mul ab
		mov @r0,a			;was @r3 instead of @r0
		inc r0				;was r3 instead of r0
		inc r2				
		djnz r1, loop		
here: sjmp here        

end