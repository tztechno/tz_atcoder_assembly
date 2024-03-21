//practiceA.asm
##################################

##################################
##################################
##################################
##################################
##################################
##################################
##################################
##################################
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
##################################
section .data
  fmt_i db "%d", 0
  fmt_s db "%s", 0
  fmt_p db "%d %s", 0
section .bss  
  a resd 3 
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
  lea rsi, [rel a+4]
  call scanf wrt ..plt
  
  lea rdi, [rel fmt_i]
  lea rsi, [rel a+8]
  call scanf wrt ..plt

  lea rdi, [rel fmt_s]
  lea rsi, [rel s]
  call scanf wrt ..plt
  
  mov rax, [rel a]
  add rax, [rel a+4]
  add rax, [rel a+8]
  
  lea rdi, [rel fmt_p]
  mov rsi, rax
  lea rdx, [rel s]
  call printf wrt ..plt
  
  mov rax, 0
  pop rbp
  ret
##################################
global main
extern scanf
extern printf

section .data
    fmt     db '%d %d %d %s', 0
    fmtp    db '%d %s', 10, 0

section .bss
    s       resb 1024

section .text
main:
    push    rbp
    sub     rsp, 32
    lea     rdi, [rel fmt]
    lea     rsi, [rsp]
    lea     rdx, [rsp + 4]
    lea     rcx, [rsp + 8]
    lea     r8,  [rel s]
    xor     eax, eax
    call    scanf wrt ..plt
    
    mov     esi, DWORD [rsp]
    add     esi, DWORD [rsp + 4]
    add     esi, DWORD [rsp + 8]
    lea     rdx, [rel s]

    lea     rdi, [rel fmtp]
    xor     eax, eax
    call    printf wrt ..plt
    
    add     rsp, 32
    pop     rbp
    xor     eax, eax
    ret
    
    
##################################
[改造元にする]

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
##################################
