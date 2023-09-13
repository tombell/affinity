global loader                   ; The entry symbol for ELF

MAGIC_NUMBER equ 0x1BADB002     ; Define the magic number constant
FLAGS        equ 0x0            ; Multiboot flags
CHECKSUM     equ -MAGIC_NUMBER  ; Calculate the checksum
                                ; (magic number + checksum + flags should equal 0)

section .text:                  ; Start of the text (code) section
align 4                         ; The code must be 4 byte aligned
  dd MAGIC_NUMBER               ; Write the magic number to the machine code,
  dd FLAGS                      ; The flags,
  dd CHECKSUM                   ; The checksum

loader:                         ; The loader label (defined as entry point in linker script)
    mov eax, 0xCAFEBABE         ; Place the number 0xCAFEBABE in the register eax
.loop:
    jmp .loop                   ; Loop forever
