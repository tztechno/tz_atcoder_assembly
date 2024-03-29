section .data
    fmt_i db "%ld", 10, 0  ;

section .text
    extern printf
    global main

main:
    push rbp
    mov rbp, rsp
    mov rax, 100  ; a = 100

    ; a*(a+1)/2の計算
    mov rbx, rax    ; rbx = a
    inc rbx         ; rbx = a + 1
    mul rbx         ; rdx:rax = a * (a + 1)
    shr rax, 1      ; rax = (a * (a + 1)) / 2 (下位64ビット)

    ; 出力
    mov rdi, fmt_i       ; 第1引数(フォーマット文字列)
    mov rsi, rax         ; 第2引数(計算結果)
    xor rax, rax         ; raxをクリア
    call printf wrt ..plt

    xor eax, eax  ; 戻り値0を設定
    pop rbp
    ret
