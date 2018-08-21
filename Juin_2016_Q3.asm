CPU 386
section .data

section .text
global _parcours
global CMAIN
CMAIN:
_parcours:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    mov ebx, [ebp+12]           ;ebx = n
    mov ecx, [ebp+16]           ;ecx = k
    cmp ebx, ecx                ;n-k
    jbe end
    
    ;k<n
    push edx
    mov edx, [ebp+8]            ;edx = v
    call output
    pop edx
    pop ecx
    pop ebx
    shl ecx, 2                  ;2*k
    inc ecx                     ;2*k + 1
    push ecx                    ;3e parametre
    push ebx                    ;2e parametre
    push edx                    ;1e parametre
    call _parcours
    inc ecx                     ;2*k+2    
    pop edx
    pop ebx
    pop ecx
    inc ecx
  
end:
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret
