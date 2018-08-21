%include "io.inc"
section .data
        M DD 1, 2, 3, 4, 5, 6, 7, 8, 9
        ;M DD 1, 0, 0, 1, 3, 1, 2, 2, 5     ;matrice à diago dominante
        N DW 3
        A DD "OK"
        B DD "PAS OK"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov eax, [M]        ;eax = M[1]
    mov ebx, [N]        ;ebx = nbr lignes
    inc ebx             ;ebx+1 pour avancer dans les composantes diagonales de M
    mov ecx, 0          ;init registre qui contiendra la somme des elems


add_ligne:
    mov ecx, [eax+4]    ;elem apres l'elem de la diago
    mov edx, 2          ;compteur bcle add
    cmp ebx, edx        ;ebx-edx
    jz bcle
    inc edx
    jmp add_ligne
       
bcle:
    cmp eax, ecx
    jb not_diago        ;jmp diago si une ligne ne respecte pas les conditions
    mov eax, [M+ebx*4]   
    
diago:
    PRINT_STRING [A]
    jmp end
    
not_diago:
    PRINT_STRING [B]
    jmp end
    
end:
    ret
