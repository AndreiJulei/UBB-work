bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll

extern printf 
import printf msvcrt.dll

                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	sir dd 1234A678h,12345678h,0FEDC9876h
	sum dd 0
	max db 0
	len equ ($-sir)/4
	cnt db 0
	sir_max resb len
	
	rank resb len
	format dd "%d",0
	

; our code starts here
segment code use32 class=code
    start:
        ; ...
		mov esi,sir
		mov edi,sir_max
		
		mov ecx,len
		xor ebx,ebx
		xor edx,edx
		
		repeta:
			lodsd
			mov bl,al
			shr eax,8
			mov dl,al
			cmp dl,bl
			jle next1
			mov bl,dl

			next1:
				shr eax,8
				mov dl,al
				cmp dl,bl
				jle next2
				mov bl,dl
			
			next2:
				shr eax,8
				mov dl,al
				cmp dl,bl
				jle next3
				mov bl,dl
		next3:
		mov [edi],bl
		inc edi
		loop repeta
		
		mov esi,sir_max
		mov ecx,len
		xor ebx,ebx
		xor eax,eax
		
		adunare:
			mov al,byte[esi]
			add ebx,eax
			inc esi
		loop adunare
		
		mov dword[sum],ebx
		
		push sum
		push format
		call [printf]
		add esp,4*2
		
		mov ecx,len
		mov esi,sir_max
		xor edx,edx
		xor eax,eax
		xor ebx,ebx
		
		rank_outer:
			mov al,byte[esi]
			mov edi,sir_max
			
			xor ebx,ebx
			mov edx,len
			rank_inner:
				mov bl,byte[edi]
				inc edi
				dec edx
				
				cmp al,bl
				jg count
			
				cmp edx,0
				jnz rank_inner
				
				jmp create_rank
			
			count:
				inc byte[cnt]
			jmp rank_inner
		create_rank:
		
		mov bl,byte[cnt]
		mov [rank],byte bl
		inc esi
		loop rank_outer
		
		
				
			
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
