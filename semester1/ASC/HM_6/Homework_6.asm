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
	;Problema 15:
    ;Se da un sir S de dublucuvinte.
    ;Sa se obtina sirul D format din octetii dublucuvintelor din sirul D sortati in ordine descrescatoare in interpretarea fara semn.
    
    s dd 12345607h, 1A2B3C15h
    len_s equ ($-s)/4
    
    d times 4*len_s db 0
    
    ; our code starts here
segment code use32 class=code
    start:
        ; ...
    mov esi,s              ; move s in esi so we can work with string instructions
    mov ecx,len_s          ; ecx-number of elements in s
    mov edi,d              ; edi-pointer to d
    cld					   
		
    loop_load:
        lodsd              ; load the next double word from `s` into the EAX register (EAX = *esi)
        stosb              ; load the least first significant byte into d
        shr eax,8          ; shift eax to the right with 8 bits so we get the second byte in al
        stosb               
        shr eax,8
        stosb
        shr eax,8
        stosb
        shr eax,8            
    loop loop_load
    
    
    mov ecx,4*len_s             ; ecx=length of d
    dec ecx                     ; for bubble sort 
    
    bubblesort_outer_loop:
        mov edi,0                   ; index for esi

        bubblesort_inner_loop:
            mov al, [esi + edi]      ; load the current byte
            mov bl, [esi + edi + 1]  ; load the next byte
            cmp al, bl               ; compare the two bytes
            jl swap_octets           ; if al < bl, swap the two bytes

        ; Move to the next pair
        inc edi
        cmp edi, ecx                 ; if edi < ecx go back 
        jl bubblesort_inner_loop
        ; Move to outer loop
        dec ecx
        jnz bubblesort_outer_loop   
        jmp end_

    swap_octets:

		mov dl,al
        mov al,bl
        mov bl,dl                       ; swap the two elements
        mov [esi + edi], al             ; store the bigger value in al
        mov [esi + edi + 1], bl         ; store the smaller value in bl
        
	    jmp bubblesort_inner_loop     
    
    end_:
        ; exit(0)
        push    dword 0      
        call    [exit]       
