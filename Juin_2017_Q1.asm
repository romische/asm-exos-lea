%include "io.inc"
section .data
        A DD 0
        B DD 0
        T DQ 1234567895898
        X DD 0
        Y DD 0
        
section .text
global CMAIN
CMAIN:
    mov ebp, esp                ;for correct debugging
    mov eax, [T]                ;low bits in eax
    mov edx, 16                 ;init compteur
    
    
desentrelacement_bas:
    shl eax, 1                  ;elem B15 in carry flag
    adc ebx, 0                  ;elem B15 in ebx
    shl ebx, 1                  ;decalage de 1 rang pour le bit suivant a mettre dans B
    shl eax, 1                  ;elem A51 in carry flag
    adc ecx, 0                  ;elem A15 in ecx
    shl ecx, 1                  ;decalage de 1 rang pour le bit suivant a mettre dans A
    inc edx                     ;inc compteur, doit aller jusque 16
    cmp edx, 0
    jz mid_desentre
    jmp desentrelacement_bas
    
    
mid_desentre:
    ;eax et edx vides, ebx = B low, ecx = A low
    mov [B], ebx
    mov ebx, 0
    mov [A], ecx
    mov ecx, 0
    mov edx, [T+4]
    mov eax, 16
    
desentrelacement_haut:
    shl eax, 1                  ;elem B31 in carry flag
    adc ebx, 0                  ;elem B31 in ebx
    shl ebx, 1                  ;decalage de 1 rang pour le bit suivant a mettre dans B
    shl eax, 1                  ;elem A31 in carry flag
    adc ecx, 0                  ;elem A31 in ecx
    shl ecx, 1                  ;decalage de 1 rang pour le bit suivant a mettre dans A
    inc eax                     ;inc compteur, doit aller jusque 16
    cmp eax, 0
    jz suite
    jmp desentrelacement_haut
    
suite:
    ;edx et eax vides, ebx = B high, ecx = A high
    mov [B+2], ebx
    mov ebx, 0
    mov [A+2], ecx
    mov ecx, 0
    
traitement_A:
    ;A mod 2**10 = reste A/ 2**10 --> res = 10bits low
    mov eax, [A]
    shl eax, 22                 ;32-10=22
    shr eax, 22                 ;res = 0000000000000000000000 1111111111
    
    ;(A mod 2**10) * 8 --> 8 = 2**3
    shl eax, 3
    
    ;(A mod 2**10) * 8 + 1
    inc eax
    
    mov [X], eax                ;mets le res dans X
    
traitement_B:
    mov ebx, [B]
    mov ecx, ebx
    
    ;B mod 2**24 = reste B/ 2**24 --> res = 24bits low
    shl ecx, 8                  ;32-24=8
    shr ecx, 8                  ;res = 00000000 111111111111111111111111
    
    ;B - (B mod 2**24)
    sub ebx, ecx
    
    ;(B - (B mod 2**24)) / 4 --> 4 = 2**2
    shr ebx, 2                  ;decalage de 2 rangs pour div par 4
    
    ;(((B - (B mod 2**24)) / 4) + 2**31) + 3
    add ebx, 2147483648         ;2**31 = 2147483648
    add ebx, 3
    
    mov [Y], ebx
    mov ecx, 16                 ;init compteur pour entrelacement_haut_X
    mov ebx, eax
    
entrelacement_haut_X:
    ;ebx = X
    shl ebx, 1                  ;elem X31 in carry flag
    adc edx, 0                  ;elem X31 in edx
    shl edx, 2                  ;decalage de 2 rangs pour le bit suivant a mettre dans edx
    loop entrelacement_haut     ;fin quand ecx = 0
                                ;edx = 1010101010101010
    mov ecx, 16                 ;init compteur pour entrelacement_bas_X
                                
entrelacement_bas_X:
    ;ebx = X
    mov eax, 0
    shl ebx, 1                  ;elem X15 in carry flag
    adc eax, 0                  ;elem X15 in edx
    shl eax, 2                  ;decalage de 2 rangs pour le bit suivant a mettre dans eax
    loop entrelacement_haut     ;fin quand ecx = 0
                                ;eax = 1010101010101010, ebx vide
    mov ebx, [Y+2]              ;ebx = 16 derniers bits de Y                                

entrelacement_haut_Y:
    ;eax = bits low, ebx = [Y+2], ecx = compteur, edx = bits high
    
    
       

end:
    ret
