%include "io.inc"

section .text
global CMAIN
CMAIN:

val:
    push ebp					
    mov ebp, esp
    push ebx
    push ecx
    push edx
 
    mov ecx, [ebp+8]        ;1er parametre: V
    mov ebx, [ebp+12]       ;2eme parametre: N
    mov edx, [ebp+16]       ;3eme parametre: K
    cmp edx, ebx            ;comparaison k < n
    ja bcle                 ;if k < n, jump bcle
    mov eax, ecx
    jmp end

bcle:
    mov eax, edx
    mul 2                   ;low in eax, high in edx
    add eax, 1              ;pas inc car carry not affected
    adc edx, 0
    push ebx
    push ecx
    push edx
    call val
    pop edx
    pop ecx
    pop ebx

end:
    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret
