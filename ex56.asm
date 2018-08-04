%include "io.inc"

SECTION .data
        N DW 10
	      V DW 3, 10, 5, 15, 4, 17, 1, 9, 2, 19
        W DW 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp         ; for correct debugging
    
    ;initialisation registres
    mov ecx, [N]
    mov edx, 0
    mov eax, [V]
    jmp position

                
position:
    ;
    ;
    ;
    ;
    ;
    jmp value

        
value:
    add edx, 2
    dec ecx
    mov eax, [V+edx]
    mov [W+edx], [V+edx]    ;place value dans le nouveau vecteur
    add edx, 2
    dec ecx
    cmp ecx, 0
    jz end
    jmp position
     

end:
    ret
