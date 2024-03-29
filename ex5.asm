###################################################
　[AC version]

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
  
  mov rax, [rel a]
  add rax, [rel b]
  
  lea rdi, [rel fmt_i]
  mov rsi, rax
  call printf wrt ..plt
  
  mov rax, 0
  pop rbp
  ret


###################################################

    [both test is ok but submission errors]

###################################################

section .data
  fmt_i db "%d", 0      #### 改行コードが含まれていないことがWAの原因である
  
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
  
  mov rax, [rel a]
  add rax, [rel b]
  
  lea rdi, [rel fmt_i]
  mov rsi, rax
  call printf wrt ..plt
  
  mov rax, 0
  pop rbp
  ret

###################################################

section .data
  fmt_i db "%d", 0
  fmt_p db "%d", 0　　　　　　　　　　#### 改行コードが含まれていないことがWAの原因である
  
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
  
  mov rax, [rel a]
  add rax, [rel b]
  
  lea rdi, [rel fmt_p]
  mov rsi, rax
  call printf wrt ..plt
  
  mov rax, 0
  pop rbp
  ret

###################################################
