; here is a piece of asm code that prints the fib numbers upto and includeing n-1
; i know i know, instead of jumps everywhere i should have used the stack
;but I don't know how to use the stack yet... so this is the best we can do for now

section	.data
    msg db '^ N-1th fib number ^', 0xA, 0xD
    msgLen equ $ - msg
    a dq 1
    b dq 0
    c dq 0
    segment .bss
        n resq 1
        output resb 10
        strPos resb 1

section	.text
   global _start                            ;must be declared for using gcc
   
_start:                                     ;tell linker entry point

    mov [output + 8], byte 0xA
    mov [output + 9], byte 0xD

    mov [n], word 21                        ;change n here, beware it prints n-1th fib num
    
    _fib:
        mov [strPos], byte 8
        _digitToAscii: 
            mov esi, [strPos]                  ;getting current length to esi
            xor edx, edx                    ;gotta clear d register before div command
            mov eax, [c]
            mov ecx, 10
            div ecx                         ;divide eax that we get from above by ten
            mov [c], eax                    ;store the result in c
            
            add dl, '0'                     ;turn low portion of d regsiter that holds the remainder, aka the digit we want, into ascii
            mov [output + esi - 1], dl         ; move that ascii digit into the corresponding index in the output string
            
            dec byte [strPos]                  ; decrementing the length in order to point to next position in output str
            jnz _digitToAscii               ;jump if we have digits left,
            ;in a previous version, I was usinge eax to do this.. but of course eax gets changed on line 35 when we add '0'... so instead I check the condition based on the str length
        
        ;_print:
            mov edx, 10
            mov ecx, output
            mov ebx, 1
            mov eax, 4
            int 0x80
            
        ;fib alg
        mov eax, [a]
        mov ebx, [b]
 
        mov ecx, eax
        add eax, ebx
        mov ebx, ecx
        
        mov [a], eax
        mov [b], ebx
        mov [c], ecx
            
        dec word [n]
        jnz _fib
            
    mov edx, msgLen
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 0x80
    ;end
    mov eax, 1
    int 0x80