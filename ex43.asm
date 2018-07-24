%include "io.inc"

section .data
        N1 DQ 0xFFFFFFFF
	N2 DQ 1
	N3 DQ 000000

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
        
    ;add low
    mov eax, [N1]
    mov ebx, [N2]
    ADD eax, ebx
    mov [N3], eax
    PRINT_UDEC 4, eax
    
    ;add high
    mov eax, [N1+4]
    mov ebx, [N2+4]
    ADC eax, ebx
    mov [N3+4], eax
    PRINT_UDEC 4, eax
    
    ret