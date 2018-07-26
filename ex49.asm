%include "io.inc"

section .data
	N4 DQ 0x0, 0x0 ; 2*DQ -> 2*Quad-word = 128 bit
	N6 DQ 0x0BADCAFE ; DQ -> Quad-word = 64 bit

; N4 = N6*N6

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    ;N6 low * N6 low
    mov eax, [N6]
    mov ebx, [N6]
    mul ebx             ;low in eax, high in edx
    mov [N4], eax       ;low in N4
    mov ecx, edx        ;high in ecx
    mov edx, 0
    
    ;N6 low * N6 high
    mov eax, [N6+4]
    mul ebx             ;low in eax, high in edx
    
    ;add --> ((N4)low)high
    add eax, eax
    add ecx, eax        ;res add in ecx
    mov [N4+4], ecx
    mov ecx, edx        ;save high mul précédent 
       
    ;N6 high * N6 high
    mov eax, [N6+4]
    mov ebx, [N6+4]
    mul ebx             ;low in eax, high in edx
    
    ;add --> ((N4)high)low
    adc eax, ecx
    adc eax, ecx        ;res adc in eax
    mov [N4+8], eax
    
    ;add --> ((N4)h)h
    mov eax, 0
    adc edx, eax
    mov [N4+12], edx  
     
    ret
