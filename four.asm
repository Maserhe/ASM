;子程序结构设计
;【例7-4】 有三个班级，学生人数分别存储于内存NUB1，NUB2和NUB3单元，各班同学某门课程的成绩分别存放于内存S1，S2和S3开始的单元，编制程序，分别统计各班课程的平均成绩，存放于E1，E2和E3单元。
;分析：首先可以看到，求某门课程平均成绩的任务是要重复进行三次，于是我们把它编制成子程序。由于入口参数需要传递很多的数据，所以，可采用地址表传递参数，传递数据首地址和数据个数，而出口参数较少，可放在寄存器中。
;按上面的分析，其子程序说明文件如下：
;（1）子程序名：AVER；
;（2）子程序功能：统计某门课程的平均成绩；
;（3）入口条件：某门课程的首地址在SI中，数据个数在CL中；
;（4）出口条件：某班某门课程平均成绩在AL中；
;（5）受影响的寄存器：AX、SI、F。
;	子程序清单如下：
;；EX7-4S
AVER 	PROC	NEAR
        MOV	BL，CL
        XOR	AX，AX
LOOP1：  	
        ADD	AL，[SI]
        ADC	AH，0
        INC 	SI
        DEC    CL
        JNZ     LOOP1
        DIV     BL
        RET
AVER    ENDP
;主程序把数组首地址放入SI，数据个数放入CL中，即可调用子程序，然后，从AL中获取平均值。
;主程序清单如下：
;	；EX7-4M
SSEG    	SEGMENT STACK
    STK    DB    50 DUP(0)
SSEG    	ENDS

DSEG    SEGMENT
    S1    DB    60，80，70
    S2    DB    40，50，60，70
    S3    DB    80，90
    NUB1  DB    3
    NUB2  DB    4
    NUB3  DB    2
    E1    DB    0
    E2    DB    0
    E3    DB    0
DSEG    ENDS

CSEG    	SEGMENT
    ASSUME  SS:SSEG,DS:DSEG,CS:CSEG
START:  	
    MOV	    AX, SSEG
    MOV     SS, AX
    MOV     AX, DSEG
    MOV     DS, AX
    MOV	    SP, SIZE STK

    LEA		SI, S1
    MOV     CL, NUB1
    CALL    AVER
    MOV     [E1], AL
    MOV     CL, NUB2
    CALL    AVER
    MOV     [E2], AL
    MOV     CL, NUB3
    CALL  	AVER
    MOV     [E3], AL
    MOV	    AH, 4CH
    INT     21H
CSEG    	ENDS
END     START
