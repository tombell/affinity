global loader                   ; The entry symbol for ELF

extern sum_of_three             ; The function sum_of_three is defined elsewhere

MAGIC_NUMBER equ 0x1BADB002     ; Define the magic number constant
FLAGS        equ 0x0            ; Multiboot flags
CHECKSUM     equ -MAGIC_NUMBER  ; Calculate the checksum
                                ; (magic number + checksum + flags should equal 0)

KERNEL_STACK_SIZE equ 4096      ; Size of stack in bytes

section .bss
align 4                         ; Align at 4 bytes
kernel_stack:                   ; Label points to beginning of memory
  resb KERNEL_STACK_SIZE        ; Reserve stack for the kernel

section .text:                  ; Start of the text (code) section
align 4                         ; The code must be 4 byte aligned
  dd MAGIC_NUMBER               ; Write the magic number to the machine code,
  dd FLAGS                      ; The flags,
  dd CHECKSUM                   ; The checksum

loader:                         ; The loader label (defined as entry point in linker script)
  push dword 3                  ; arg3
  push dword 2                  ; arg2
  push dword 1                  ; arg1
  call sum_of_three             ; Call the function, the result will be in eax
  jmp $
