CPU 386
section .data

section .text
global _fctTao
global CMAIN
CMAIN:
_fctTao:
    push ebp
    mov ebp, esp
    mov eax, [ebp+12]       ;eax = y
    cmp eax, [ebp+8]        ;cmp y-x
    jge end                 ;jmp if y >= x
    
    ;1) fctTao(z-1, x, y)        
    push eax                ;y -> 3e parametre
    push ebx
    mov ebx, [ebp+8]        ;ebx = x
    push ebx                ;x -> 2e parametre
    mov eax, [ebp+16]       ;eax = z
    dec eax                 ;eax = z-1
    push eax                ;z-1 -> 1er parametre
    call _fctTao            ;fctTao(z-1, x, y)
    pop eax
    pop eax
    
    ;2) fctTao(y-1, z, x)        
    push eax                ;res de 1) in eax = 3e parametre pour l'appel global
    push ebx                ;ebx = x, x -> 3e parametre
    mov ebx, [ebp+16]       ;ebx = z
    push ebx                ;z -> 2e parametre
    mov eax, [ebp+12]       ;eax = y
    dec eax                 ;eax = y-1
    push eax                ;y-1 -> 1er parametre
    call _fctTao            ;fctTao(y-1, z, x)
    pop eax
    pop ebx
    pop ebx
    
    ;3) factTao(x-1, y, z)        
    push eax                ;res de 2) in eax = 2e parametre pour l'appel global
    mov ebx, [ebp+16]       ;ebx = z
    push ebx                ;z -> 3e parametre
    mov ebx, [ebp+12]       ;ebx = y
    push ebx                ;y -> 2e parametre     
    mov eax, [ebp+8]        ;eax = x
    dec eax                 ;eax = x-1
    push eax                ;x-1 devient 1er parametre
    call _fctTao            ;fctTao(x-1, y, z)
    pop eax
    pop ebx
    pop ebx
    
    ;4) fctTao( 1), 2), 3) )
    push eax                ;res de 3) in eax = 1e parametre pour l'appel global
    call _fctTao            ;appel global, res final in eax
        
end:
    pop ebx
    mov esp, ebp
    pop ebp
    ret
