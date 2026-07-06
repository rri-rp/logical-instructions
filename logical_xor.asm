; Logical Instructions - XOR With Itself
; Objective: Demonstrate that XORing an operand with itself changes it to 0.
; Expected result: 0
;
; Assemble: nasm -f elf64 -g -F dwarf logical_xor.asm -o logical_xor.o
; Link:     ld logical_xor.o -o logical_xor
; Debug:    gdb ./logical_xor

section .data
    operand dd 37                 ; initialized operand before XOR

section .bss
    result resd 1                 ; uninitialized result for GDB watch

section .text
    global _start

_start:
    ; Load the initialized operand into EAX.
    mov eax, [operand]

    ; XOR the operand with itself.
    ; Any value XOR itself becomes 0.
    xor eax, eax

    ; Store the cleared value in result.
    mov [result], eax

    ; Exit program with status code 0.
    mov rax, 60
    xor rdi, rdi
    syscall
