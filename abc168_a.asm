//abc168_a.asm
################################
################################
################################
################################
section .text
    global main

main:
    push rbp
    mov  rbp, rsp
    sub  rsp, 4
    mov  BYTE [rbp-2], 0x0a
    mov  bh, [rbp-2]
    loop_input_num:
        mov  rax, 0
        mov  rdi, 0
        lea  rsi, BYTE [rbp-1]
        mov  rdx, 1
        syscall
        mov  cl, BYTE[rbp-1]
        cmp  cl, bh
        jz   judge
        mov  BYTE [rbp-3], cl
        jmp  loop_input_num
    
    judge:
        mov  rax, 1
        mov  rdi, 2
        lea  rsi, BYTE [rbp-3]
        mov  rdx, 1
        syscall
        mov  bh, BYTE[rbp-3]
        mov  BYTE [rbp-2], 0x30
        mov  ch, [rbp-2]
        cmp  ch, bh
        jz   pon  ;0
        add  ch, 1
        cmp  ch, bh
        jz   pon  ;1
        add  ch, 1
        cmp  ch, bh
        jz   hon  ;2
        add  ch, 1
        cmp  ch, bh
        jz   bon  ;3
        add  ch, 1
        cmp  ch, bh
        jz   hon  ;4
        add  ch, 1
        cmp  ch, bh
        jz   hon  ;5
        add  ch, 1
        cmp  ch, bh
        jz   pon  ;6
        add  ch, 1
        cmp  ch, bh
        jz   hon  ;7
        add  ch, 1
        cmp  ch, bh
        jz   pon  ;8
        add  ch, 1
        cmp  ch, bh
        jz   hon  ;9
    
    
    pon:
        mov  rsi, msp
        jmp  out
    hon:
        mov  rsi, msh
        jmp  out
    bon:
        mov  rsi, msb
        jmp  out
    out:
    mov  rax, 1
    mov  rdi, 1
    mov  rdx, 4
    syscall
    mov  rax, 60
    mov  rdi, 0
    syscall
    ret
    
section .data
    msp db "pon", 0x0a
    msh db "hon", 0x0a
    msb db "bon", 0x0a
################################
