org 0h
ljmp main
org 100h
		
		main : 
			setb p1.4	;setting port pin 1.4 
			acall delay	;calling delay label
			clr p1.4	;clearing port pin 1.4
			acall delay	;calling delay label
			sjmp main	;short jump to main label
			
		;code lines written below will generate some delay
		
		
		delay :
			mov R2,#255
			
		delay1 : 
			mov R1, #255
			here : djnz R1, here
			djnz R2,delay1 
		ret	
			
end
				
