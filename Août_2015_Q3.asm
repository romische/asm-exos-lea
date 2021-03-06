CPU 386
;%include "io.inc"


section .data
        V DD 1,5,2,4
        N DD 4
        K DD 0

section .text
global _val
global CMAIN
CMAIN:
_val:
    push ebp					
    mov ebp, esp
    push ebx
    push ecx
    push edx
 
    ;mov ecx, [ebp+8]        ;1er parametre: V
    mov ebx, [ebp+12]       ;2eme parametre: N
    mov edx, [ebp+16]       ;3eme parametre: K
    cmp ebx, edx            ;comparaison n > k
    ja bcle                 ;if k < n, jump bcle
    mov eax, 0
    jmp end

bcle:
    ; add v[k]
    mov ecx, [ebp+8]        ;1er parametre: V
    mov ecx, [ecx+edx*4]    ;ecx = v[k]
    
    ; call val(v,n,2k+1)
    shl edx, 1
    inc edx 
    push edx    ;2k+1
    push ebx    ;n
    mov ebx, [ebp+8]    ; ! ecx is reserved 
    push ebx    ;v
    call _val
    pop ebx
    pop ebx
    pop edx
    add ecx, eax   ; result += val(v,n,2k+1)
    
    
    ; call val(v,n,2k+2)
    inc edx 
    push edx    ;2k+2
    push ebx    ;n
    mov ebx, [ebp+8]    ; ! ecx is reserved 
    push ebx    ;v
    call _val
    pop ebx
    pop ebx
    pop edx
    sub ecx, eax    ; result -= val(v,n,2k+2)
    
    ; store final result in eax
    mov eax, ecx

end:
    ;PRINT_UDEC 4, eax
    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret
