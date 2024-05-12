abc068_a.asm
##########################################
global main
%use masm

%define MainMargin 0x200

_s_stdread: ;_s_stdread(byte[] string, unsigned long max_size)
	push rbp
	mov rbp,rsp
	push rdi
	push rsi
	mov rdx,[rbp+8*3]
	mov rsi,[rbp+8*2]
	xor rdi,rdi
	xor rax,rax
	syscall
	pop rsi
	pop rdi
	leave
	ret 8*2

_s_stdwrite: ;_s_stdwrite(byte[] string, unsigned long size)
	push rbp
	mov rbp,rsp
	push rdi
	push rsi
	mov rdx,[rbp+8*3]
	mov rsi,[rbp+8*2]
	mov rdi,1
	mov rax,1
	syscall
	pop rsi
	pop rdi
	leave
	ret 8*2

_s_strlen_b: ;_s_strlen_b(byte[] string)
	push rbp
	mov rbp,rsp
	push rdi
	mov rdi,[rbp+8*2]
	or rcx,-1
	xor al,al
	repne scasb
	not rcx
	mov rax,rcx
	pop rdi
	leave
	ret 8
	
_s_zmem_lda: ;_s_zmem_lda(unsigned long memory, unsigned long size)
	push rbp
	mov rbp,rsp
	push rdi
	mov rdi,[rbp+8*2]
	mov rcx,[rbp+8*3]
	and cl,0xfc
	shr rcx,2
	xor rax,rax
	cld
	rep stosd
	pop rdi
	leave
	ret 8*2

main:
	push rbp
	mov rbp,rsp
	push rbx
	sub rsp,MainMargin
	mov rbx,rsp
	
	push MainMargin
	push rbx
	call _s_zmem_lda
	
	lea rax,[rbx+3]
	push MainMargin-1
	push rax
	call _s_stdread
	
	or dword ptr [rbx],"ABC"
	push rbx
	call _s_strlen_b
	
  dec rax
	push rax
	push rbx
	call _s_stdwrite

  add rsp,MainMargin
	pop rbx
	xor rax,rax
	leave
	ret
##########################################
##########################################
##########################################
[逆順：xxxABC]
section .data
    fmt_s db "%s", "ABC", 10, 0  ; 

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
    ret
##########################################
[python]
A=str(input())
print("ABC"+A)
##########################################
