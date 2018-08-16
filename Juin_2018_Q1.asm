%include "io.inc"

section .data
	A DQ 0xABCDEFDDEFD

section .text
global CMAIN
CMAIN:
    mov ebp, esp            ;for correct debugging
    
    ;init
    mov eax, [A]
    mov edx, [A+4]
    
    ;get A[25:40]    
    shr eax, 25             ;get A[25:31]
    and edx, 0x1FF          ;masque 111111111, get A[32:40]
    shl edx, 7              ;decalage pour add avec A[25:31]
    add eax, edx            ;A[25:40] in eax
    
    ;get A[45:60]
    mov ebx, [A+4]          ;A high in ebx    
    shr ebx, 13
    and ebx, 0xFFFF         ;masque 1111111111111111, get A[45:60] in ebx
    
    ;comparaison A[25:40] et A[45:60]
    cmp eax, ebx            ;fait eax - ebx
    ja plus_grand
    jmp plus_petit
    
    
    
;traitement si plus grand    
plus_grand:
    mov eax, [A]
    mov edx, 0
    mov ebx, 0xFFFF
    and ebx, eax            ;masque 1111111111111111, resultat in ebx
    and eax, 0xFFFF0000     ;prepare eax pour remettre le resultat du swap
    jmp swap_plus_grand    
    
    
swap_plus_grand:
    mov ecx, 0xAAAA         ;masque 1010101010101010
    and ecx, ebx            ;get odd in ecx
    and ebx, 0x5555         ;masque 0101010101010101, get even in ebx
    shr ecx, 1
    shl ebx, 1
    add ebx, ecx            ;resultat swap even-odd in ebx
    cmp edx, 0
    jz plus_grand_mid
    jmp plus_grand_fin
    
plus_grand_mid:
    add eax, ebx            ;complete eax avec resultat swap
    mov edx, [A+4]
    mov ebx, 0xFFFF0000     ;masque 11111111111111110000000000000000
    and ebx, edx            ;resultat masque in ebx
    mov edx, 1
    jmp swap_plus_grand
    

plus_grand_fin:
    mov edx, [A+4]
    and edx, 0xFFFF         ;prepare edx pour remettre le resultat du swap
    add edx, ebx            ;complete edx avec resultat swap
    jmp end



;traitement si plus petit   
plus_petit:
    mov edx, [A+4]
    mov ebx, 0xFFFF         ;masque 1111111111111111  
    and ebx, edx            ;resultat masque in ebx
    mov eax, 0
    jmp swap_plus_petit
    
swap_plus_petit:
    mov ecx, 0xAAAA         ;masque 1010101010101010
    and ecx, ebx            ;get odd in ecx
    and ebx, 0x5555         ;masque 0101010101010101, get even in ebx
    shr ecx, 1
    shl ebx, 1
    add ebx, ecx            ;resultat swap even-odd in ebx
    cmp eax, 0
    jz plus_petit_mid
    jmp plus_petit_fin    

plus_petit_mid:
    add edx, ebx            ;complete edx avec resultat swap
    mov eax, [A]
    mov ebx, 0xFFFF0000     ;masque 11111111111111110000000000000000
    and ebx, edx            ;resultat masque in ebx
    mov eax, 1
    jmp swap_plus_petit

plus_petit_fin:
    mov eax, [A]
    and eax, 0xFFFF         ;prepare eax pour remettre le resultat du swap
    add eax, ebx            ;complete eax avec resultat swap
    jmp end

end:
    ret
