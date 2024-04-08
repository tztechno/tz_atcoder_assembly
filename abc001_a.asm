abc001_a.asm
##############################
##############################
##############################
##############################
##############################
##############################
##############################
section .data
    fmt db "%d", 10, 0
    fmt_s db "%s", 0

section .text
  global main
  extern printf, scanf

main :
	push rbp
  mov rbp, rsp
  sub rsp, 256
	
	lea rdi, [rel fmt]
	lea rsi, [rsp]
	call scanf WRT ..plt
	
	lea rdi, [rel fmt]
	lea rsi, [rsp + 8]
	call scanf WRT ..plt
	
	mov rax, [rsp]
	sub rax, [rsp + 8]
	
	lea rdi, [rel fmt]
	lea rsi, [rax]
	call printf WRT ..plt

	mov eax, 0
  mov rsp,rbp
  pop rbp
  ret
##############################
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
  
  ; a の入力
  lea rdi, [rel fmt_i]
  lea rsi, [rel a]
  call scanf wrt ..plt
  
  ; b の入力
  lea rdi, [rel fmt_i]
  lea rsi, [rel b]
  call scanf wrt ..plt
  
  ; b の補数を取る
  mov rax, [rel b]
  neg rax
  mov [rel b], rax
  
  ; a に b を加算することで a - b を計算する
  mov rax, [rel a]
  add rax, [rel b]
  
  ; 結果の表示
  lea rdi, [rel fmt_i]
  mov rsi, rax
  call printf wrt ..plt
  
  ; 終了
  mov rax, 0
  pop rbp
  ret
##############################
