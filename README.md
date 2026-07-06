# Logical Instructions in NASM Assembly

## Objective

The objective of this assignment is to learn how to perform logical instructions in Assembly language using NASM on a Linux platform with Intel x86-64 architecture.

This repository demonstrates two required logical operations:

1. XORing an operand with itself to produce `0`.
2. Using the `TEST` instruction in a practical example.

## Operations Completed

| File | Logical Operation | Purpose | Expected `result` |
|---|---|---|---:|
| `logical_xor.asm` | `xor eax, eax` | Demonstrates that a value XOR itself becomes `0` | `0` |
| `logical_test.asm` | `test eax, 1` | Checks whether a number is even or odd without changing the number | `1` |

For the `TEST` example, I used `number = 14`.

```text
14 in binary ends with 0, so it is even.
14 & 1 = 0
The zero flag is set.
result = 1
```

In this program, `result = 1` means the number is even, and `result = 0` means the number is odd.

## Repository Contents

| File or Folder | Purpose |
|---|---|
| `logical_xor.asm` | Assembly code demonstrating XOR with itself |
| `logical_test.asm` | Assembly code demonstrating a practical TEST instruction |
| `flowchart.png` | Flowchart illustrating the thought process |
| `docs/flowchart.md` | Text version of the flowchart |
| `docs/challenges.md` | Written response describing challenges encountered |
| `debug/gdb_commands.md` | Recommended GDB commands for debugging each program |
| `expected_results.txt` | Expected result values for each program |
| `output.txt` | Notes about expected debugging output |
| `run.sh` | Script that assembles, links, and runs both programs |
| `Makefile` | Optional make commands for building, running, debugging, and cleaning |
| `.gitignore` | Keeps compiled files out of the repository |

## Flowchart

![Flowchart for the logical Assembly assignment](flowchart.png)

## How the Programs Work

Each Assembly file follows the same basic structure:

1. Define initialized values in the `.data` section.
2. Reserve the uninitialized `result` variable in the `.bss` section.
3. Load the initialized value into a register.
4. Perform the required logical instruction.
5. Store the final value in `result`.
6. Exit the program using the Linux `sys_exit` system call.

The programs do not print output directly. The assignment recommends using GDB to watch the value of `result`, so each file stores the final answer in memory for debugging.

## XOR Demonstration

The XOR program loads an initialized operand into `EAX` and then performs:

```asm
xor eax, eax
```

XOR compares matching bits. When a bit is XORed with itself, the result is always `0`. Because every bit in `EAX` is XORed with itself, the whole register becomes `0`. That cleared value is stored in `result`.

## TEST Practical Example

The TEST program checks whether `number = 14` is even.

```asm
test eax, 1
```

The `TEST` instruction performs a bitwise AND operation for flag-checking only. It does not save the AND result back into the register. Testing with `1` checks the least significant bit:

- If the least significant bit is `0`, the number is even.
- If the least significant bit is `1`, the number is odd.

Because `14 & 1 = 0`, the zero flag is set. The program jumps to the even-number section and stores `1` in `result`.

## How to Assemble, Link, and Run One File

Example using `logical_xor.asm`:

```bash
nasm -f elf64 -g -F dwarf logical_xor.asm -o logical_xor.o
ld logical_xor.o -o logical_xor
./logical_xor
```

Example using `logical_test.asm`:

```bash
nasm -f elf64 -g -F dwarf logical_test.asm -o logical_test.o
ld logical_test.o -o logical_test
./logical_test
```

Both programs exit silently after storing the answer in `result`.

## How to Build and Run Everything

Using the included script:

```bash
bash run.sh
```

Using the Makefile:

```bash
make run
```

Clean compiled files:

```bash
make clean
```

## Debugging with GDB

Example using `logical_xor`:

```gdb
gdb ./logical_xor
layout asm
layout regs
watch (int) result
break _start
run
stepi
```

Example using `logical_test`:

```gdb
gdb ./logical_test
layout asm
layout regs
watch (int) result
break _start
run
stepi
```

The `watch (int) result` command allows GDB to stop when the value stored in `result` changes.

## Expected Results

```text
logical_xor result = 0
logical_test result = 1
```

## Challenges Encountered

One challenge was understanding that logical instructions are often used to change or inspect bit patterns directly. XOR with itself clears a register because every bit cancels itself out.

Another challenge was understanding that `TEST` does not store a result like `AND` might be expected to. Instead, it updates the CPU flags. In this assignment, `TEST` is useful because it checks whether the least significant bit is set without modifying the original number.

## Submission

This repository includes the required flowchart, written challenge response, GDB debugging instructions, expected results, and working Assembly code. The GitHub repository link should be submitted in Canvas.
