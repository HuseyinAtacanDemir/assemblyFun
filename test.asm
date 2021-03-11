;https://www.jdoodle.com/compile-assembler-nasm-online/
; I'm using this online nasm compiler to compile the code..
;here is a asm file that prints all numbers from the given num -1 to zero..
;why?
;cause it's fun that's why lol

section	.data
    segment .bss
    num resq 1
    temp resq 1
    sum resb 10
    len resb 1

section	.text
   global _start                            ;must be declared for using gcc

_start:                                     ;tell linker entry point

        mov [sum + 8], byte 0xA
        mov [sum + 9], byte 0xD

        mov [num], word 11
    
    _loop:
        mov eax, [num]
        mov [temp], eax
        dec word [temp]
        mov [len], byte 8
        
        _digitToAscii: 
            mov esi, [len]                  ;getting current length to esi
            xor edx, edx
            mov eax, [temp]
            mov ecx, 10
            div ecx                         ;divide eax that we get from above by ten
            mov [temp], eax
            
            add dl, '0'                     ;turn edx into ascii
            mov [sum + esi - 1], dl         ; move that digit into the corresponding index in sum string
            
            dec byte [len]                  ; decrementing length to point to next digin in sum
            jnz _digitToAscii               ;jump if we haven't covered all digits
            
        ;print sum string
        
            mov edx, 10
            mov ecx, sum
            mov ebx, 1
            mov eax, 4
            int 0x80
            
            dec word [num]
            jnz _loop
            
            
_end:
            mov eax, 1
            int 0x80
            
