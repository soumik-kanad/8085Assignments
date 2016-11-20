;Program for a calculator capable of Addition, Subtraction,
;Multiplication & division
cpu "8085.tbl"
hof "int8"

	org 9000h

	LXI H,9500H
	MVI M,0CH
	LXI H,9501H
	MVI M,0AH
	LXI H,9502H
	MVI M,11H
	LXI H,9503H
	MVI M,0CH
	LXI H,9504h
	MVI M,00H


main:   MVI A,00H
	MVI B,00H
	LXI H,9500H
;convert into bcd
	call 0389h
	mvi B,01h
;call display function
	call 030Eh
	mov A,E
	STA 9801h
	call 030Eh
	mov A,E
	STA 9802h
;wait for user input
	CALL 03BAh
	CPI 00h
	JNZ NOTADD 
	CALL ADDITION 

NOTADD: CPI 01h
	JNZ NOTSUB
	CALL SUBTRACTION

NOTSUB:	CPI 02h
	JNZ NOTMUL
	CALL MULTIPLICATION

NOTMUL: CPI 03h
	JNZ NOTDIV
	CALL DIVISION

NOTDIV: CALL 02beh
	LDA 9803h
	MVI D,00h
	MOV E,A
;wait for user input
	CALL 034Fh
	MVI A,00H
	MVI B,00H
;convert into bcd and display
	CALL 0389h
	CALL 03BAh

	LDA 9804h
	MOV D,A
	MVI E,00h
;wait for user input
	CALL 034Fh
	MVI A,01H
	MVI B,00H
;convert into bcd and display
	CALL 0389h
	CALL 03BAh
	JMP main
	 
ADDITION: LDA 9801h
  	  MOV B,A
  	  LDA 9802h
	  ADD B
	  MVI C,00h
	  JNC ifcarryloop
	  INR C
	  ifcarryloop:STA 9803h
	  MOV A,C
	  STA 9804h
	  RET

SUBTRACTION: LDA 9802h
	     MOV B,A
	     LDA 9801h
  	     SUB B
	     MVI C,00h
	     JNC ifborrowloop
	     INR C
	     ifborrowloop: STA 9803h
	                   MOV A,C
	                  STA 9804h
	                  RET

MULTIPLICATION: LDA 9801h
	        MOV B,A
        	LDA 9802h
	        MOV D,A
	       MVI A,00h

mulLABEL: ADD B
	  DCR D
	  JNZ mulLABEL
	  JNC ifmulloop
	  MVI C,00h
	  INR C

ifmulloop: STA 9803h
	   MOV A,C
	   STA 9804h
       	   RET

DIVISION: LDA 9802h
	  MOV B,A
	  LDA 9801h
	  MVI C,00h

	divloop:  CMP B
		  JC divloop2
 	  	  SUB B
 	  	  INR C
	 	  JMP divloop        

	divloop2:  STA 9804h
		   MOV A,C
	          STA 9803h
	   RET

;routine for delay
delay:  LXI D,9FFFh
dloop:  DCX D
	MOV A,D
	ORA E
	JNZ dloop
	RET

	RST 5

