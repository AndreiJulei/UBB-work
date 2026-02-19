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
	a db 1
	b dw 2
	c dd 3
	d dq 4

; our code starts here
segment code use32 class=code
    start:
        ; ...
		;(b+c+a)-(d+c+a)
		mov eax,0
		mov ebx,0
		mov ecx,0
		mov edx,0
		
		mov al,byte[a]
		mov bx,word[b]
		add eax,ebx		;a+b
		
		mov ecx,[c]
		
		add ecx,eax		;ecx =(a+b+c)
		
		mov eax,dword[d]
		mov edx,dword[d+4]
		
		mov ebx,[c]
		add eax,ebx		;d+c
		adc edx,0
		mov ebx,0
		mov bl,[a]
		add eax,ebx		;eax=d+c+a
		adc edx,0
		
		sub ecx,eax
		sbb edx,0
		
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
