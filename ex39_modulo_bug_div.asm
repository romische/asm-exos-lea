CPU 386

SECTION .data

; variables
%include "io.inc"


section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
	
	mov eax, 0

        ;modulo	
	mov eax, 0xE2AABC
        mov edx, eax
        shr edx, 16

        PRINT_UDEC 2, ax
        mov cx, 32
        div cx      ; Exception : If the quotient is too large to fit into a word, it will throw an exception

	
	
        NEWLINE
	PRINT_UDEC 2, dx
	ret


