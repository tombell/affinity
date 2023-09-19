OBJECTS = loader.o kmain.o
CC = gcc
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector \
		 -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
LDFFLAGS = -T link.ld -melf_i386
AS = nasm
ASFLAGS = -f elf -Fdwarf -g

all: affinity.iso

affinity.iso: kernel.elf
	mkdir -p iso/boot/grub
	cp kernel.elf iso/boot/
	genisoimage -R                           \
                -b boot/grub/stage2_eltorito \
                -no-emul-boot                \
                -boot-load-size 4            \
                -A os                        \
                -input-charset utf8          \
                -quiet                       \
                -boot-info-table             \
                -o affinity.iso              \
                iso

kernel.elf: $(OBJECTS)
	mkdir -p iso/boot
	ld $(LDFFLAGS) $(OBJECTS) -o kernel.elf

%.o: %.c
	$(CC) $(CFLAGS) $< -o $@

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -fr *.o iso/boot/kernel.elf affinity.iso
