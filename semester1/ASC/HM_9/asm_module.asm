bits 32
; Declare external functions
extern _printf
global _asmConcat

section .data

section .text

_asmConcat:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]  ;first sentence address
    mov ebx, [ebp + 12] ;second sentence address


    find_end:
        cmp byte [eax], 0  ;check if it's the null terminator
        je concat_str2     ;if it's null concatenate the second sentence
        inc eax            
        jmp find_end

    concat_str2:
        mov edi, eax       ;edi points to the end of str1
        mov esi, ebx       ;esi points to the beginning of str2

    copy_str2:
        mov al, [esi]      
        mov [edi], al      ;store character into the first sentence
        inc esi            
        inc edi            
        cmp byte [esi], 0
        jne copy_str2
	
    mov byte [edi], 0

    mov esp, ebp
    pop ebp
    ret
