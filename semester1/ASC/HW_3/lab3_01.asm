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
    a db 10
    b dw 11
    c dd 12
    d dq 13
    carry dd 0
    
; our code starts here
segment code use32 class=code
    ;Problema 30:
    ;(b+c+a)-(d+c+a)
    start:
        ; ...
    mov ax,0
    mov al,[a]
    mov ebx,0
    mov bx,[b]
    add bx,ax
    ; bx=(a+b)
    
    mov ecx,dword[c]
    add ebx,ecx
    ;ebx=(a+b)+c
    
    
    mov eax,dword[d]
    mov edx, dword[d+4]
    ;store the quad word in two separate registers
    
    add eax,ecx     ;eax=d+c
    
    mov ecx,0
    mov cl,[a]
    adc eax,ecx     ;eax=d+c+a
    
    sub ebx,eax
    
    
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
