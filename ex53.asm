%include "io.inc"

section .data
        N DW 0xFFFF, 0x8, 0x0;
        x DW 3;

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    mov ecx, 0
    mov eax, 0
    mov cx, [x]
    
 
loop:
    dec cx
    mov ax, [N+ecx*2]
    ;cmp ax, 0   ; ça marche pas????
    test ax, 1   ;meme chose que cmp mais effectue un AND au lieu de SUB
    jpo impair
    cmp cx, 0
    jz pair
    jmp loop
    
impair:
    mov eax, 0
    jmp end
    
pair:
    mov eax, 1
    
            
end:
    ret