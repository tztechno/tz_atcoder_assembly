section .data
  fmt_i db "%d", 0  ; 整数を読み取るフォーマット文字列
  fmt_s db "%s", 0  ; 文字列を出力するフォーマット文字列
  abc db "ABC", 0  ; "ABC"の文字列
  arc db "ARC", 0  ; "ARC"の文字列

section .bss  
  num resd 1  ; 整数を格納する変数

section .text
  extern printf, scanf
  global main

main:
  push rbp
  
  lea rdi, [rel fmt_i]
  lea rsi, [rel num]
  call scanf wrt ..plt
  
  ; 格納された整数を読み取る
  mov eax, dword [rel num]
  
  ; 整数が1200未満であれば"ABC"を出力、そうでなければ"ARC"を出力
  cmp eax, 1200
  jl abc_output  ; a < 1200の場合、"ABC"を出力
  
  ; それ以外の場合、"ARC"を出力
  lea rdi, [rel fmt_s]
  lea rsi, [rel arc]
  call printf wrt ..plt
  jmp end_program

abc_output:
  ; "ABC"を出力
  lea rdi, [rel fmt_s]
  lea rsi, [rel abc]
  call printf wrt ..plt

end_program:
  mov eax, 0
  pop rbp
  ret
