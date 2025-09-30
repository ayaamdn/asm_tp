section .data
    num db "1337", 0xA

section .bss
    buffer resb 4

section .text
    global _start

_start:
    mov rbx, [rsp] ;argc
    cmp rbx, 2
    jl fail

    mov rsi, [rsp+16] ;argv[1]

    mov     al, byte [rsi]
    cmp     al, '4'
    jne     fail

    mov     al, byte [rsi+1]
    cmp     al, '2'
    jne     fail

    mov al, byte [rsi+2]
    cmp al, 0
    jne fail

    jmp success

success:
    mov rax, 1
    mov rdi, 1
    mov rsi, num
    mov rdx, 5
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

fail: 
    mov rax, 60
    mov rdi, 1
    syscall