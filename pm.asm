;----------------------------------------------------
; pm.asm - Code to switch to protected mode for PicOS
; Copyright (C) Yanderemine54 2021
;----------------------------------------------------

[BITS 16]
switch_to_pm:
    cli
    lgdt [gdt_descriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:init_pm

[BITS 32]
init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    call BEGIN_PM
