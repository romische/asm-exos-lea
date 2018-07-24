%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, 3
    and eax, 0x1
    
    CMP eax, 0
    JE pair
    
impair:
    mov eax, 0
    ret
    
pair:
    mov eax, 1
    ret
    