bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
extern fprintf, fread, fopen, fclose, scanf, printf
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll		  
						  
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	;2. se citeste de la tastatura un nr de fisier input.txt si un caracter 'a' fisierul input.txt contine cuvinte separate prin #, sa se scrie in output.txt doar cuvintele in care apare caracterul 'a' doar pe pozitia a treia
	
	acces_read dd 'r',0
	acces_write dd 'w',0
	file_path_input db "ex3input.txt",0
	file_path_output db "ex3output.txt",0
	litera dd 0
	id dd 0
	format_litera dd "%s",0
	buffer resb 100
	sir_cuvinte_finale resb 100
	
	
	
	
; our code starts here
segment code use32 class=code
    start:
        ; ...
		push dword litera
		push dword format_litera
		call [scanf]
		add esp,4*2
		
		
		mov ebx,[litera]
		
		push acces_read
		push file_path_input
		call [fopen]
		add esp,4*2
		
		
		mov [id],eax
		mov edi,sir_cuvinte_finale
		
		
		citire_sir:
			
			push dword[id]
			push dword 100
			push dword 1
			push buffer 
			call [fread]
			add esp,4*4
			
			xor eax,eax
			mov esi,buffer
			
			cuvinte:
				
				mov al,byte[esi+2]
				cmp al,bl
				je stocare_cuvant
				
				next_word
					inc esi
					mov al,byte[esi]
					
					cmp al,0
					je done
					
					cmp al,'#'
					jne next_word
					
				jmp cuvinte
				
				stocare_cuvant:
					mov al,byte[esi]
					cmp al,0
					jz done
					
					cmp al,'#'
					jz next_unknown_word
					
					mov byte[edi],al
					inc edi
					inc esi
				jmp stocare_cuvant
					
				next_unknown_word:
					mov byte[edi],' '
					inc edi
					inc esi
					jmp cuvinte
				
		
		done:
		
		push dword [id]
		call [fclose]
		add esp,4
		
		push acces_write
		push file_path_output
		call [fopen]
		
		mov ebx,eax
		mov esi,sir_cuvinte_finale
		
		mov al,byte[esi]
		
		_end_:
		
		push ebx
		call [fclose]
		add esp,4
		
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
