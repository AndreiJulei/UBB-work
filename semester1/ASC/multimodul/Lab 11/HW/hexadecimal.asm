bits 32
global _hexadecimal

segment data use32 class=data
    table db "0123456789ABCDEF", 0

segment code use32 class=code
    _hexadecimal:
        push ebp
        mov ebp, esp

        ; Push ebx and edi to the stack
        push ebx
        push edi

        ; Move the value of a into eax
        mov eax, dword[ebp + 12]

        ; We have a special case where a is 0
        cmp eax, 0
        ja .alg

        mov edi, dword[ebp + 8]
        mov byte[edi], '0'

        ; Set eax to the number of hex digits of the number
        mov eax, 1

        ; Restore the value of edi
        pop edi

        ; Restore the value of ebx
        pop ebx

        pop ebp
        ret 

        .alg:

        ; Initializa ecx with 0
        xor ecx, ecx

        ; Count the number of hex digits of a
        .count_hex_digits:
            cmp eax, 0
            je .done

            inc ecx

            ; Convert the doubleword from eax to the quadword edx:eax
            xor edx, edx

            mov ebx, 16
            div ebx

            jmp .count_hex_digits
        .done:

        ; Move the value of a into eax
        mov eax, dword[ebp + 12]

        ; Move the starting address of the buffer into edi
        mov edi, dword[ebp + 8]

        ; Add the number of hex digits to the address
        add edi, ecx

        ; Subtract 1 from the address
        sub edi, 1

        ; Set the direction flag to 1 so edi decreases
        std

        ; Build the memory location
        .build_hexadecimal:
            cmp eax, 0
            je .build_hexadecimal_end

            ; Convert the doubleword from eax to the quadword edx:eax
            xor edx, edx

            mov ebx, 16
            div ebx

            ; Convert the remainder to an ASCII character
            mov ebx, table
            ; Push eax to the stack
            push eax
            mov al, dl
            xlat ; The corressponding value from the table is stored into al

            ; Store the byte to the corressponding location in memory
            stosb

            pop eax

            jmp .build_hexadecimal
        .build_hexadecimal_end:

        ; Set eax to the number of hex digits of the number
        mov eax, ecx

        ; Restore the value of edi
        pop edi

        ; Restore the value of ebx
        pop ebx

        pop ebp
        ret