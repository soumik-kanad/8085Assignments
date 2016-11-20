;Assembly Code for Addition of 2 8-bit numbers on 8085 processor 
cpu "8085.tbl"
hof "int8"

org 9000h

	MVI C,00h
;get first operand
	LDA 9500h
	MOV B,A
;get second operand
	LDA 9501h
;perform addition
	ADD B
	JNC NOCARRY
	INR C

NOCARRY: 	STA 9502h
	MOV A,C
	STA 9503h

	RST 5
