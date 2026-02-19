bits 32 ; assembling for the 32-bit architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    A db '1','2','3','4'
    B db '5','6','7','8'
    
    L_A equ $-A 
    L_B equ $-B 
    
    R times (L_A + L_B) db 0 

; our code starts here
segment code use32 class=code
    start:
        mov ecx, L_B        
        mov esi, R           
        mov ebx,L_B

    reverse_B:
        mov al,[B+ebx-1]         
        mov [R+esi],al
        inc esi              
        dec ebx  
    loop reverse_B       

    mov ecx, L_A         
    mov edi, A          

    process_A:
        mov al, [edi]        
        and al, 1           
        jz skip_odd          

            mov [esi], al
            inc esi 
            loop process_A

    skip_odd:
        inc edi              
        loop process_A       

    ; Exit the program
    push dword 0         
    call [exit]          
