bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll

extern printf,scanf
import printf msvcrt.dll
import scanf msvcrt.dll

                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	sir dd 1234A678h,12785634h,1A4D3C28h
	len equ ($-sir)/4
	numb_of_ones db 0
	
	format dd "%d",0
	format_decimal db "%d",0
	
	sir_final resw len*2
	
	;problema facut fara numarul de biti 1 in baza 2 a numerelor din sirul final(nu e greu)

; our code starts here
segment code use32 class=code
    start:
        ; ...
		
		mov esi,sir
		mov edi,sir_final
		
		cld
		mov ecx,len
		
		repeta:
			
			lodsd			;eax has a dword that we can work with 
			mov edx,eax
			
			mov bl,ah
			
			shr eax,16
			
			mov bh,ah
			
			mov [edi],bx
			add edi,2
			
		loop repeta
		
		
		mov esi,sir_final
		mov ebx,len
		print_result:
			dec ebx
			mov ax,word[esi]
			add esi,2
			push eax
			push dword format
			call [printf]
			add esp,4*2			
			cmp ebx,0
		jnz print_result
		
		xor eax,eax
		mov al,[numb_of_ones]
		push eax
		push format_decimal
		call [printf]
		add esp,2*4
		
		
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
