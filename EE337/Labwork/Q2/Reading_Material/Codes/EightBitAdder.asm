org  0h
ljmp main
org  100h
main:
mov  A,   50h
add  A,   60h
mov  70h, A
mov  A,   #0
addc A,   #0
mov  71h, A

here: sjmp here
end