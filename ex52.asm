%include "io.inc"

section .data
    A DW 5
    B DW 8
    C DW 4

section .text
global CMAIN
CMAIN:
    mov ax, [A]
    cmp ax, [B]
    jae asupb
    jmp ainfb

    
asupb:
    mov bx, [B]
    cmp bx, [C]
    jae asupbsupc
    jmp asupbinfc
    
ainfb:
    mov bx, [B]
    cmp bx, [C]
    jae ainfbsupc
    jmp ainfbinfc
    
asupbsupc:
    PRINT_UDEC 2, [A]
    NEWLINE
    PRINT_UDEC 2, [B]
    NEWLINE
    PRINT_UDEC 2, [C]
    jmp end
    
asupbinfc:
    PRINT_UDEC 2, [A]
    NEWLINE
    PRINT_UDEC 2, [C]
    NEWLINE
    PRINT_UDEC 2, [B]
    jmp end 
    
ainfbsupc:
    cmp ax, [C]
    jae bsupasupc
    jmp bsupainfc     
    
ainfbinfc:
    PRINT_UDEC 2, [C]
    NEWLINE
    PRINT_UDEC 2, [B]
    NEWLINE
    PRINT_UDEC 2, [A]
    jmp end
    
bsupasupc:
    PRINT_UDEC 2, [B]
    NEWLINE
    PRINT_UDEC 2, [A]
    NEWLINE
    PRINT_UDEC 2, [C]
    jmp end
    
bsupainfc:
    PRINT_UDEC 2, [B]
    NEWLINE
    PRINT_UDEC 2, [C]
    NEWLINE
    PRINT_UDEC 2, [A]
    jmp end    
    
end:    
    ret
