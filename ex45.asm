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
    mov [N1], eax
    PRINT_HEX 4, eax
    NEWLINE
    
    ;shl high
    mov eax, [N1+4]
    rcl eax, 1
    mov [N1+4], eax
    PRINT_HEX 4, eax
    
    ret