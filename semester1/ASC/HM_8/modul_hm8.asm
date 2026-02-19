%ifndef _MODUL_HM8_ASM_
%define _MODUL_HM8_ASM_

global convert

convert:
	
	xor ecx,ecx
		
		convert_bits:
	
			mov al, byte[esi]           ;move the current byte
			cmp al, "0"                 
			jz convert_zero                
			cmp al, "1"                 
			jz convert_one              ;check if the character is "0" or "1"
			
			jmp return
			
		convert_one:
			
			shl ecx,1					
			or ecx,1
			inc esi
		jmp convert_bits
				
		convert_zero:
		
			shl ecx,1
			or ecx,0
			inc esi
		jmp convert_bits
		
return:
	ret 
	
%endif