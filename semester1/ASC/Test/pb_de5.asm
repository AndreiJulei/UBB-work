bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
extern printf,scanf

import printf msvcrt.dll
import scanf msvcrt.dll


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	primul_numar dd 0
	al_doilea_numar dd 0
	input dd "Scrie doua numere: "
	doi dd 2
	format dd '%d',0
	text_output db "Media aritmetica este: "
	
	

; our code starts here
segment code use32 class=code
    start:
        ; ...
		
		xor edx,edx
		push dword input
		call [printf]
		add esp,4
		
		push dword primul_numar
		push dword format
		call [scanf]
		add esp,4*2
		
		push dword al_doilea_numar
		push dword format
		call [scanf]
		add esp,4*2
		
		mov eax,dword[primul_numar]
		mov ebx,dword[al_doilea_numar]
		
		add eax,ebx
		xor edx,edx
		mov ecx,dword[doi]
		div ecx
		
		mov ebx,eax
		
		push text_output
		call [printf]
		add esp,4
		
		push ebx
		push dword format
		call [printf]
		add esp,4*2
		
		
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
