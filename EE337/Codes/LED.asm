; BLINKING LEDS OF PORT0
LED EQU P0
ORG 00H
LJMP MAIN
ORG 50H

DELAY:
	USING 0					; REGISTER BANK 0
        PUSH PSW
        PUSH AR1
        PUSH AR2

        MOV R1, #0FFH
        MOV R2, #0FFH
DELAY1:
        NOP
        DJNZ R1, DELAY1
        DJNZ R2, DELAY1

        POP AR2
        POP AR1
        POP PSW
        RET

;----------------------------------------------------------------------

MAIN:
		MOV LED, #00H		; MAKE P0 OUTPUT PORT
		MOV A,   #55H     	; 0b01010101
	
BACK:	MOV LED, A
		LCALL DELAY
		CPL A				; 0b10101010
		SJMP BACK			; INFINITE LOOP

;--------------------------------------------------------------------------
