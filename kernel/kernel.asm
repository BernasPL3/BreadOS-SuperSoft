org 0x0000

mov ah, 0x0E

mov si, msg

print:
    lodsb
    cmp al, 0
    je halt

    int 0x10
    jmp print

halt:
    cli
    hlt

msg db "Welcome to BreadOS!",0
