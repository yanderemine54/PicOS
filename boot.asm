;----------------------------------------------
; boot.asm - Simple bootloader for PicOS
; Copyright (C) Yanderemine54 2021
;----------------------------------------------
[ORG 0x7c00]
KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl
    mov bp, 0x9000
    mov sp, bp

    call load_kernel
    call switch_to_pm
    jmp $

%include "gdt.asm"
%include "disk.asm"
%include "pm.asm"

[BITS 16]
load_kernel:
    mov bx, KERNEL_OFFSET
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[BITS 32]
BEGIN_PM:
    call KERNEL_OFFSET
    jmp $

BOOT_DRIVE db 0

times 510-($-$$) db 0
dw 0xaa55
