%include "io.inc"

section .data
	N1 DQ 23
        N2 DQ 6
        N3 DD 2
        N4 DQ 0, 0


section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    ;div 2**32 = shr N2, 32 --> N2 high
    mov eax, [N2+4]
    
    ;add N2 + N1
    mov ebx, [N1]
    add eax, ebx        ;add N2+4 avec N1 low, res low dans eax
    mov ebx, [N1+4]
    adc ebx, 0          ;adc N1 high avec carry, res high dans ebx
    
    ;mul N3
    mov ecx, [N3]
    imul ecx            ;mul N3 avec res low, low in eax, high in edx
    mov [N4], eax
    mov eax, ebx        ;mov res high in eax pour imul
    mov ebx, edx        ;mov imul high in ebx
    imul ecx            ;mul N3 avec res high, low in eax, high in edx
    
    ;add des differentes parties avec carry
    add eax, ebx
    mov [N4+4], eax
    adc edx, 0
    mov [N4+8], edx
    mov edx, 0
    adc edx, 0
    mov [N4+12], edx
    
    ;rol 1
    mov eax, [N4]
    shl eax, 1
    mov [N4], eax
    mov ebx, 0
    adc ebx, 0          ;carry shl dans ebx
    mov eax, [N4+4]
    shl eax, 1
    add eax, ebx        ;mets le carry dans le bit de poids faible de N4+4
    mov [N4+4], eax
    mov ebx, 0
    adc ebx, 0          ; carry shl dans ebx
    mov eax, [N4+8]
    shl eax, 1
    add eax, ebx        ;mets le carry dans le bit de poids faible de N4+8
    mov [N4+8], eax
    mov ebx, 0
    adc ebx, 0          ; carry shl dans ebx
    mov eax, [N4+12]
    shl eax, 1
    add eax, ebx        ;mets le carry dans le bit de poids faible de N4+4
    mov [N4+12], eax
    mov eax, [N4]
    adc eax, 0          ;mets le carry final dans le bit de poids de N4
    mov [N4], eax
          
    ret
