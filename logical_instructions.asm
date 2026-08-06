; Logical Instructions
; Demonstrates XOR and TEST using 32-bit Intel x86 Assembly.
;
; result changes during debugging:
;   45 = original XOR operand
;    0 = operand after XORing EAX with itself
;    1 = the TEST example determined that 14 is even
;
; tested_number remains 14, demonstrating that TEST does not
; change the operand that it checks.

section .text
    global _start

_start:
    ; Demonstrate XORing an operand with itself.
    mov eax, [operand]          ; EAX = 45
    mov [result], eax           ; Store the original value for comparison
    xor eax, eax                ; EAX XOR EAX = 0
    mov [result], eax           ; result = 0

    ; Use TEST to determine whether a number is even or odd.
    mov eax, [number]           ; EAX = 14
    test eax, 1                 ; Check the least significant bit
    mov [tested_number], eax    ; EAX is still 14 after TEST
    jz even_number              ; Zero Flag = 1 means the number is even

odd_number:
    mov dword [result], 0       ; 0 represents an odd number
    jmp exit_program

even_number:
    mov dword [result], 1       ; 1 represents an even number

exit_program:
    mov eax, 1                  ; Linux sys_exit
    mov ebx, 0                  ; Exit status 0
    int 0x80

section .data
    operand dd 45               ; Value used for the XOR demonstration
    number  dd 14               ; Value used for the TEST demonstration

section .bss
    result        resd 1        ; Stores the result being observed in GDB
    tested_number resd 1        ; Stores EAX after TEST
