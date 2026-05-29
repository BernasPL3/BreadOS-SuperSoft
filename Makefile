all:
	nasm -f bin boot/boot.asm -o build/boot.bin
	nasm -f bin kernel/kernel.asm -o kernel/kernel.bin

	cat build/boot.bin kernel/kernel.bin > build/BreadOS.img

run:
	qemu-system-i386 build/BreadOS.img
