; --------------------------------------
; boot.asm - simple bootloader for PicOS
; Copyright (C) Yanderemine54 2021
; --------------------------------------
    mov ax, 0x07c0
    mov ds, ax

    mov si, msg
    cld

ch_loop: lodsb
    or al, al ; 0=end of string
    jz hang ; finish
    mov ah, 0x0E
    mov bh, 0
    int 0x10
    jmp ch_loop


hang:
    jmp hang ; hang

msg   db 'Starting PicOS...', 13, 10, 0

    times 510-($-$$) db 0 ; write boot sector with zeroes and magic BIOS byte sequence
    db 0x55
    db 0xAA

