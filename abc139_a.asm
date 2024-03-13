section .text
global main

%macro save 0
    push rax
    push rbx
    push rcx
    push rdx
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
%endmacro
%macro load 0
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rdx
    pop rcx
    pop rbx
    pop rax
%endmacro
%macro at 3
    mov %1,%2
    add %1,%3
    add %1,%3
    add %1,%3
    add %1,%3
    add %1,%3
    add %1,%3
    add %1,%3
    add %1,%3
%endmacro
%macro endl 0
    save
    call endl_
    load
%endmacro
endl_:
    mov rax,1
    mov rdi,1
    mov rsi,tmp
    mov qword[rsi],10
    mov rdx,1
    syscall
    ret
    
%macro space 0
    save
    call space_
    load
%endmacro
space_:
    mov rax,1
    mov rdi,1
    mov rsi,tmp
    mov qword[rsi],32
    mov rdx,1
    syscall
    ret
    
%macro exit 0
    save
    call exit_
    load
%endmacro
exit_:
    mov rax,60
    xor rdi,rdi
    syscall
    ret
    
%macro getline 1
    save
    mov r12,%1_size
    push r12
    mov r12,%1
    push r12
    call getline_
    load
%endmacro
getline_:
    mov rcx,[rsp+8]
    mov r8,-1
    getlineloop_:
        add r8,1
        push rcx
        push r8
        xor r8,r8
        mov rax,0
        xor rdi,rdi
        mov rsi,rcx
        mov rdx,1
        syscall
        pop r8
        pop rcx
        add rcx,8
        mov rax,[rsi]
        cmp al,10
        je getlineend_
        cmp al,26
        je getlineend_
        jmp getlineloop_
        getlineend_:
    mov rcx,[rsp+16]
    mov [rcx],r8
    ret 16

%macro cin 1
    save
    mov r12,%1_size
    push r12
    mov r12,%1
    push r12
    call cin_
    load
%endmacro
cin_:
    mov rcx,[rsp+8]
    mov r8,-1
    cinread_:
        add r8,1
        push rcx
        push r8
        xor r8,r8
        mov rax,0
        xor rdi,rdi
        mov rsi,rcx
        mov rdx,1
        syscall
        pop r8
        pop rcx
        cmp byte[rsi],10
        je cinend_
        cmp byte[rsi],26
        je cinend_
        cmp byte[rsi],32
        je cinend_
        add rcx,8
        jmp cinread_
        cinend_:
    mov byte[rcx],10
    mov rcx,[rsp+16]
    mov [rcx],r8
    ret 16

%macro cout 1
    save
    mov r12,%1
    push r12
    call cout_
    load
%endmacro
cout_:
    mov r8,[rsp+8]
    coutloop_:
        push r8
        mov rax,1
        mov rdi,1
        mov rsi,r8
        mov rdx,1
        syscall
        pop r8
        add r8,8
        cmp byte[r8],10
        je coutloopend_
        jmp coutloop_
        coutloopend_:
    ret 8
    
%macro putll 1
    save
    mov r12,%1
    push r12
    call putll_
    load
%endmacro
putll_:
    mov rax,[rsp+8]
    mov rax,[rax]
    xor r15,r15
    add r15,1
    shl r15,63
    test rax,r15
    je putllskip_
    save
    mov rax,1
    mov rdi,1
    mov rsi,tmp
    mov qword[rsi],45
    mov rdx,1
    syscall
    load
    not rax
    add rax,1
    putllskip_:
    mov rdi,ull
    add rdi,20
    mov rcx,10
    mov rbx,0
    putll_loop_:
        add rbx,1
        sub rdi,1
        xor rdx,rdx
        idiv rcx
        add dl,48
        mov byte[rdi],dl
        test rax,rax
        jnz putll_loop_
    mov rax,1
    mov rdi,1
    mov rsi,ull
    add rsi,20
    sub rsi,rbx
    mov rdx,rbx
    syscall
    ret 8
    
%macro stoll 2
    save
    mov r12,%2
    push r12
    mov r12,%1
    push r12
    call stoll_
    load
%endmacro
stoll_:
    mov rdx,0
    mov rax,[rsp+8]
    xor r8,r8
    mov r9,45
    dec_:
        movzx rbx,byte[rax]
        cmp r9,rbx
        jne stollnotminus1_
        add r8,1
        add rax,8
        jmp dec_
        stollnotminus1_:
        imul rdx,10
        add rdx,rbx
        sub rdx,48
        add rax,8
        cmp byte[rax],48
        jge dec_
    test r8,r8
    je stollnotminus2_
    sub rdx,1
    not rdx
    stollnotminus2_:
    mov rbx,[rsp+16]
    mov qword[rbx],rdx
    ret 16

%macro plus 2
    save
    mov r12,%2
    push r12
    mov r12,%1
    push r12
    call plus_
    load
%endmacro
plus_:
    mov rax,[rsp+8]
    mov rax,[rax]
    mov rbx,[rsp+16]
    mov rbx,[rbx]
    add rax,rbx
    mov rbx,[rsp+8]
    mov qword[rbx],rax
    ret 16

%macro prod 2
    save
    mov r12,%2
    push r12
    mov r12,%1
    push r12
    call prod_
    load
%endmacro
prod_:
    mov rax,[rsp+8]
    mov rax,[rax]
    mov rbx,[rsp+16]
    mov rbx,[rbx]
    imul rax,rbx
    mov rbx,[rsp+8]
    mov qword[rbx],rax
    ret 16
    
%macro mod 2
    save
    mov r12,%2
    push r12
    mov r12,%1
    push r12
    call mod_
    load
%endmacro
mod_:
    mov rax,[rsp+8]
    mov rax,[rax]
    mov rbx,[rsp+16]
    mov rbx,[rbx]
    xor rdx,rdx
    idiv rbx
    mov rbx,[rsp+8]
    mov qword[rbx],rdx
    ret 16
    
%macro minus 2
    save
    mov r12,%2
    push r12
    mov r12,%1
    push r12
    call minus_
    load
%endmacro
minus_:
    mov rax,[rsp+8]
    mov rax,[rax]
    mov rbx,[rsp+16]
    mov rbx,[rbx]
    sub rax,rbx
    mov rbx,[rsp+8]
    mov qword[rbx],rax
    ret 16
    
%macro max 2
    save
    mov r12,%2
    push r12
    mov r12,%1
    push r12
    call max_
    load
%endmacro
max_:
    mov rax,[rsp+8]
    mov rax,[rax]
    mov rbx,[rsp+16]
    mov rbx,[rbx]
    cmp rax,rbx
    jg max_end_
    mov rax,rbx
    max_end_:
    mov rbx,[rsp+8]
    mov qword[rbx],rax
    ret 16

%macro min 2
    save
    mov r12,%2
    push r12
    mov r12,%1
    push r12
    call min_
    load
%endmacro
min_:
    mov rax,[rsp+8]
    mov rax,[rax]
    mov rbx,[rsp+16]
    mov rbx,[rbx]
    cmp rax,rbx
    jl min_end_
    mov rax,rbx
    min_end_:
    mov rbx,[rsp+8]
    mov qword[rbx],rax
    ret 16


%macro quot 2
    save
    mov r12,%2
    push r12
    mov r12,%1
    push r12
    call quot_
    load
%endmacro
quot_:
    mov rax,[rsp+8]
    mov rax,[rax]
    mov rbx,[rsp+16]
    mov rbx,[rbx]
    xor rdx,rdx
    idiv rbx
    mov rbx,[rsp+8]
    mov qword[rbx],rax
    ret 16

%macro compare 2
    save
    mov r14,%2
    mov r14,[r14]
    mov r15,%1
    mov r15,[r15]
    cmp r15,r14
    load
%endmacro
%macro init 2
    save
    mov r12,%1
    mov qword[r12],%2
    load
%endmacro

%macro swap 2
    save
    mov r12,%2
    push r12
    mov r12,%1
    push r12
    call swap_
    load
%endmacro
swap_:
    mov rax,[rsp+8]
    mov rax,[rax]
    mov rbx,[rsp+16]
    mov rbx,[rbx]
    mov rcx,rax
    mov rax,rbx
    mov rbx,rcx
    mov rdx,[rsp+8]
    mov qword[rdx],rax
    mov rdx,[rsp+16]
    mov qword[rdx],rbx
    ret 16


%macro sort 1
    save
    mov r12,%1_size
    push r12
    mov r12,%1
    push r12
    call sort_
    load
%endmacro
sort_:
    mov rbx,[rsp+8]
    mov r8,[rsp+16]
    mov r8,[r8]
    mov rcx,1
    sub rbx,8
    cmp r8,1
    je sortloop2end_
    sortloop1_:
        cmp rcx,r8
        je sortloop1end_
        add rcx,1
        mov rax,rcx
        sortwhile1_:
            cmp rax,1
            je sortwhile1end_
            at r12,rbx,rax
            mov r10,[r12]
            shr rax,1
            at r11,rbx,rax
            mov r9,[r11]
            cmp r9,r10
            jge sortwhile1end_
            mov qword[r12],r9
            mov qword[r11],r10
            jmp sortwhile1_
            sortwhile1end_:
        jmp sortloop1_
        sortloop1end_:
    mov rcx,r8
    sortloop2_:
        at r9,rbx,rcx
        at r11,rbx,1
        mov rax,1
        swap r11,r9
        sortwhile2_:
            mov r15,rax
            shl r15,1
            mov r10,r15
            add r10,1
            at r13,rbx,r15
            at r14,rbx,r10
            mov r13,[r13]
            mov r14,[r14]
            cmp r15,rcx
            jge sortwhile2end_
            cmp r10,rcx
            jge swapl_
            cmp r13,r14
            jge swapl_
            jmp swapr_
            swapl_:
                at r9,rbx,rax
                mov r9,[r9]
                cmp r9,r13
                jge sortwhile2end_
                at r14,rbx,rax
                at r13,rbx,r15
                swap r14,r13
                shl rax,1
                jmp sortwhile2_
            swapr_:
                at r9,rbx,rax
                mov r9,[r9]
                cmp r9,r14
                jge sortwhile2end_
                at r14,rbx,rax
                at r13,rbx,r10
                swap r14,r13
                shl rax,1
                add rax,1
                jmp sortwhile2_
            sortwhile2end_:
        sub rcx,1
        cmp rcx,1
        je sortloop2end_
        jmp sortloop2_
        sortloop2end_:
    ret 16
    
%macro reverse 1
    save
    mov r12,%1_size
    push r12
    mov r12,%1
    push r12
    call reverse_
    load
%endmacro
reverse_:
    mov rbx,[rsp+8]
    mov r8,[rsp+16]
    mov r8,[r8]
    mov rcx,0
    mov rdx,r8
    sub rdx,1
    reverseloop_:
        cmp rcx,rdx
        jge reverseloopend_
        at r9,rbx,rcx
        at r10,rbx,rdx
        swap r9,r10
        add rcx,1
        sub rdx,1
        jmp reverseloop_
        reverseloopend_:
    ret 16
    
%macro abs 1
    save
    mov r12,%1
    push r12
    call abs_
    load
%endmacro
abs_:
    mov r8,[rsp+8]
    mov r8,[r8]
    mov r9,1
    shl r9,63
    test r8,r9
    je absskip_
    not r8
    add r8,1
    absskip_:
    mov r10,[rsp+8]
    mov qword[r10],r8
    ret 8

main:
    cin str1
    cin str2
    mov r8,str1
    mov r9,str2
    init ans,0
    compare r8,r9
    jne skip1
    plus ans,n1
    skip1:
    add r8,8
    add r9,8
    compare r8,r9
    jne skip2
    plus ans,n1
    skip2:
    add r8,8
    add r9,8
    compare r8,r9
    jne skip3
    plus ans,n1
    skip3:
    putll ans
    endl
    exit
    

section .data
    n0      dq 0
    n1      dq 1
    n2      dq 2
    n3      dq 3
    n4      dq 4
    n5      dq 5
    n6      dq 6
    n7      dq 7
    n8      dq 8
    n9      dq 9
    n10     dq 10
    MOD1    dq 998244353
    MOD2    dq 1000000007
    INF     dq 4611686016279904256
    YES     dq 'Y','E','S',10
    NO      dq 'N','O',10
    Yes     dq 'Y','e','s',10
    No      dq 'N','o',10
    
section .bss
    str1        resq 1000000
    str1_size   resq 1
    str2        resq 1000000
    str2_size   resq 1
    str3        resq 1000000
    str3_size   resq 1
    tmp         resq 1000000
    a           resq 1
    b           resq 1
    c           resq 1
    d           resq 1
    e           resq 1
    f           resq 1
    g           resq 1
    h           resq 1
    i           resq 1
    j           resq 1
    k           resq 1
    A           resq 1000000
    A_size      resq 1
    ans         resq 10
    ull         resb 20
