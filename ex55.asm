%include "io.inc"

SECTION .data
        X DW 2
	A DW 1, 2, 3, 4

section .text
global CMAIN
CMAIN:
    mov ebp, esp         ; for correct debugging

    ;mul x*x
    mov eax, 0
    mov eax, [X]
    mul eax              ;low in eax, high in edx
    shl edx, 16
    mov edx, eax         ;res x*x in edx
    dec edx              ;(x*x)-1 in edx
    mov eax, 0
    
    ;calcule 2*(x+1) pour les adresses
    mov ebx, 2
    mov eax,[X]
    inc eax
    mul ebx             
    mov ebx, eax        ;res dans ebx car < 32bits
    
    ;place 1ere valeur dans un registre
    mov ecx, [A]    
                    
boucle:
    mov eax, [A+ebx]
    add ecx, eax        ;res add in ecx
    dec edx
    cmp edx, 0
    jz end
    jmp boucle
     
end:
    mov eax, ecx        ;place le res final dans eax
    ret
