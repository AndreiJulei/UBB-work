bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

						  
extern fopen, fprintf, fclose, fscanf
import fopen msvcrt.dll
import fscanf msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	; PROBLEM 15:
	;A file name and a text (defined in the data segment) are given.
	;The text contains lowercase letters, uppercase letters, digits and special characters. 
	;Replace all the special characters from the given text with the character 'X'. 
	;Create a file with the given name and write the generated text to file.
	
	file_name db "pb15_file.txt",0			;name of the file
	mod_acces db "w",0					;way of accessing(reading and writing)
	
	descriptor dd -1					;innitial descriptor 
	
	text db "Text for, file;",0			
	
; our code starts here
segment code use32 class=code
    start:
        ; ...
		;eax will have the descriptor's value if the file is created or 0  
		push dword mod_acces			;push acces mode
		push dword file_name			;push file name
		call [fopen]					;open the file for writing
		add esp,4*2						;free up the stack
		
		mov ebx,eax			;save the value from fopen to the descriptor(the descriptor from the file)		
			
		cmp eax, 0						;see if the file is created (if eax!=0)
        je final
		
		mov esi, text					;pointer to text address
		
		replace_in_text:
			mov al,[esi]			;mov the bytes in all to verify them
			
			cmp al,0					;check if we got to the end of the string
			je write_text
	
		cmp_lowercase:					;check if it is a lowercase character
			cmp al,'a'
			jl cmp_uppercase
			cmp al,'z'
			jg cmp_uppercase
			
			jmp next_char
		
		cmp_uppercase:					;check if is a uppercase character
			cmp al,'A'
			jl cmp_number
			cmp al,'Z'
			jg cmp_number
			
			jmp next_char
		
		cmp_number:						; chech if it is a number
			cmp al,'0'
			jl cmp_space
			cmp al, '9'
			jg cmp_space
			
			jmp next_char
		
		cmp_space:
			cmp al," "
			jz next_char 
			
		special_character:
			mov byte[esi],'X'			;replace in text if needed
			
		next_char:
			inc esi						;go to the next byte
			jmp replace_in_text			
		
		
		
		write_text:
			push dword text
			push dword ebx
			call [fprintf]					;we write the text in the file	
			add esp,4*2
		
		
		push dword ebx
		call [fclose]				;close the file
		add esp,4
		
	final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
