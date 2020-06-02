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
;-------------------读取-------------------
read:
MOV AH, 01H;
INT 21H;
CMP AL, 0DH;-------------------判断是否输入回车换行-------------------
JZ do;
CMP AL, 0AH;
JZ do;
MOV BL, AL;
AND BL, 0FH;-------------------将输入的ASCII码转为二进制-------------------
MOV AX, DX;-------------------DX存输入的二进制数-------------------
MOV DX, 0AH;
MUL DX;-------------------将结果乘以10再加上输入的数-------------------
ADD AX, BX;
MOV DX, AX;-------------------将新结果仍然放到DX中-------------------
LOOP read;
;-------------------处理,将结果除以16并将余数压栈------------------
do:
MOV AX, DX;
loopDo:
AND DX, 0;
MOV BX, 10H;
DIV BX;
PUSH DX;
MOV CX, AX;-------------------把除后的数放到CX判断是否为0-------------------
JCXZ showEnter;
JMP loopDo;
;-------------------显示回车换行-------------------
showEnter:
MOV DX, 0AH;
MOV AH, 02H;
INT 21H;
MOV DX, 0DH;
INT 21H;
;-------------------显示结果-------------------
show:
POP DX;
CMP DX, 9;-------------------大于9的数转换成ASCII码时要加37H-------------------
JBE abcdef;
ADD DX, 7H;
abcdef:
ADD DX, 30H;
MOV AH, 02H;
INT 21H;
CMP SP, 16;
JZ exit;
LOOP show;
;-------------------结束-------------------
exit:
MOV AX, 4C00H;
INT 21H;
codeseg ENDS
END start
