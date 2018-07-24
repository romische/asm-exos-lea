%include "io.inc"

section .data
	T0 DW 0xfabf;
        T1 DW 0;
        T2 DW 0;

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    ; 5 bit de l'extremité dans T1
    
    ; 6 bits du milieu dans T2

    ret