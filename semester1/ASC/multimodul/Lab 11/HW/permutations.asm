bits 32
global _permutations

segment code use32 class=code
    _permutations:
        push ebp
        mov ebp, esp

        ; Push the value of esi to the stack
        push esi

        ; Push the value of edi to the stack
        push edi

        ; Push the value of ebx to the stack
        push ebx

        ; Move the length of the string into edx
        mov edx, dword[ebp + 12]

        ; Move the starting adress of the buffer into edi
        mov edi, dword[ebp + 8]

        ; Set the direction flag to 0
        cld

        ; We use ebx as a main counter
        mov ebx, edx

        .while_permutations:
            cmp ebx, 0
            je .end_while_permutations

            ; Move the starting address of the string into esi
            mov esi, dword[ebp + 16]

            ; We use ecx as a counter
            mov ecx, edx

            jecxz .end
            mov ah, [esi]
            .rotate:
                mov al, [esi + 1]
                mov [esi], al

                inc esi
            loop .rotate
            mov [esi - 1], ah

            ; Store the rotated string in memory only if ebx > 1 (we do not want dupes)
            cmp ebx, 1
            je .skip
                ; Move the starting address of the string into esi
                mov esi, dword[ebp + 16]

                ; We use ecx as a counter
                mov ecx, edx

                jecxz .end
                .move:
                    movsb
                loop .move

                ; Reset edi to the next permutation
                add edi, 9
                sub edi, edx
            .skip:

            dec ebx
            jmp .while_permutations
        .end_while_permutations:

        .end:

        ; Restore the value of ebx from the stack
        pop ebx

        ; Restore the value of edi from the stack
        pop edi

        ; Restore the value of esi from the stack
        pop esi

        pop ebp
        ret