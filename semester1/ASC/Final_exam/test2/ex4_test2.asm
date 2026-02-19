bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll

extern scanf,printf
import scanf msvcrt.dll
import printf msvcrt.dll

                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	numar dd 0
	format dd '%d',0
	sir_final resb 10
	
	sir_fin resb 10
	
	sir_initial resd 10
	
; our code starts here
segment code use32 class=code
    start:
        ; ...
		push numar
		push format
		call [scanf]
		add esp,4*2
		
		mov ebx,[numar]
		
		mov esi,sir_initial
		citire:
			dec ebx
			push numar
			push format
			call [scanf]
			add esp,4*2
			mov eax,[numar]
			
			mov dword[esi],eax
			add esi,4
			cmp ebx,0
		jnz citire
		
		mov esi,sir_initial
		mov edi,sir_final
		
		mov ecx,[numar]
		
		creare_sir_final:
			mov eax,dword[esi]
			
			cmp eax,0
			jz final
			
			add esi,4
			xor ebx,ebx
			verificare:
				cmp eax,0
				jz next
				
				xor edx,edx
				mov ebx,10
				div ebx 		;edx are ultima cifra
				test edx,01		; verificam daca este para sau impara
				jnz verificare	; daca este impara mergem la urmatoarea
				
				mov byte[edi],dl
				inc edi
			jmp verificare
			
			next:
				mov byte[edi],' '
				inc edi
				
			jmp creare_sir_final
			
				
		final:
		
			mov esi,sir_final
			mov edi,sir_fin
			
			dupa_fiecare_numar:
			mov edx,1
			xor ebx,ebx
			formare_numere:
				mov al,byte[esi]
				inc esi
				cmp al,' '
				jz next_number
				
				cmp al,0
				jz finalizare
				
				mul dl
				add ebx,eax
				mov al,dl
				mov dl,10
				mul dl
				mov edx,eax
			jmp formare_numere
			next_number:
				mov [edi],dword ebx
				add edi,4
				mov byte [edi],' '
				inc edi
			jmp dupa_fiecare_numar
			
			
		finalizare:
		;Trebuie facuta afisarea
		
			
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
