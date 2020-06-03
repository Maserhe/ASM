; 顺序结构结构设计
;【例4-35】  在内存X单元存放一个无符号字节数据，编制程序将其拆成两位十六进制数，并存入X+1和X+2单元的低4位，X+1存放高位十六进制数，X+2单元存放低位十六进制数。
;分析：由于8086指令传送数据的最小单位是字节（8位），不能直接传送4位。因此，需要使用逻辑与移位指令。
;源程序如下
	
DATA	SEGMENT
	X		DB		15H
	DB		? , ?
DATA	ENDS

CODE	SEGMENT
		ASSUME    CS: CODE,	DS:DATA
START:
		MOV		AX, DATA	;设置数据段地址
		MOV		DS, AX
		MOV		AL, X		;取数据
		MOV		AH, AL		;暂存 AL 的结果
		MOV		CL, 4
		SHR		AL, CL		;右移至低 4 位
		MOV		X+1, AL		;存结果
		AND		AH, 0FH		;截取低 4 位
		MOV		X+2, AH		;存结果
		MOV		AX, 4C00H	;程序结束
		INT		21H
CODE	ENDS
END 	START
