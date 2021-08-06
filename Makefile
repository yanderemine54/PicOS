# $@ = target file
# $< = first dependency
# $^ = all dependencies

# First rule is the one executed when no parameters are fed to the Makefile
all: run

# Notice how dependencies are built as needed
kernel.bin: load_kernel.o kernel.o
	i686-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

load_kernel.o: load_kernel.asm
	nasm $< -f elf -o $@

kernel.o: kernel.c
	i686-elf-gcc -ffreestanding -c $< -o $@

# Rule to disassemble the kernel - may be useful to debug
kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@

boot.bin: boot.asm
	nasm $< -f bin -o $@

picos.bin: boot.bin kernel.bin
	cat $^ > $@

run: picos.bin
	qemu-system-i386 -fda $<

clean:
	rm *.bin *.o *.dis
