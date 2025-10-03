section .bss
    buffer resb 64

section .text
    global _start

_start:
    mov rdi, [rsp]      
    cmp rdi, 3          
    jne bad_args
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

bad_args:
    mov rax, 60
    mov rdi, 1
    syscall

convert_ascii:
    xor rax, rax
    xor r10, r10         
    mov dl, byte [r8]
    cmp dl, '-'
    jne .parse
    mov r10, 1
    inc r8
.parse:
.next:
    mov dl, byte [r8]
    cmp dl, 0
    je .done
    cmp dl, '0'
    jl fail
    cmp dl, '9'
    jg fail
    sub dl, '0'
    imul rax, rax, 10
    add rax, rdx
    inc r8
    jmp .next
.done:
    cmp r10, 0
    je .end
    neg rax
.end:
    ret

fail:
    mov rax, 60
    mov rdi, 1
    syscall

convert_integer:
    mov rax, rdi
    mov rcx, 10
    cmp rax, 0
    jge .pos
    neg rax
    mov r11, 1
    jmp .pos
.pos:
.next:
    xor rdx, rdx
    div rcx
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz .next
    cmp r11, 0
    je .done
    dec rsi
    mov byte [rsi], '-'
.done:
    ret
