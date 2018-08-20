CPU 386
section .data

section .text
global _fctSudan
global CMAIN
CMAIN:
_fctSudan:
    push ebp
    mov ebp, esp
    push ebx
    mov ebx, [ebp+8]        ;ebx = n
    push ecx
    mov ecx, [ebp+16]       ;ecx = y
    cmp ebx, 0
    jz n_zero
    cmp ecx, 0
    jz y_zero

    ;calcul 3e parametre pour tmp
    dec ecx                 ;ebx = y-1
    push ecx                ;3e parametre = y-1
    call _fctSudan          ;res in eax, eax = tmp
    pop ecx
    
    ;fctSudan(n-1, tmp, y + tmp)
    inc ecx                 ;ecx = y-1 --> ecx = y
    add ecx, eax            ;y + tmp in ecx --> 3e parametre
    push ecx
    push eax                ;eax = tmp --> 2e parametre
    dec ebx                 ;ebx = n --> ebx = n-1
    push ebx                ;1e parametre
    call _fctSudan          ;res in eax
    jmp end
       
n_zero:
    add ecx, [ebp+12]
    mov eax, ecx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret        

y_zero:
    mov eax, [ebp+12]
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret
                        
end:
    pop ebx
    pop ecx
    mov esp, ebp
    pop ebp
    ret
