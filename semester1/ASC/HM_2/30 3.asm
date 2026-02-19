bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 25
    b db 10
    c db 8
    d dw 18
    ;[(a-b)*5+d]-2*c
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov al,[a]
        mov bl,[b]
        sub al,bl
        
        mov cl,5
        mul cl
        mov bx,[d]
        add ax,bx
        
        mov cx,ax
        mov bl,2
        mov al,[c]
        mul bl
        
        
        sub cx,ax        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
