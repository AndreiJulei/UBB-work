bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
extern printf,scanf
import printf msvcrt.dll     ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll     ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	;Sa se citeasca de la tastatura doua numere (in baza 10) si sa se calculeze produsul lor. Rezultatul inmultirii se va salva in memorie in variabila "rezultat" (definita in segmentul de date).
	format db "%d",0
	rezultat dd 0
	primul_numar dd 0
	aldoilea_numar dd 0
	
	text db "Scrie doua numere: "
	
; our code starts here
segment code use32 class=code
    start:
        ; ...
		push dword text
		call [printf]
		add esp,4
		
		push dword primul_numar
		push dword format
		call [scanf]
		add esp,4*2
		
		push dword aldoilea_numar
		push dword format
		call [scanf]
		add esp,4*2
		
		mov eax,[primul_numar]
		mov ebx,[aldoilea_numar]
		mul ebx
		
		mov dword[rezultat],eax
		
		
		
		
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
