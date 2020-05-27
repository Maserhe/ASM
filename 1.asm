assume  cs:code , ds:data , es:table 

data segment
    db '1975' ,'1976' ,'1977' ,'1978' ,'1979' ,'1980' ,'1981' ,'1982' ,'1983'
    db '1984' ,'1985' ,'1986' ,'1987' ,'1988' ,'1989' ,'1990' ,'1991' ,'1992'
    db '1993' ,'1994' ,'1995' ; 4 * 21 共 84 个 字节

    dd 16,22,382,1356,2563,8000,160000,524548,54545546,848484,26266444,6654564,662,64645,654654,654654,26226,446451,6465454,22, 89498
    ;  dword   4 * 21 共 84 个 字节  工资  

    dw 16,22,382,1356,2563,8000,16,22,382,1356,2563,8000,16,22,382,1356,2563,8000,16,22,382
    ;  word 2 * 21 共 42 个字节  雇员数

data ends

table segment 
    dp 21 dup('year sumn ne ??')
table ends
code segment
start:
    mov ax , data
    mov ds , ax

    mov ax table
    mov es ax

    xor bx , bx  ; 异或 置零
    xor si , si
    xor di , di
    
    mov cx , 21  ;循环次数
s: 
    mov ax , [bx] ; 搬 年份 开始 , 年份是双字  需要搬 两次
    mov es:[di] ax
    mov ax , [bx + 2]
    mov es:[di + 2],ax


    mov byte ptr es:[di + 4 ], 20h ; 搬空格 ,空格  为一个字节

    mov ax, [bx + 84]  ; 般工资
    mov es:[di + 5], ax
    mov ax, [bx + 86]
    mov es:[di + 7] , ax

    mov byte ptr es:[di + 9 ], 20h ; 搬空格 ,空格  为一个字节

    mov ax, [si + 168] ; 搬雇员
    mov es:[di+ 10]

    mov byte ptr es:[di + 12 ], 20h ; 搬空格 ,空格  为一个字节

    mov ax , [bx + 84 ] ; 计算工资
    mov dx , [bx + 86 ]

    div  word ptr ds:[si + 168] ; 计算人均 收入

    mov es:[di + 13] , ax ; 存结果

    mov byte ptr es:[di + 0fh]  , 20h 

    add di , 16 
    add si , 2
    add bx , 4

loop s

    mov ax , 4c00h
    int 21h
code ends

end start