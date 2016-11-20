;Assembly Code for Addition of 2 16-bit numbers on 8085 processor
cpu "8085.tbl"
hof "int8"

org 9000h

;load first operand
	LHLD 9500H
	XCHG 
;load second operand
	LHLD 9502H
	MOV A,E
;add lower bits
	ADD L
	MOV L,A
	MOV A,D
;add with carry higher bits
	ADC H
	MOV H,A
	SHLD 9504H

	RST 5
