bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
extern fprintf, fread, fopen, fclose, scanf, printf
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll		  
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	
	input db "input.txt",0
	output db "output.txt",0
	buffer resb 100
	id dd 0
	sir_final resb 100
	access_write db "w",0
	access_read db "r",0
	string db "%s",0
	

; our code starts here
segment code use32 class=code
    start:
        ; ...
		
		push access_read
		push input
		call [fopen]
		
		mov [id],eax
		
		mov edi,sir_final
		
		push eax
		push 100
		push 1
		push buffer
		call [fread]
		
		mov esi,0
		
		modificare_sir:
			mov al,byte[buffer+esi]
			cmp al,0
			je done 
			
			cmp al,"0"
			jl stocare_litera
			
			cmp al,"9"
			jg stocare_litera
			
			cmp al,"9"
			je stocare_noua
			
			inc al
			
			stocare_litera:
				mov byte[edi],al
				inc edi
				inc esi
			jmp modificare_sir	
			
			stocare_noua:
				mov ah,"1"
				mov al,"0"
				mov byte[edi],ah
				inc edi
				mov byte[edi],al
				inc edi
				inc esi
			jmp modificare_sir
		
		done:
    
		push dword [id]
		call [fclose]
		add esp,4
		
		push access_write
		push output
		call [fopen]
		add esp,4*2
		
		mov [id],eax

		push sir_final
		push string
		push dword [id]
		call [fprintf]
		add esp,4*2
		
		push dword[id]
		call [fclose]
		
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
