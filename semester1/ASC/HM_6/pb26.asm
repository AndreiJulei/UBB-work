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
;Se da un sir de 3 dublucuvinte, fiecare dublucuvant continand 2 valori pe cuvant (despachetate, deci fiecare cifra hexa e precedata de un 0). Sa se creeze un sir de octeti care sa contina acele valori (impachetate deci pe un singur octet), ordonate crescator in memorie, acestea fiind considerate numere cu semn.

	s DD 12345678h, 1A2B3C4Dh, 1E98DC76h
	l equ ($-s)/4
	d times l db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
	mov ecx,l
	mov esi,s
	mov edi,d
	xor ebx,ebx
	repeta:
		
		
		mov eax,dword[esi]
		add esi,4
		
		mov bl,ah
		xor edx,edx
		xor eax,eax
		
		
		mov ax,bx
		mov dl,10
		div dl
		cmp ah,0
		jz retine
		
		repeta2:
	loop repeta
	
	jmp done
	
	retine:
	mov [edi],bl
	inc edi
	jmp repeta2
	done:
	
	
	
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
