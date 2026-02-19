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
	sir dd -1,123456,0xabcdeff,0xabcdeff,0xcbcdeff,0xdbcdeff
	len equ ($-sir)/4
	format dd '%x',0
	sir_sume resd len
	

; our code starts here
segment code use32 class=code
    start:
        ; ...  
		mov esi,sir
		mov edi,sir_sume
		mov ecx,len
		
		repeta:
			xor ebx,ebx
			xor edx,edx
			
			lodsd
			cmp eax,0
			jz done
			adunare_cifre_numar:
				mov bl,al
				shr eax,4
				and bl,1111b
				add edx,ebx
				cmp eax,0
				jz store_sum
			jmp adunare_cifre_numar
			
			store_sum:
				mov byte[edi],dl
				inc edi
				
		loop repeta
		
		mov edi,sir
		mov esi,sir_sume
		lodsb
		mov bl,al
		mov edx,[edi]
		add edi,4
		
		done:
			lodsb
			cmp al,0
			jz exit_
			
			mov bh,al
			mov eax,[edi]
			add edi,4
			
			cmp bl,bh
			jl store_numbers
		
		comeback:
			mov bl,bh			
			mov edx,eax
		jmp done
		
		store_numbers:
			push edx
			push format
			call [printf]
			add esp,4*2
		jmp comeback
		
		exit_:
		
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
