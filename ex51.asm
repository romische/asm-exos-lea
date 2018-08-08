%include "io.inc"

section .data
    A DB 5
    B DB 8

section .text
global CMAIN
CMAIN:
    mov al, [A]
    cmp al, [B]
    jae above
    mov al, [B]
    PRINT_UDEC 1, al
    jmp end
    
above:
    PRINT_UDEC 1, al
    jmp end
    
end:    
    ret
