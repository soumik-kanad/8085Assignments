;Assembly Code for Subtraction of 2 8-bit numbers on 8085 processor
cpu "8085.tbl"
hof "int8"

org 9000h

	MVI C,00
;second operand
	LDA 9501h
	MOV B,A
;first operand	
	LDA 9500h
;subtraction
	SUB B
	JNC noborrow
	INR C

noborrow: 	STA 9502h
	MOV A,C
	STA 9503h
	
	RST 5
