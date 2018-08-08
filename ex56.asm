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
    mov eax, 0      ; init à 0 pour éviter segmentation fault
    mov ebx, 0
    mov ecx, 0
    mov cx, [N]
    mov edx, 0      ; indice de la position
    jmp position

                
position:
    mov ax, [V+edx]
    mov [W+(eax-1)*4], ax    ;place position dans le nouveau vecteur
    jmp value

        
value:
    add edx, 2              ; indice de la valeur
    dec ecx
    mov bx, [V+edx]    
    mov [W+((eax-1)*4)+2], bx   ;place value dans le nouveau vecteur
    add edx, 2              ; indice de la position suivante
    dec ecx
    ; continue if ecx!=0
    cmp ecx, 0
    jz printvect
    jmp position
    
     
printvect:
     mov edx, 0
     mov cx, [N]
     
print_loop:
     mov ax, [W+edx*2]
     PRINT_UDEC 2, ax
     NEWLINE
     inc edx
     cmp ecx, edx
     je end
     jmp print_loop

end:
    ret
