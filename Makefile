ASM=nasm
BUILD=build
ISO=iso

all:
	mkdir -p $(BUILD)
	mkdir -p $(ISO)/boot/grub

	$(ASM) -f bin boot/boot.asm -o $(BUILD)/boot.bin
	$(ASM) -f bin kernel/kernel.asm -o kernel/kernel.bin

	cat $(BUILD)/boot.bin kernel/kernel.bin > $(BUILD)/BreadOS.img

	cp $(BUILD)/BreadOS.img $(ISO)/boot/BreadOS.img

	echo 'set timeout=0' > $(ISO)/boot/grub/grub.cfg
	echo 'set default=0' >> $(ISO)/boot/grub/grub.cfg
	echo 'menuentry "BreadOS" {' >> $(ISO)/boot/grub/grub.cfg
	echo '    multiboot /boot/BreadOS.img' >> $(ISO)/boot/grub/grub.cfg
	echo '    boot' >> $(ISO)/boot/grub/grub.cfg
	echo '}' >> $(ISO)/boot/grub/grub.cfg

	grub-mkrescue -o $(BUILD)/BreadOS.iso $(ISO)

run:
	qemu-system-i386 $(BUILD)/BreadOS.img

iso:
	qemu-system-i386 -cdrom $(BUILD)/BreadOS.iso

clean:
	rm -rf $(BUILD)
	rm -rf $(ISO)
