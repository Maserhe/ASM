assume cs:code , ds:data

; 80 * 25 每行 25 * 2 = 160 字节
; 行偏移 12 ，13， 14 行

data segment
    dw 1920, 2080, 2240 , 64 ; 有8字节
    db 'welcome to masm!' ; 有 16 个字节

    db 82H , 0acH , 0f9H

data ends

code segment
start:
    mov ax , data
    mov ds , ax
    
    mov ax , 0b800h ; 从这里的内存开始 可以显示在 屏幕上 重要修改这个内存上的信息就行了
    mov es , ax

    mov cx , 3
    xor di , di
    xor si , si
s1:
    mov ax , di
    mov bl , 2
    div bl

    mov si , ax  ; si 从 0 ，1，2
    mov ah , [si + 24]

    mov si , ds:[6] ; 指定 列偏移
    mov bp , [di]  ;  指定 行 偏移

    mov dx , cx ;记录已经外层循环 的 cx
    mov bx , 0

    mov cx , 16
s2:
    mov al,[bx + 8]   ; 'welcom 的 起始偏移 '
    mov es:[bp + si], al ; 低四位存 字符
    mov es:[bp + si + 1 ],ah ; 高四位 存 颜色 信息
    inc bx  
    add si , 2 
    loop s2

    mov cx , dx 
    add di , 2
    loop s1

    mov ax, 4c00h
    int 21h
code ends
end start

