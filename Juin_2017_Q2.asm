%include "io.inc"
section .data
        M DD 1, 2, 3, 4, 5, 6, 7, 8, 9
        N DW 3
        
section .text
global CMAIN
CMAIN:
    mov ebp, esp                ;for correct debugging
    
    ;init
    mov eax, [M]
    mov ecx, 0
    mov edx, [N]
    mov ebx, [M+edx*4]
    
    ;swap ligne 1
    mov [M], ebx
    mov [M+edx*4], eax
    
bcle:    
    add ecx, 4
    mov eax, [M+ecx]
    dec edx
    add edx, ecx
    mov ebx, [M+edx*4]
    mov [M], ebx
    mov [M+edx*4], eax
    cmp edx, 0
    jz end
    jmp bcle


end:
    ret
