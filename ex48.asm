%include "io.inc"

section .data
	N4 DQ 0x0, 0x0 ; 2*DQ -> 2*Quad-word = 128 bit
	N5 DD 0xCAFEBABE ; DD -> Double-word = 32 bit
	N6 DQ 0x0BADCAFE ; DQ -> Quad-word = 64 bit

; N4 = N5*N6

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    mov eax, [N4]
    mov eax, [N4+4]
    mov eax, [N4+8]
    mov eax, [N4+12]

    ; ...
    
    ret