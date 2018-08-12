%include "io.inc"

section .data
        N DD 5
        V DD 1, 5, 2, 0, 4


section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
bcl:    
    mov eax, [N]
    mov ebx, [V]
    mov ecx, [V+4]
    dec eax
    cmp ebx, ecx
    ja i_sup_j
    jmp bcl
    
i_sup_j:
    mov [V], ecx
    mov [V+4], ebx
    
    
end:    
    ret
