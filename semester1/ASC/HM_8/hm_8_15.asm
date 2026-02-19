bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

extern exit, printf, scanf ; adaugam printf si scanf ca functii externe           
import exit msvcrt.dll     
import printf msvcrt.dll     ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll 

%include "modul_hm8.asm"			  
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	
	;Problem 15:
	;A string containing n binary representations on 8 bits is given as a character string.
	;Obtain the string containing the numbers corresponding to the given binary representations.
	;Example:
	;Given: '10100111b', '01100011b', '110b', '101011b'
	;Store: 10100111b, 01100011b, 110b, 101011b
	

	binary_string resw 9
	result_array resb 256

	
	format db "%s", 0          
    format_output db "%d",0
	input db "Enter the binary string (space separated): ", 0
	final_message db "The array has been stored in binary succesfully!",0

	
; our code starts here
segment code use32 class=code
    start:
        ; ...
	
	push dword input
    call [printf]
    add esp, 4
	
	mov edi,result_array

read_numbers:
    
    push dword binary_string             
    push dword format    
    call [scanf]
    add esp,4*2               

    mov esi,binary_string
	
	convert_string:
		
		mov al,byte[esi]              ;mov the first byte into al
		
		cmp al, 0                 
		jz read_numbers                     ;check for the end of the string
		
		cmp al,'2'
		jz done
		
		cmp al,' '					;check if its space
		jz skip_space
		cmp al,'b'
		jz skip_space
		
		jmp process_bit
		
		skip_space:
			inc esi
			jmp convert_string        
		
		process_bit:
			push esi
			call convert			;convert string to binary and store the result in edi
			
			mov [edi],cl
			add edi,4					
			jmp read_numbers
	
	
	done:
		push dword final_message
		call [printf]
		add esp, 4

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
