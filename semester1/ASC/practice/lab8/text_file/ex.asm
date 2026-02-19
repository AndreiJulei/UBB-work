bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit         ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

extern fopen, fprintf, fclose, fread,printf,scanf
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    ; ...
	
	acces_mode_read db "r",0
	file_path db "text.txt",0
	output db "output.txt",0
	buffer resb 100
	id resd 1
	acces_mode_write dd "w",0
	format_number dd '%d',0
	format_nume dd '%s',0
	newline dd 10,0
	len dd 0
	new_name dd 0
	number dd 0

	
; our code starts here
segment code use32 class=code
    start:
        ; ...
		xor ebx,ebx
		
		push acces_mode_read
		push file_path
		call [fopen]
		add esp,4*2
		
		mov [id],eax
		
		cmp eax,0
		je _end_
		
		read_while_there_are_characters:
			
			push eax
			push dword 100
			push dword 1
			push buffer
			call [fread]
			add esp,4*4
			
			mov esi,0
			mov [len],eax
			
			mov edi,new_name
			
			get_name:
			mov al,[buffer+esi]		; AL = buffer[0]
			inc esi
			cmp al,' '
			je name_is_saved
			mov byte[edi],al
			inc edi
			jmp get_name
			
		name_is_saved:
			
			mov esi,0
			
			find_number:
			mov al,[buffer+esi]
			cmp al,0
			je done
			
			cmp al,'0'
			jl next_char
			
			cmp al,'9'
			jg next_char
			
			mov bh,al
			jmp done
			
			next_char:
			inc esi
			jmp find_number
			
			done:
			
			mov bl,'1'
			mov [number],bx
		
		
		cmp byte[len],100
		jae read_while_there_are_characters
		
		push dword [id]
		call [fclose]
		add esp,4
		
		push acces_mode_write
		push output
		call [fopen]
		add esp,4*2
		
		
		mov [id],eax
		
		push dword [len]
		push dword format_number
		push dword [id]
		call [fprintf]
		add esp,4*3
		
		push dword newline
		push dword [id]
		call [fprintf]
		add esp,4
		
		push dword new_name
		push dword format_nume
		push dword [id]
		call [fprintf]
		add esp,4*3
		
		push dword newline
		push dword [id]
		call [fprintf]
		add esp,4
		
		push dword number
		push dword format_nume
		push dword [id]
		call [fprintf]
		add esp,4*3
		
		
		push dword[id]
		call [fclose]
				
		_end_:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
