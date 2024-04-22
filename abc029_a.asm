##########################################################
section .data
    fmt_s db "%s", "s", 10, 0  ; "s" を改行コードの前に追加

section .bss
    s resb 128

section .text
    extern printf, scanf

global main

main:
    push rbp
    mov rbp, rsp

    ; 文字列入力
    lea rdi, [rel fmt_s]
    lea rsi, [rel s]
    call scanf wrt ..plt

    ; 文字列出力
    ; 改行コードの前に "s" を追加して出力
    lea rdi, [rel fmt_s]
    lea rsi, [rel s]
    call printf wrt ..plt

    pop rbp
    mov rax, 0
    ret
    ret
##########################################################
