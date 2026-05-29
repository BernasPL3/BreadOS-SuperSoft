ASM=nasm
BUILD=build
ISO=iso

all:
	mkdir -p $(BUILD)

	$(ASM) -f bin boot/boot.asm -o $(BUILD)/boot.bin
	$(ASM) -f bin kernel/kernel.asm -o $(BUILD)/kernel.bin

	cat $(BUILD)/boot.bin $(BUILD)/kernel.bin > $(BUILD)/BreadOS.img

iso:
	mkdir -p $(ISO)/boot/grub

	cp $(BUILD)/BreadOS.img $(ISO)/boot/BreadOS.img

	echo 'menuentry "BreadOS" {' > $(ISO)/boot/grub/grub.cfg
	echo '    multiboot /boot/BreadOS.img' >> $(ISO)/boot/grub/grub.cfg
	echo '    boot' >> $(ISO)/boot/grub/grub.cfg
	echo '}' >> $(ISO)/boot/grub/grub.cfg

	grub-mkrescue -o $(BUILD)/BreadOS.iso $(ISO)

run:
	qemu-system-i386 $(BUILD)/BreadOS.img

clean:
	rm -rf $(BUILD)
	rm -rf $(ISO)
