CPU 386

section .text
global _val
_val:
    push ebp					
    mov ebp, esp
    push ebx
    push ecx
    push edx
 
    mov ecx, [ebp+8]        ;1er parametre: V
    mov ebx, [ebp+12]       ;2eme parametre: N
    mov edx, [ebp+16]       ;3eme parametre: K
    cmp ebx, edx            ;comparaison n > k
    ja bcle                 ;if k < n, jump bcle
    mov eax, 0
    jmp end

bcle:
    ; add v[k]
    mov eax, [ebp+8]        ;1er parametre: V
    mov eax, [ecx+edx*4]    ;ecx = v[k]
    push eax
    
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
    push eax  
    
    
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

    ;compute result
    pop ebx  ;pop val(v,n,2k+1)
    pop ecx  ;pop v[k]
    
    add ecx, ebx
    sub ecx, eax
            
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
