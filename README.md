# tz_atcoder_assembly

Levixi

### latest

---
```

```
---
```

```
---
```

```
---
```

```
---
```

```
---
```

```
---
```

```
---
```
abc115_a.asm

section .data
    fmt_i db "%d", 0        ; scanf用の整数フォーマット文字列
    fmt_s db "%s", 0        ; printf用の文字列フォーマット文字列
    christmas db "Christmas", 0  ; "Christmas"文字列
    eve db " Eve", 0        ; " Eve"文字列
    buffer times 1000 db 0  ; 結果を格納するバッファ（1000バイト）

section .bss  
    n resq 1                ; 入力を格納する8バイト（64ビット）の領域

section .text
    extern printf, scanf, putchar  ; 外部関数の宣言
    global main

main:
    push rbp                ; スタックフレームの設定開始
    mov rbp, rsp

    ; 入力を読み取る (D=int(input()))
    lea rdi, [rel fmt_i]    ; scanf の第1引数：フォーマット文字列
    lea rsi, [rel n]        ; scanf の第2引数：入力を格納する変数のアドレス
    xor eax, eax            ; AL レジスタ（可変引数の数）をクリア
    call scanf wrt ..plt    ; scanf 関数呼び出し

    ; 25 - D を計算
    mov eax, 25             ; eax に 25 をセット
    sub eax, [rel n]        ; eax から入力値を引く
    mov ecx, eax            ; 結果を ecx に移動（ループカウンタとして使用）
    
    ; "Christmas"をバッファにコピー
    lea rsi, [rel christmas] ; コピー元の文字列アドレス
    lea rdi, [rel buffer]    ; コピー先のバッファアドレス
    call strcpy              ; strcpy 関数呼び出し

    ; " Eve"を繰り返し追加 (" Eve"*(25-D))
    test ecx, ecx           ; ecx が 0 以下かチェック
    jle print_result        ; 0以下なら直接出力へジャンプ

add_eve:
    lea rsi, [rel eve]      ; 追加する " Eve" 文字列のアドレス
    lea rdi, [rel buffer]   ; 追加先バッファのアドレス
    call strcat             ; strcat 関数呼び出し
    loop add_eve            ; ecx をデクリメントし、0でなければ add_eve にジャンプ

print_result:
    ; 結果を出力
    lea rdi, [rel fmt_s]    ; printf の第1引数：フォーマット文字列
    lea rsi, [rel buffer]   ; printf の第2引数：出力する文字列
    xor eax, eax            ; AL レジスタ（可変引数の数）をクリア
    call printf wrt ..plt   ; printf 関数呼び出し

    ; 改行を出力
    mov rdi, 10             ; '\n'の ASCII コード
    call putchar wrt ..plt  ; putchar 関数呼び出し

    xor eax, eax            ; 戻り値を 0 に設定
    leave                   ; スタックフレームの解放
    ret                     ; main 関数から戻る

; 単純なstrcpy関数
strcpy:
    mov al, [rsi]           ; ソース文字列から1文字読み込み
    mov [rdi], al           ; デスティネーション文字列に書き込み
    inc rsi                 ; ソースポインタを進める
    inc rdi                 ; デスティネーションポインタを進める
    test al, al             ; ヌル文字（文字列の終端）かチェック
    jnz strcpy              ; ヌル文字でなければ繰り返し
    ret                     ; 関数から戻る

; 単純なstrcat関数
strcat:
    ; 終端を見つける
    mov al, [rdi]           ; デスティネーション文字列から1文字読み込み
    test al, al             ; ヌル文字かチェック
    jz start_cat            ; ヌル文字なら連結開始
    inc rdi                 ; ヌル文字でなければポインタを進める
    jmp strcat              ; 繰り返し

start_cat:
    mov al, [rsi]           ; ソース文字列から1文字読み込み
    mov [rdi], al           ; デスティネーション文字列に書き込み
    inc rsi                 ; ソースポインタを進める
    inc rdi                 ; デスティネーションポインタを進める
    test al, al             ; ヌル文字かチェック
    jnz start_cat           ; ヌル文字でなければ繰り返し
    ret                     ; 関数から戻る
```
---

