;输入/输出与中断程序设计
; 在屏幕上输入 一 10 个字符串， 使其以闪亮显示, 输入字符变另一种颜色


;在屏幕中间显示welcome to masm! 
; 80 * 25 每行 25 * 2 = 160 字节
; 行偏移 12 ，13， 14 行
DATA segment
    dw 3840; 最后 25 行  首个字符偏移的量 ， 字符有两个 , 2字节
    DATA ends

code segment
    assume cs:code ,DS:DATA
start:
   
    MOV AX , DATA
    MOV DS , AX

    MOV AX , 0B800H  ;从这里的内存开始 可以显示在 屏幕上 重要修改这个内存上的信息就行了
    MOV ES , AX

    MOV SI , 0
    MOV CX , 10 
    MOV AH , 82H
    MOV BP , 3840
S:
    MOV AH, 01H;
    INT 21H;
    MOV ES:[SI + 3840] , AX 
    ADD SI , 2
    LOOP S

    mov ax, 4c00h
    int 21h
code ends
end start

