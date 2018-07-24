%include "io.inc"

section .data
        N1 DQ 0xFFFFFFFFFF
	N2 DQ 0x100000000
	N3 DQ 000000

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
        
    ;div 32
    mov eax, [N2+4]
    
    ;*237
    mov ebx, 237
    IMUL ebx        ; result is in edx:eax
    
    ;add low
    mov ecx, [N1]
    add eax, ecx
    mov [N3], eax
    
    ;adc high
    mov ecx, [N1+4]
    adc edx, ecx
    mov [N3+4], edx
    
    ret