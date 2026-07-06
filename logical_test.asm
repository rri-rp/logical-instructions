; Logical Instructions - Practical TEST Example
; Objective: Use TEST to check whether a number is even.
; Expected result: 1 because number = 14 is even.
;
; Assemble: nasm -f elf64 -g -F dwarf logical_test.asm -o logical_test.o
; Link:     ld logical_test.o -o logical_test
; Debug:    gdb ./logical_test

section .data
    number dd 14                  ; practical value to test

section .bss
    result resd 1                 ; 1 = even, 0 = odd

section .text
    global _start

_start:
    ; Load the number into EAX.
    mov eax, [number]

    ; TEST performs a bitwise AND but does not store the AND result.
    ; Testing bit 0 determines whether the number is even or odd.
    ; If number & 1 == 0, the zero flag is set and the number is even.
    test eax, 1

    ; Jump if the zero flag is set.
    jz even_number

odd_number:
    ; Store 0 when the number is odd.
    mov dword [result], 0
    jmp done

even_number:
    ; Store 1 when the number is even.
    mov dword [result], 1

done:
    ; Exit program with status code 0.
    mov rax, 60
    xor rdi, rdi
    syscall
