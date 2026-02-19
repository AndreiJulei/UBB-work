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
    ;a - byte, b - word, c - double word, d - qword - Interpretare cu semn
    a db 10
    b dw 11
    c dd 12
    d dq 13

; our code starts here
segment code use32 class=code
    ;Problema 2
    ;d-a+c+c-b+a
    
    start:
        ; ...
    mov eax,0
    mov al, [a]         ; eax = a 
    mov ebx, 0
    mov bx,[b]          ; ebx = b 
    mov ecx, [c]        ; ecx = c (dword is already 32-bit)
    mov edx, dword [d]  ; edx = d (treat as dword)
    
    sub edx, eax            
    ;edx= d - a
    
    add edx, ecx          
    ;edx= d - a + c
    
    add edx, ecx             
    ;edx= d - a + c + c
    
    sub edx, ebx             
    ;edx= d - a + c + c - b
    
    add edx, eax             
    ;edx= d - a + c + c - b + a
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
