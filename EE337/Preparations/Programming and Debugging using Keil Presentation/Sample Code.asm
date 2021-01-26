;assembly is case insensitive language
;Do modular coding
;Give proper Indentation

org 0H
ljmp main
;as after 00h some locations are there for interrupt ISR

org 100H
main:
    mov r2, #1          ; r2 store the no.
    mov r1, 50H         ; reading the value of N
    mov r0, #50H        ; storing the 50h in register r0
                        ; used as a memory pointer
    mov a, 50H          ; moving content of location 50 h in accumulator
                        ; i.e. reading value of N
    jz here             ; checking whether N is zero or not
                        ; if N is zero then no need to do partial sum
                        ; else need to do partial sum
    mov a, #0           ; clearing the accumulator

    loop:   add a, r2       ; adding accumulator and register r2 content
            inc r2          ; incrementing the no.
            inc r0          ; incrementing the memory pointer
            mov @r0, a      ; storing the content of accumulator in memory
                            ; location equal to  the content of register r0
            djnz r1, loop   ; decrementing the content of r1 and checking whether it is
                            ; zero or not
                            ; if zero then stop the code
                            ; else repeat
    here : sjmp here        ; infinite loop like while(1)
end
