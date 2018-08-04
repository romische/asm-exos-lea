%include "io.inc"

SECTION .data
        N DW 0x2
        M DW 0x2
	A DW 1, 2, 3, 4
	B DW 5, 6, 7, 8
	C DW 0, 0, 0, 0, 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp         ; for correct debugging

    ;mul x et y
    mov eax, 0
    mov eax, [N]
    mov ebx, 0
    mov ebx, [M]
    mul ebx              ;low in eax, high in edx
    shl edx, 16
    mov edx, eax         ;res x*y in edx
    dec edx              ; (x*y)-1
    mov eax, 0
    mov ebx, 0
    
    
boucle:
    mov ecx, 0
    mov eax, [A+ecx]
    mov ebx, [B+ecx]
    add eax, ebx        ;res add elem in eax
    mov eax, [C+ecx]
    add ecx, 2
    dec edx             ;(x*y)-1
    cmp edx, 0
    jz end
    jmp boucle
    
end:
    ret
