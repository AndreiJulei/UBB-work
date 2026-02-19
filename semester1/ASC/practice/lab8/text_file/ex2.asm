bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

extern fopen, fprintf, fclose, fread,printf,scanf
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	;1. se citesc din fisire caractere pana la caracterul '+', sa se afiseze in console nr de litere mici 
	;urmat de nr de cifre citite
	;2. se citeste de la tastatura un nr de fisier input.txt si un caracter 'a' fisierul input.txt contine cuvinte separate prin #, sa se scrie in output.txt doar cuvintele in care apare caracterul 'a' doar pe pozitia a treia
	acces_read dd 'r',0
	buffer resb 100
	file_name dd "input.txt",0
	nr_litere_mici dd 0
	nr_cifre dd 0
	output_format dd '%d',0
	id dd 0
	space dd " ",0
	
	
	
; our code starts here
segment code use32 class=code
    start:
        ; ...
		push acces_read
		push file_name
		call [fopen]
		
		mov [id],eax
		cmp dword[id],0
		jz final
		
		mov esi,0
		
		
		push eax
		push 100
		push 1
		push buffer	
		call [fread]
			
			numara_caractere:
				mov al,[buffer+esi]
				cmp al,'a'
				jl next
				cmp al,'z'
				jg next
				inc dword [nr_litere_mici]
				
				next :
				cmp al,'0'
				jl increment
				cmp al,'9'
				jg increment
				inc dword [nr_cifre]
				
				increment:
				inc esi
				cmp al,0
			jnz numara_caractere
		
		push dword [id]
		call [fclose]
		add esp,4
		
		push dword [nr_litere_mici]
		push dword output_format
		call [printf]
		add esp,4*2
		
		push dword space
		call [printf]
		add esp,4
		
		push dword [nr_cifre]
		push dword output_format
		call [printf]
		add esp,4*2
		
	
		final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
