%include "io.inc"

section .data
        N DD 5
        V DD 1, 5, 2, 0, 4


section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, [N]

loop1:
    dec eax
    cmp eax, 0
    jz end
    mov ebx, [V+eax*4]  ; ebx = V[i] 
    ;init loop2
    mov ecx, eax        ; j=i
    
loop2:
    dec ecx
    mov edx, [V+ecx*4]  ; edx = V[j]
    cmp edx, ebx        ; compare V[j] and V[i]
    ja swap

end_loop2:    
    cmp ecx, 0
    jz loop1
    jmp loop2
    
swap:
    mov [V+eax*4], edx
    mov [V+ecx*4], ebx
    mov ebx, edx
    jmp end_loop2
        
end:
    mov ecx, [N]
    
printloop:
    dec ecx
    mov eax, [V+ecx*4]
    PRINT_UDEC 4, ecx
    PRINT_UDEC 4, eax    
    NEWLINE
    cmp ecx, 0
    jnz printloop
    
    ret
