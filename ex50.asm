%include "io.inc"

section .data
	T0 DW 0xFFFF ;16 bits
        T1 DW 0x0000
        T2 DW 0x0000

;1) mettre les 5 bits de poids fort et les 5 bits de poids faible de T0 dans T1, le reste étant rempli par des 0
;2) mettre les bits 5 à 10 de T0 dans T2, tassés à droite

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    ;1)
    mov ax, [T0]
    and ax, 0xF81F      ;masque 11111 000000 11111
    mov [T1], ax        ;place les 10 bits dans T1
    
    
    ;2)
    mov ax, [T0]
    and ax, 0x7E0       ;masque 00000 111111 00000
    shr ax, 5
    mov [T2], ax        ;place les 6 bits dans T2, à droite
    
    ret
