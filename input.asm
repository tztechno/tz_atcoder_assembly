#######################################################
#######################################################
#######################################################
#######################################################
2 3 --> 合計を出力
-----------------

section .data
  fmt_i db "%d", 0
  fmt_p db "%d", 0
  
section .bss  
  b resd 3 
  c resd 3 

section .text
  extern printf, scanf
  global main

main:
  push rbp
  
  lea rdi, [rel fmt_i]
  lea rsi, [rel b]
  call scanf wrt ..plt
  
  lea rdi, [rel fmt_i]
  lea rsi, [rel c]
  call scanf wrt ..plt

  mov rax, [rel b]
  add rax, [rel c]
  
  lea rdi, [rel fmt_p]
  mov rsi, rax
  call printf wrt ..plt
  
  mov rax, 0
  pop rbp
  ret
#######################################################
5
----------------
section .data
    fmt_d db "%d", 10, 0  ; 整数入出力用のフォーマット文字列

section .bss
    n resd 1              ; 整数を格納する領域

section .text
    extern printf, scanf

global main

main:
    push rbp
    mov rbp, rsp

    ; 整数入力
    lea rdi, [rel fmt_d]
    lea rsi, [rel n]
    call scanf wrt ..plt

    ; 整数出力
    lea rdi, [rel fmt_d]
    mov esi, [rel n]
    call printf wrt ..plt

    pop rbp
    mov rax, 0
    ret
#######################################################
test
----------------
section .data
    fmt_s db "%s", 10, 0  ; 改行コードを追加

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
    lea rdi, [rel fmt_s]
    lea rsi, [rel s]
    call printf wrt ..plt

    pop rbp
    mov rax, 0
    ret
#######################################################
1
2 3
test
-------------------
section .data
  fmt_i db "%d", 0
  fmt_s db "%s", 0
  fmt_p db "%d %s", 0
section .bss  
  a resd 3 
  b resd 3 
  c resd 3 
  s resb 128

section .text
  extern printf, scanf
  global main

main:
  push rbp
  
  lea rdi, [rel fmt_i]
  lea rsi, [rel a]
  call scanf wrt ..plt
  
  lea rdi, [rel fmt_i]
  lea rsi, [rel b]
  call scanf wrt ..plt
  
  lea rdi, [rel fmt_i]
  lea rsi, [rel c]
  call scanf wrt ..plt

  lea rdi, [rel fmt_s]
  lea rsi, [rel s]
  call scanf wrt ..plt
  
  mov rax, [rel a]
  add rax, [rel b]
  add rax, [rel c]
  
  lea rdi, [rel fmt_p]
  mov rsi, rax
  lea rdx, [rel s]
  call printf wrt ..plt
  
  mov rax, 0
  pop rbp
  ret
#######################################################
#######################################################
