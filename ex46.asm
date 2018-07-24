%include "io.inc"

section .data
        N1 DQ 0xFFFFFFFFF

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
        
    ;shl low
    mov eax, [N1]
    sal eax, 1
    
    ;shl high
    mov ebx, [N1+4]
    rcl ebx, 1
    mov [N1+4], ebx
    PRINT_HEX 4, ebx
    
    ;adc low
    adc eax, 0
    mov [N1], eax
    PRINT_HEX 4, eax
    NEWLINE
    
    ret