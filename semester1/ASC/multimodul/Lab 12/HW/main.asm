bits 32
global start

extern exit, printf, scanf, _permutations, _hexadecimal
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

; An unsigned number a on 32 bits is given. 
; Print the hexadecimal representation of a, but also the results of the circular permutations of its hex digits.

segment data use32 class=data
    a resd 1
    string resb 9

    b db 10

    ; Reserve 9 bytes for each permutation (8 ASCII characters plus the null terminator)
    ; We have at most 7 distinct permutations 
    buffer resb 9 * 7
    
    read_message db "Provide an unsigned number on 32 bits: ", 0
    print_message db "The hexadecimal representation of %u and its circular permutations are: ", 10, 0
    format db "%s", 10, 0
    read db "%u", 0

segment code use32 class=code
    start:
        ; Print the read message
        push read_message
        call [printf]
        add esp, 4

        ; Read the number from the console
        push a
        push read
        call [scanf]
        add esp, 4*2

        ; Determine the hexadecimal representation of a as a string
        push dword[a]
        push string
        ; As a result of this call, eax will hold the number of characters in the string
        call _hexadecimal
        add esp, 4*2

        ; Store the length of the string in ebx
        mov ebx, eax

        ; Determine the permutations for the string hexadecimal representation of a
        push string
        push ebx
        push buffer
        call _permutations
        add esp, 4*3
        ; As a result, the buffer will contain all of a's circular permutations

        ; Print the print message
        push dword[a]
        push print_message
        call [printf]
        add esp, 4*2

        ; Print the hexadecimal representation of a
        push string
        push format
        call [printf]
        add esp, 4*2

        ; Loop through the permutations and print them to the console
        mov ecx, ebx
        jecxz .end
        dec ecx

        mov esi, buffer
        jecxz .end
        .print_loop:
            ; Push the value of ecx to the stack
            push ecx

            ; Print the value to the console
            push esi
            push format
            call [printf]
            add esp, 4*2

            ; Move to the next permutation
            add esi, 9

            ; Restore the value of ecx from the stack
            pop ecx
        loop .print_loop

        .end:
        push dword 0
        call [exit]