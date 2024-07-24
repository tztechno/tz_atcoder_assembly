abc122_a.asm
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
##########################################
section .data
    fmt_s db "%s", 0
    fmt_out db "%s", 10, 0  ; 改行コードを追加
    A db "T", 0
    T db "A", 0
    C db "G", 0
    G db "C", 0

section .bss
    input resb 128
    output resb 128

section .text
    extern printf, scanf
    global main

main:
    push rbp
    mov rbp, rsp

    ; 文字列入力
    lea rdi, [rel fmt_s]
    lea rsi, [rel input]
    call scanf wrt ..plt

    ; 文字列変換
    mov rsi, input
    mov rdi, output
    call translate

    ; 変換後の文字列出力
    lea rdi, [rel fmt_out]
    lea rsi, [rel output]
    call printf wrt ..plt

    pop rbp
    mov rax, 0
    ret

translate:
    ; rsi: 入力文字列のポインタ
    ; rdi: 出力文字列のポインタ
.loop:
    movzx eax, byte [rsi]  ; 入力文字を読み込む
    test al, al
    jz .done               ; null 文字なら終了

    cmp al, 'A'
    je .set_T
    cmp al, 'T'
    je .set_A
    cmp al, 'C'
    je .set_G
    cmp al, 'G'
    je .set_C
    jmp .next              ; マッチしない文字はスキップ

.set_T:
    mov byte [rdi], 'T'
    jmp .next
.set_A:
    mov byte [rdi], 'A'
    jmp .next
.set_G:
    mov byte [rdi], 'G'
    jmp .next
.set_C:
    mov byte [rdi], 'C'

.next:
    inc rsi
    inc rdi
    jmp .loop

.done:
    mov byte [rdi], 0  ; null 終端
    ret
##########################################
[python]
b=str(input())
if b=='A':
    ans='T'
elif b=='T':
    ans='A'
elif b=='C':
    ans='G'
elif b=='G':
    ans='C'
print(ans)
##########################################
