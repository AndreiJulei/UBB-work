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
	sir dq 1110111b,10000000h,0abcd0002e7fch,5
	len equ ($-sir)/8
	format dd '%d',0
	format_string dd '%s',0
	rez resd len
	
	
; our code starts here
segment code use32 class=code
    start:
        ; ...
		mov esi,sir
		mov edi,rez
		mov ecx,len
		cld
		
		repeta:
			xor ebx,ebx
			LODSD
			cmp eax,0
			jz _exit
			
			
			mov edx,eax
			verifying:
				cmp eax,0
				jz done
				
				test eax,01
				jnz next1
				
				shr eax,1
				jmp verifying
				
				
				next1:
				test eax,010
				jnz next2
				
				shr eax,2
				jmp verifying
				
				
				next2:
				test eax,0100
				jnz count
				
				shr eax,3
				jmp verifying
				
				count:
					shr eax,3
					inc ebx
				jmp verifying
			
			
			done:
			
				cmp ebx,2
				jge add_dword
			comeback:
				LODSD
				
			loop repeta

				
			add_dword:
				mov dword[edi],edx
				add edi,4
				jmp comeback
		
		_exit:	
			mov esi,rez
			
			afisare:
				mov eax,dword[esi]
				cmp eax,0
				jz finish_program
				
				add esi,4
				
				push eax
				push format
				call [printf]
				add esp,4*2	

				
				mov eax,' '
				push eax
				push format_string
				call [printf]
				add esp,4*2
				
				add esi,4
				
			jmp afisare
		
		finish_program:
		
		
		
		
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
