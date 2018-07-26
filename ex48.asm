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
    
    ;N6 low * N5
    mov eax, [N6]
    mov ebx, [N5]
    mul ebx
    mov [N4], eax       ;low in N4
    mov ecx, edx        ;high in ecx
    mov edx, 0
    
    
    ;N6 high * N5
    mov eax, [N6+4]
    mul ebx             ;low in eax, high in edx
    
    ;add
    add eax, ecx
    mov [N4+4], eax
    mov eax, 0
    adc edx, eax        ;edx + 0 + carry
    mov [N4+8], edx
    adc eax, eax        ;si carry après adc edx, eax
    mov [N4+12], eax
    
    ret
