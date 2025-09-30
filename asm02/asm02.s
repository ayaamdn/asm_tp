section .data
    num db "1337", 0xA

section .bss
    buffer resb 4

section .text
    global _start

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 4
    syscall

    mov     al, byte [buffer]
    cmp     al, '4'
    jne     fail

    mov     al, byte [buffer+1]
    cmp     al, '2'
    jne     fail

    mov al, bute [buffer+2]
    cmp al, '0xA'
    je success
    jmp fail

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