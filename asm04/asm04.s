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
    xor r8, r8   ; r8 = negative flag

    mov al, byte [buffer + rcx]
    cmp al, '-'
    jne parse_start
    inc rcx
    mov r8, 1

parse_start:

convert_loop:
    mov al, byte [buffer + rcx]
    cmp al, 10 ; '\n' => newline
    je check_even_odd
    cmp al, 0 ; '0' => end of string
    je check_even_odd

    cmp al, '0'
    jl fail
    cmp al, '9'
    jg fail

    sub al, '0' ; convert ascii to digit
    imul rbx, rbx, 10
    jo fail
    add rbx, rax
    jo fail
    inc rcx
    jmp convert_loop

check_even_odd:
    cmp r8, 0
    je sign_done
    neg rbx
sign_done:
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

fail: 
    mov rax, 60
    mov rdi, 2
    syscall

; a number is even if last binary bit = 0
