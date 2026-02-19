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
    ;Se dau cuvintele A si B. Se cere dublucuvantul C:
    ;bitii 0-2 ai lui C au valoarea 0
    ;bitii 3-5 ai lui C au valoarea 1
    ;bitii 6-9 ai lui C coincid cu bitii 11-14 ai lui A
    ;bitii 10-15 ai lui C coincid cu bitii 1-6 ai lui B
    ;bitii 16-31 ai lui C au valoarea 1
    a dw 13
    b dw 12
    c dd 0
    
; our code starts here

segment code use32 class=code
    start:
        ; ...
    mov ecx,[c]
    mov ax,[a]
    mov bx,[b]
    
    and ax,011110000000000         ; we isolate the bits 11-14
    shr ax,5                       ; move bits to pos 6
    or ecx,ax                      ; 
    
    and bx,0111111                 ; isolate the bits 1-6
    shl bx,9                       ; shift the bits to pos 
    or ecx,bx
    
    or ecx,0x11110000              ; set bits 16-31 to 1    
    rol ecx,32                     ; rotate the number
    mov [c],ecx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
