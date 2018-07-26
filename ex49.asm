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
    mul DWORD [N6]      ;low in eax, high in edx
    mov [N4], eax       ;low in N4
    mov ecx, edx        ;high in ecx
    mov edx, 0
    
    ;N6 low * N6 high
    mov eax, [N6+4]
    mul DWORD [N6]      ;low in eax, high in edx
    
    ;add --> ((N4)low)high
    add ecx, eax
    mov ebx, 0
    adc ebx, 0          ;carry premiere add    
    add ecx, eax        ;res add in ecx
    adc ebx, 0          ;carry 2nd add
    mov [N4+4], ecx
    mov ecx, edx        ;save high mul précédent 
    mov edx, 0
    
    ;N6 high * N6 high
    mov eax, [N6+4]
    mul DWORD [N6+4]    ;low in eax, high in edx
    
    ;add --> ((N4)high)low
    add eax, ebx        ; add the carry to eax
    mov ebx, 0
    adc ebx, 0          ;carry premiere add
    add eax, ecx
    adc ebx, 0
    add eax, ecx        ;res adc in eax
    adc ebx, 0
    mov [N4+8], eax
    
    ;add --> ((N4)h)h
    add edx, ebx        ; add the carry to edx
    mov [N4+12], edx  
     
    ret
