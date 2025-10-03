section .bss
    buffer resb 16

section .text
    global _start

_start:
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 16
    syscall

    xor rbx, rbx ; rbx stores buffer content
    xor rcx, rcx

convert_loop:
    mov al, byte [buffer + rcx]
    cmp al, 10 ; '\n' => newline
    je check_even_odd
    cmp al, 0 ; '0' => end of string
    je check_even_odd

    sub al, '0' ; convert ascii to digit
    imul rbx, rbx, 10
    add rbx, rax
    inc rcx
    jmp convert_loop

check_even_odd:
    mov rax, rbx
    and rax, 1 ; keep lowest bit
    jz number_even ; lsb flag

number_odd:
    mov rax, 60
    mov rdi, 1
    syscall

number_even:
    mov rax, 60
    xor rdi, rdi
    syscall

; a number is even if last binary bit = 0