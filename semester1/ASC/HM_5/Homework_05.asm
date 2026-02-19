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
    ;problem 15:
    ;Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the odd elements of A.
    
    A db '1','2','3','4'
    B db '5','6','7','8'
    
    L_A equ $-A
    L_B equ $-B
    
    R times (L_A + L_B) db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx,[L_B]
        mov esi,R   
        mov ebx,[L_B]
        
        start_loop:
            mov al,[B+ebx-1]         ;load the caracters from last to first
            mov [R+esi],al
            dec ebx
            inc esi
        loop start_loop         ; dec ecx(length of B) - loop stops whec ecx =0
        
        mov ecx,[L_A]
        mov edi,0
        mov esi,[L_B]
        
        loop_A:
        
            mov al,[A+edi]              ; store the elements one by one
            and al,1                    ; compare the least significant bit with 1
            jna is_odd                 ; if the value is odd jump to is_odd label
               is_even:
                inc edi                 ; move the index to the next element in A
                loop loop_A
            is_odd: 
                mov[R+esi],al           ; store the odd character
                inc esi                 ; go to the next position in R
                inc edi                 ; go to the next element in A
                loop loop_A             
            
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
