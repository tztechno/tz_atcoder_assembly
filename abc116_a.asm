abc116_a.asm
###########################################
###########################################
###########################################
###########################################
###########################################
###########################################
###########################################
###########################################
###########################################
section .data
fmt_i db "%d", 0
fmt_p db "%d", 10, 0  ; Added newline character

section .bss
b resd 1
c resd 1

section .text
extern printf, scanf
global main

main:
    push rbp
    mov rbp, rsp

    ; First number input
    lea rdi, [rel fmt_i]
    lea rsi, [rel b]
    call scanf wrt ..plt

    ; Second number input
    lea rdi, [rel fmt_i]
    lea rsi, [rel c]
    call scanf wrt ..plt

    ; Calculation
    mov eax, [rel b]    ; eax = b
    mul dword [rel c]   ; eax = eax * c
    mov edx, 0          ; Clear the upper 32 bits of the dividend
    mov ecx, 2          ; Load the divisor (2) into ecx
    idiv ecx            ; eax = eax / 2 (integer division)

    ; Output
    lea rdi, [rel fmt_p]
    mov esi, eax
    call printf wrt ..plt

    pop rbp
    mov rax, 0
    ret
###########################################
[python]
a,b,c=map(int,input().split())
print(a*b//2)
###########################################
