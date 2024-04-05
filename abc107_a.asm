//abc107_a.asm

section .data
  fmt_i db "%d", 10, 0  ; 改行コードを追加  
  
section .bss  
  a resd 3 
  b resd 3 

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
  
  mov rax, [rel a] ; rax = a
  sub rax, [rel b] ; rax -b
  add rax, 1 ; rax += 1

  lea rdi, [rel fmt_i]
  mov rsi, rax
  call printf wrt ..plt
  
  mov rax, 0
  pop rbp
  ret

