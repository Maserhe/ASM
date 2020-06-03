;分支结构程序设计
;【例5-2】计算  
;        X+5       （10＜X≤20）
;        
;         X+10      （20＜X＜30）
        
;          X          其它

;其中x、y均为带符号字节数
 
;图5-3  例5-2程序流程图
;源程序设计如下：
;   ；EX5-2
DATA    SEGMENT
    X      DB	 15
    Y      DB     ?
DATA    ENDS

CODE    SEGMENT   
         	ASSUME     CS:CODE , DS: DATA
START:
    MOV  AX , DATA
    MOV  DS , AX
    MOV  AL , X		    ;取X的值
    CMP  AL ,10		    ;AL的值与10比较，影响标志位
    JLE    L2 	   		;AL≤10转移
    CMP   AL ,20		;AL的值与20比较，影响标志位
    JLE    L1 	   		;AL≤20转移
    CMP   AL ,30		;AL的值与30比较，影响标志位
    JGE    L2     		;AL≥30转移
    ADD   AL ,10		;AL← (AL+10)
    JMP    L2
    L1:     ADD   AL , 5		;AL←（AL+5）
    L2:     MOV    Y  , AL		;保存结果
    MOV   AH ,4CH
    INT  	21H
CODE   ENDS
END  START

