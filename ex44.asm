%include "io.inc"

section .data
        N1 DQ 0xFFFFFFFFFF
	N2 DQ 0x100000000
	N3 DQ 000000

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
        
    ;sub low
    mov eax, [N1]
    mov ebx, [N2]
    sub eax, ebx
    mov [N3], eax
    PRINT_HEX 4, eax
    
    ;sub high
    mov eax, [N1+4]
    mov ebx, [N2+4]
    sbb eax, ebx
    mov [N3+4], eax
    PRINT_HEX 4, eax
    
    ret