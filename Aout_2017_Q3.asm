CPU 386
section .data

section .text
global _f
global CMAIN
CMAIN:
_f:
    push ebp
    mov ebp, esp
    mov eax, [ebp+8]            ;eax = n
    cmp eax, 0
    jz nul                      ;n est nul
    jpo odd                     ;n est impair
    jpe even                    ;n est pair

nul:
    mov eax, [ebp+12]           ;eax = x
    cmp eax, 0
    jz x_zero                   ;x est nul
    jmp end                     ;x non nul
    
x_zero:
    neg eax                     ;eax = -x
    jmp end
    
odd:
    push ebx
    mov ebx, [ebp+12]           ;ebx = x
    add ebx, [ebp+16]           ;ebx = x + y
    shr ebx, 1                  ;ebx = (x+y) >> 1
    push ebx                    ;2e parametre
    
    shr eax, 1                  ;eax = n >> 1
    push eax                    ;1e parametre
    call g
    pop ebx
    pop ebx
    jmp end
    
even:
    push ebx
    mov ebx, [ebp+12]           ;ebx = x
    sub ebx, [ebp+16]           ;ebx = x - y
    push ebx                    ;2e parametre
    push eax                    ;1e parametre
    call g
    pop ebx
    pop ebx
    jmp end   
      
end:
    mov esp, ebp
    pop ebp
    ret
