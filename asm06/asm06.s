section .bss
    buffer resb 64

section .text
    global _start

_start:
    mov rdi, [rsp]
    lea rsi, [rsp+8]
    mov rbx, [rsi+8]
    mov rcx, [rsi+16]
    mov r8, rbx
    call convert_ascii
    mov r9, rax
    mov r8, rcx
    call convert_ascii
    mov rbx, rax
    add rax, r9
    mov rdi, rax
    mov rsi, buffer+32
    call convert_integer
    mov rax, 1
    mov rdi, 1
    lea rsi, [rsi]
    mov rdx, buffer+32
    sub rdx, rsi
    syscall
    mov rax, 60
    xor rdi, rdi
    syscall

convert_ascii:
    xor rax, rax
.next:
    mov dl, byte [r8]
    cmp dl, 0
    je .done
    sub dl, '0'
    imul rax, rax, 10
    add rax, rdx
    inc r8
    jmp .next
.done:
    ret

convert_integer:
    mov rax, rdi
    mov rcx, 10
.next:
    xor rdx, rdx
    div rcx
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz .next
    ret