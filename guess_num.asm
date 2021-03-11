;nasm -f macho64 guess_num.asm && ld -macosx_version_min 10.7.0 -o guess_num guess_num.o && ./guess_num
    global    start
    section   .text

start:
    mov       rax, 0x02000004
    mov       rdi, 1
    mov       rsi, guess
    mov       rdx, leng
    syscall

    mov       rax, 0x02000004
    mov       rdi, 1
    mov       rsi, higher
    mov       rdx, lenh
    syscall

    mov       rax, 0x02000004
    mov       rdi, 1
    mov       rsi, lower
    mov       rdx, lenl
    syscall

    mov       rax, 0x02000004
    mov       rdi, 1
    mov       rsi, gotit
    mov       rdx, lengt
    syscall

    mov       rax, 0x02000001
    xor       rdi, rdi
    syscall 



    section   .data
guess:   db  "Guess Number", 10
leng:    equ $ - guess
higher:  db  "Higher", 10
lenh:    equ $ - higher
lower:   db  "Lower", 10
lenl:    equ $ - lower
gotit:   db  "You Got It!", 10
lengt:   equ $ - gotit