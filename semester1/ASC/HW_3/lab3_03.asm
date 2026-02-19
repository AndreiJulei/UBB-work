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
    ;a-word; b,c-byte; e-doubleword; x-qword
    a dw 10
    b db 9
    c db 9
    e dd 11
    x dq 12
    
; our code starts here
segment code use32 class=code
    start:
    ;Problema 30:
    ;a*b-(100-c)/(b*b)+e+x
        ; ...
    mov eax,0
    mov ax,[a] 
    mov bl,[b]
    
    mul bl      ;ax= a*b
    mov cx,ax
    
    mov cl,100
    mov dl,[c]
    sub cl,[c]  ; cl=100 - c
    mov ch,0
    
    mov al,[b]
    mul al      ;ax= b*b
    
    mov dx,ax   
    mov ax,cx   ; mov 100-c in ax so we can divide
    
    div dx      ; ax=(100-c)/(b*b)
    
    add ax,cx   ; add in ax a*b
    
    mov ecx,[e]
    
    add eax,ecx     ; add in ax e-doubleword
    
    mov ecx,dword[x]
    add eax,ecx         ; add the lower half of the x-qword in eax
    mov edx,dword[x+4]  ; mov the upper half of x in edx
    
    mov ebx,0
    adc edx,ebx     ; add the carry if needed in edx 
                   
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
