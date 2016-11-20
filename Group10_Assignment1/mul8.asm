;Assembly Code for Multiplication of 2 8-bit numbers on 8085 processor
cpu "8085.tbl"
hof "int8"

	org 9000h

	MVI C,00h
;load first operand
	LDA 9500h
	MOV B,A
;load second operand
	LDA 9501h
	MOV D,A	
	MVI A,00h

;loop for repetitive addition
mulloop: 	ADD B
	DCR D
	JNZ mulloop
	JNC nocarry
	INR C

nocarry: 	STA 9502h
	MOV A,C
	STA 9503h 
	
	RST 5
