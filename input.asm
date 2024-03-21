#######################################################
#######################################################
#######################################################
5
----------------

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
