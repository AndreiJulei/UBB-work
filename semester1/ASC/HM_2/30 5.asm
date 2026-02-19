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
    a dw 10
    b dw 5
    c dw 11
    d dw 7
    ;a-b+(c-d+a)
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax,[a]
        mov bx,[b]
        sub ax,bx
        
        mov bx,[c]
        mov cx,[d]
        sub bx,cx
        mov cx,[a]
        add bx ,cx
        
        add ax, bx
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
