//abc007_a.asm

section .data
  fmt_i db "%d", 10, 0  ; 改行コードを追加  
  
section .bss  
  a resd 1 ; a を単一の4バイト整数として宣言
  

section .text
  extern printf, scanf
  global main

main:
  push rbp
  
  ; a の入力
  lea rdi, [rel fmt_i]
  lea rsi, [rel a]
  call scanf wrt ..plt
  
  ; a から1を引く
  mov eax, [rel a]
  sub eax, 1
  mov [rel a], eax
  
  ; 結果の表示
  lea rdi, [rel fmt_i]
  mov rsi, [rel a] ; a の値をrsiにセット
  call printf wrt ..plt
  
  ; 終了
  mov rax, 0
  pop rbp
  ret
