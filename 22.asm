CODES  SEGMENT    
 
START
 
        MOV     AX , 21h
 
        MOV   bx ,  AX
        
        MOV AX   4C00H        
        INT 21H
 
CODES  ENDS  
 
    END  START    