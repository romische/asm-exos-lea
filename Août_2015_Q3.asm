%include "io.inc"

section .data
        N DD 5
        V DD 1, 5, 2, 0, 4
        K DD 0


section .text
global CMAIN
CMAIN:

val:
    push ebp
    mov ebp, esp
    push eax
    push ebx
    push ecx
    mov eax, [V]
    mov ebx, [N]
    mov ecx, [K]
    
    
    
    call val
    
    
    
    
    pop ecx
    pop ebx
    pop eax
    
    ret
