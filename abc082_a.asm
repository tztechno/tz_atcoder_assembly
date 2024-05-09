abc082_a.ass
##########################################
##########################################
##########################################
##########################################
##########################################
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

    ; 計算
    mov eax, [rel b]       ; Load b into eax; eax=b
    add dword [rel c], eax ; Add eax to the value at c; c=c+eax
    add dword [rel c], 1   ; Add 1 to the value at c; c=c+1
    mov eax, dword [rel c] ; Move the updated value at c into eax
    shr eax, 1             ; Divide eax by 2 (shift right by 1)

    ; 出力
    lea rdi, [rel fmt_p]
    mov esi, eax
    call printf wrt ..plt

    pop rbp
    mov rax, 0
    ret
##########################################
[python]
import math
a,b=map(int,input().split())
print(math.ceil((a+b)/2))
##########################################
