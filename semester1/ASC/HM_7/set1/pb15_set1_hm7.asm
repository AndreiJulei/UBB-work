bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
extern exit, printf, scanf  ; adaugam printf si scanf ca functii externe           
import exit msvcrt.dll     
import printf msvcrt.dll     ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll     


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	
	;Sa se citeasca de la tastatura doua numere a si b (in baza 10) si sa se calculeze a+b. 
	;Sa se afiseze rezultatul adunarii in baza 16.
	
	format db "%d",0 	;decimal number
	message_1 db "Write the first decimal number: ",0
	message_2 db "Write the second decimal number: ",0
	
	final_format db "%x",0	;(base 16)
	final_message db "The result of the addition in hexa is: %x",0
	
	a dd 0
	b dd 0
	
; our code starts here
segment code use32 class=code
    start:
        ; ...
		push dword message_1
		call [printf]	
		add esp,4
		push dword a					;push the address of the first number
		push dword format	 		;push the format (decimal)
		call [scanf	]				;write the number from the keboard
		add esp,4*2					;free the stack 
		
		

		push dword message_2
		call [printf]
		add esp,4
		push dword b
		push dword format
		call [scanf]
		add esp,4*2
		
		mov ebx,0
		mov ebx,[b]
		mov ecx,0
		mov eax,[a]
		add eax,ebx
		

		
		push dword eax
		push dword final_message

		call [printf]
		add esp,4*2
		
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
