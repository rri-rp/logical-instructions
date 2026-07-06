#!/bin/bash
set -e

programs=(logical_xor logical_test)

for program in "${programs[@]}"; do
    echo "Assembling $program.asm"
    nasm -f elf64 -g -F dwarf "$program.asm" -o "$program.o"

    echo "Linking $program.o"
    ld "$program.o" -o "$program"

    echo "Running ./$program"
    ./$program
    echo "$program completed. Use GDB to inspect result."
    echo
 done

echo "Expected results:"
cat expected_results.txt
