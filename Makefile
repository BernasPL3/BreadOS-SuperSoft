ASM=nasm
BUILD=build
ISO=iso

all:
	mkdir -p $(BUILD)
	mkdir -p $(ISO)/boot/grub

	$(ASM) -f bin boot/boot.asm -o $(BUILD)/boot.bin
	$(ASM) -f bin kernel/kernel.asm -o kernel/kernel.bin

	cat $(BUILD)/boot.bin kernel/kernel.bin > $(BUILD)/BreadOS.img
