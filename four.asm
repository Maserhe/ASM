;主程序

StA       SEGMENT  STACK
    STK DB 20 DUP(0);
STA       ENDS

DATA		SEGMENT
    PX			DW		6962;118
    PY			DW		1728;72
    RLT			DW		?   ;13
DATA		ENDS

CODE		SEGMENT
    ASSUME CS:CODE , SS:STA , DS:DATA
START:

    MOV	AX , DATA
    MOV	DS , AX
    MOV	AX , STA
    MOV	SS , AX
    MOV	SP , SIZE STK
    MOV	DX , PX		    ;取X
    ADD	DX , DX		    ;计算 2X
    CALL	ROOT1		;调用开平方子程序
    PUSH	DX			;暂存结果
    MOV	DX , PY		    ;取 Y 
    MOV	AX , DX		    ;计算 3Y
    ADD	DX , DX
    ADD	DX , AX
    CALL	ROOT1		;调用开平方子程序
    POP		AX			;取出 
    ADD	AX , DX		    ;计算 
    PUSH	AX			;暂存结果
    MOV	DX , 169
    CALL	ROOT1
    POP		AX			;取出中间结果
    ADD	AX , DX		    ;计算最终结果
    MOV	RLT , AX	    ;保存结果
    MOV	AH , 4CH
    INT		21H

ROOT1:		            ;子程序开始

    MOV	BX , 1		    ;形成奇数 , 初始值为 
    XOR	CX , CX		    ;减奇数个数寄存器清 0
SQRT1:    
    AND	DX , DX 	    ;置标志（测试被开方数）
    JZ	    SQRT2		;被开方数为0  , 转存结果
    SUB		DX , BX		;被开方数减去奇数
    INC		CX			;记载减奇数的个数
    ADD	BX , 2		    ;形成下一个奇数
	JMP		SQRT1		;继续
SQRT2:    	
    MOV	DX , CX		    ;存平方根
	RET					;返回


CODE	    ENDS
END START


