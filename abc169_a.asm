//abc169_a.asm
####################################
####################################
####################################
####################################
####################################
####################################
####################################
####################################
####################################
section .data
    fmt_i db "%d", 0
    fmt_p db "%d", 10, 0  ; 改行を付けました

section .bss
    b resd 1
    c resd 1

section .text
    extern printf, scanf

global main

main:
    push rbp
    mov rbp, rsp

    ; 第1数値入力
    lea rdi, [rel fmt_i]
    lea rsi, [rel b]
    call scanf wrt ..plt

    ; 第2数値入力
    lea rdi, [rel fmt_i]
    lea rsi, [rel c]
    call scanf wrt ..plt

    ; 積の計算
    mov eax, [rel b]
    imul dword [rel c]  ; EAX = EAX * [c]

    ; 積の出力
    lea rdi, [rel fmt_p]
    mov esi, eax
    call printf wrt ..plt

    pop rbp
    mov rax, 0
    ret
####################################
