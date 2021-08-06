;------------------------------------------------
; load_kernel.asm - Loads PicOS's kernel
; Copyright (C) Yanderemine54 2021
;------------------------------------------------
[BITS 32]
[extern main]
call main
jmp $
