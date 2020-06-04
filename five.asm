;输入/输出与中断程序设计
; 在屏幕上输入 一 10 个字符串， 换行显示字符串使其以闪亮显示, 输入字符变另一种颜色


;在屏幕中间显示welcome to masm! 
; 80 * 25 每行 25 * 2 = 160 字节
; 行偏移 12 ，13， 14 行
;DATA segment
;    dw 3840; 最后 25 行  首个字符偏移的量 ， 字符有两个 , 2字节


DATA segment
    STK DB 10 DUP(?)        ;存储字符的  ASCALL 码信息 ，颜色和闪亮设置为固定值 0F9H
DATA ends

code segment
    assume cs:code ,DS:DATA 
start:
   
    MOV AX , DATA
    MOV DS , AX

    MOV AX , 0B800H         ;由资料可知从这里的内存开始 可以显示在 屏幕上 修改这个内存上的内容就行了
    MOV ES , AX

    MOV SI , 0              ;指向数据段 段首
    MOV CX , 10             ;循环次数
                            
S:
    MOV AH, 01H;            ;准备输入信息
    INT 21H;
    CMP AL , 0DH            ;判断是否为回车
    jz  Print               ;如果回车我就，输出，退出程序
    MOV DS:[SI] , AL;       ;存储 字符的 ASCALL 码信息
    ADD SI ,1               ;指向下一个字符需要存放内存的偏移量
    LOOP S

    MOV DI , 0              ;指向数据段 段首
    XOR BX , BX             ;保存列偏移量
          
Print: 
    CMP SI , DI             ;跳出循环判断
    JZ EXIT
    MOV AL , DS:[DI]        ;取出字符信息
    MOV ES:[3840 + BX] , AL ;3840为行偏移量 ， bx 为列偏移量  ， 由资料可知，低位 存字符  ASCALL信息
    MOV byte ptr ES:[3840 + BX + 1 ] , 0f9H;高位存 字符的 颜色闪亮信息
    ADD BX , 2              ;一个 带闪亮颜色的 字符 ， 占用 一个 字 大小  ，不是一个字节
    ADD DI , 1
    JMP Print               ;继续循环    
EXIT:                       ;退出
    mov ax, 4c00h
    int 21h
code ends
end start