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
	s dd 0702090Ah, 0B0C0304h, 05060108h
	l equ ($-s)/4
	r times l*2 db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
		mov esi,s
		mov ecx,l*2
		xor eax,eax
		xor ebx,ebx
		mov edi,r
		
		repeta:
			mov bl,byte[esi]
			inc esi
			mov al,byte[esi]
			inc esi
			mov dl,16
			mul dl
			add al,bl
			
			mov byte[edi],al
			inc edi
		loop repeta
		
		mov esi,r
		mov ecx,l*2 
		dec ecx 			; for bubble sort 
    
    bubblesort_outer_loop:
        mov edi,0                   ; index for esi

        bubblesort_inner_loop:
            mov al, [esi + edi]      ; load the current byte
            mov bl, [esi + edi + 1]  ; load the next byte
            cmp al, bl               ; compare the two bytes
            jg swap_octets           ; if al > bl, swap the two bytes

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
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
