bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
extern printf,scanf

import printf msvcrt.dll
import scanf msvcrt.dll


segment data use32 class=data
    ; ...
	;Sa se citeasca de la tastatura un numar in baza 10 si un numar in baza 16. Sa se afiseze in baza 10 numarul de biti 1 ai sumei celor doua numere citite. Exemplu:
	;a = 32 = 0010 0000b
	;b = 1Ah = 0001 1010b
	;32 + 1Ah = 0011 1010b
	
	text_10 db "Scrie un numar in baza 10: ",0
	text_16 db "Scrie un numar in baza 16: ",0

	format_numar_baza_10 db "%d",0
	format_numar_baza_16 db "%x",0
	numar_baza_10 db 0
	numar_16 db 0	
	
;Se va afisa pe ecran valoarea 4.
; our code starts here
segment code use32 class=code
    start:
        ; ...
		push dword text_10
		call [printf]
		add esp,4
		
		push numar_baza_10
		push format_numar_baza_10
		call [scanf]
		add esp,4*2
		
		mov ebx,[numar_baza_10]
		
		push dword text_16
		call [printf]
		add esp,4
		
		push numar_16
		push format_numar_baza_16
		call [scanf]
		add esp,4*2
		
		mov eax,[numar_16]
		add eax,ebx
		
		mov ebx,2
		xor ecx,ecx
		
		repeta:
			div ebx
			cmp edx,1
			jz result
			next:
			cmp eax,0
		jnz repeta
		
		jmp afisare
		
		result:
		inc ecx
		jmp next
		
		
		afisare:
		
		push dword ecx
		push format_numar_baza_10
		call [printf]
		add esp,4*2
		
		
		
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
