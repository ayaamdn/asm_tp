section .text
    global _start

_start:
    mov rdi, [rsp]
    lea rsi, [rsp+8]
    mov rbx, [rsi+8]
    test rbx, rbx
    jz fail
    mov rcx, rbx

len_loop:
    cmp byte [rcx], 0
    je len_done
    inc rcx
    jmp len_loop

len_done:
    sub rcx, rbx
    mov rax, 1
    mov rdi, 1
    mov rsi, rbx
    mov rdx, rcx
    syscall

fail:
    mov rax, 60
    xor rdi, rdi
    syscall
