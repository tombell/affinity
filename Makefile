OBJECTS = loader.o
LDFFLAGS = -T link.ld -melf_i386
AS = nasm
ASFLAGS = -f elf -Fdwarf -g

all: affinity.iso

affinity.iso: kernel.elf
	echo Generating $<…
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
	echo Linking $<…
	mkdir -p iso/boot
	ld $(LDFFLAGS) $(OBJECTS) -o kernel.elf

%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -fr *.o iso/boot/kernel affinity.iso