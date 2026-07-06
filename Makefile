ASM = nasm
LD = ld
ASMFLAGS = -f elf64 -g -F dwarf
PROGRAMS = logical_xor logical_test
OBJECTS = $(PROGRAMS:%=%.o)

.SECONDARY: $(OBJECTS)

all: $(PROGRAMS)

%: %.o
	$(LD) $< -o $@

%.o: %.asm
	$(ASM) $(ASMFLAGS) $< -o $@

run: all
	@for program in $(PROGRAMS); do \
		echo "Running ./$$program"; \
		./$$program; \
		echo "$$program completed. Use GDB to inspect result."; \
		echo; \
	done
	@echo "Expected results:"
	@cat expected_results.txt

debug-%: %
	gdb ./$*

clean:
	rm -f *.o $(PROGRAMS)

.PHONY: all run clean
