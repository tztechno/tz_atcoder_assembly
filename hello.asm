
#####################################################

section .data
message: db "Hello, world!", 10

section .text
global main
main:
    mov rax, 1
    mov rdi, 1
    mov rsi, message
    mov rdx, 14
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

#####################################################

section .text
    global main

main:
    mov  rax, 1
    mov  rdi, 1
    mov  rsi, msg
    mov  rdx, 14
    syscall
    mov  rax, 60
    mov  rdi, 0
    syscall
    ret

section .data
    msg db "Hello, world!", 0x0A

#####################################################

#####################################################

#####################################################
