assume cs:code , ds:data
;在屏幕中间显示welcome to masm! 
; 80 * 25 每行 25 * 2 = 160 字节
; 行偏移 12 ，13， 14 行

data segment
    dw 1920, 2080, 2240 , 64 ; 有8字节
    db 'welcome to masm!' ; 有 16 个字节

    db 82H , 0acH , 0f9H ;字体颜色

data ends

code segment
start:
    mov ax , data
    mov ds , ax
    
    mov ax , 0b800h ; 从这里的内存开始 可以显示在 屏幕上 重要修改这个内存上的信息就行了
    mov es , ax

    mov cx , 3 
    xor si, si
    xor di, di
    
s1: 
    mov ax , 3
    sub ax , cx

    mov si , ax ; 记录字符颜色
    mov ah , [si + 24] ; 

    mov di , ds:[6] ; 记录 列偏移 64 固定
    mov bp , ds:[si] ; 记录 行偏移  

    mov si , cx
    mov bx , 0

    mov cx , 16
s2: 
    mov al , ds:[bx + 8]
    mov es:[bp + di] , al
    mov es:[bp + di + 1] ,ah
    inc bx 
    add di , 2 

    loop s2
    
    mov cx , si 
    
    loop s1

    mov ax, 4c00h
    int 21h
code ends
end start

