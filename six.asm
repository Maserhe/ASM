ASSUME CS:codeseg, SS:stackseg
stackseg SEGMENT
DB 16 DUP(?);
stackseg ENDS
codeseg SEGMENT
start:
    MOV AX, stackseg;
    MOV SS, AX;
    MOV SP, 16;
    AND BX, 0;
    AND DX, 0;
    MOV CX, 5;

read:
    MOV AH, 01H;
    INT 21H;
    CMP AL, 0DH;        判断是否为回车
    JZ do;
   
    MOV BL, AL;
    AND BL, 0FH;        将输入的ASCII码转为二进制 即减去48，或者写SUB BL, 30H
    MOV AX, DX;         DX存已经输入的二进制数和，不包含这次输入
    MOV DX, 0AH;
    MUL DX;             将结果乘以10再加上输入的数
    ADD AX, BX;
    MOV DX, AX;         将新结果仍然放到DX中
LOOP read;
                       

do:;                    处理,将结果除以16并将余数压栈
    MOV AX, DX;         除数AX

loopDo:
    AND DX, 0;          清零
    MOV BX, 10H;        除以16 ,余数 DX 压栈
    DIV BX;             
    PUSH DX;
    MOV CX, AX;         把除后的数放到CX判断是否为0 ,除尽就输出
    JCXZ showEnter;     跳转输出窗口
    JMP loopDo;         没有出尽继续除

showEnter:;             显示回车换行              
    MOV DX, 0AH;
    MOV AH, 02H;
    INT 21H;
    MOV DX, 0DH;
    INT 21H;
    
show:;                  显示结果
    POP DX;
    CMP DX, 9;          大于9的数转换成ASCII码时要加37H 即加 
    JBE abcdef;         小于等于 则跳到下面 加30H
    ADD DX, 7H;         abcdef先加7H  下面再加 30H

abcdef:
    ADD DX, 30H;        如果不是跳转过来的一共加了37H ，否则加30H
    MOV AH, 02H;        
    INT 21H;
    CMP SP, 16;     
    JZ exit;
    LOOP show;

exit:;                  结束
    MOV AX, 4C00H;
    INT 21H;

codeseg ENDS
END start
