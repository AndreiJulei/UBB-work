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
	s db '+', '4', '2', 'a', '8', '4', 'X', '5'
	ls equ $-s
	
	d db 'a', '4', '5'
	ld equ $-d
	
	dest times ld+ls db 0
	
	
; our code starts here
segment code use32 class=code
    start:
        ; ...
		xor ecx,ecx
		xor eax,eax
		xor ebx,ebx
		xor edx,edx
		
		mov cl,ls-1
		mov esi,s
		mov edi,dest
		mov dl,0
	
		repeta:
			xor eax,eax
			mov al,dl
			mov bl,3
			div bl
			cmp ah,0
			jz retine

			next:
			inc dl
			cmp dl,cl
			jnz repeta
		jmp end_
		
		retine:
				mov bl,byte[esi+edx]
				mov byte[edi],bl
				inc edi
				jmp next
		end_:
		
		xor ecx,ecx
		mov ecx,ld
		
		mov esi,d
		add esi,ld-1
		std
		xor eax,eax
		stocare:
			lodsb 
			mov byte[edi],al
			inc edi
		loop stocare
			
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
