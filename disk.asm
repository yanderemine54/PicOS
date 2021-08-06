;-------------------------------------------
; disk.asm - Disk loading routines for PicOS
; Copyright (C) Yanderemine54 2021
;-------------------------------------------
disk_load:
    pusha

    push dx

    mov ah, 0x02
    mov al, dh
    mov cl, 0x02

    mov ch, 0x00
    mov dh, 0x00

    int 0x13
    jc disk_error

    pop dx
    cmp al, dh
    jne sectors_error
    popa
    ret

disk_error:
    jmp disk_loop

sectors_error:

disk_loop:
    jmp $
