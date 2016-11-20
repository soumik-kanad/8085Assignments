;Assembly Code for Subtraction of 2 16-bit numbers on 8085 processor
cpu "8085.tbl"
hof "int8"

org 9000h

;load first operand
	LHLD 9500H
	XCHG 
;load second operand
	LHLD 9502H
	MOV A,E
;subtract lower byte
	SUB L
	MOV L,A
	MOV A,D
;subtract higher byte with borrow
	SBB H
	MVI C,00H
	JNC noborrow
	INR C

noborrow:	MOV H,A
	SHLD 9504H
	MOV A,C
	STA 9506H
	
	RST 5
