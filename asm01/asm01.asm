section .data
    num db "1337", 0xA

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, num
    mov rdx, 5
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall