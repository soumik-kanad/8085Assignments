;Assembly Code for Multiplication of 2 16-bit numbers on 8085 processor
cpu "8085.tbl"
hof "int8"

	org 9000h
;load first operand
	LHLD 9500h
	SPHL
;load second operand
	LHLD 9502H
	XCHG
	LXI H,0000h
	LXI B,0000h

NEXT: 	DAD SP
	JNC AHEAD
	INX B

AHEAD:  DCX D
	MOV A,E
	ORA D
	JNZ NEXT
	SHLD 9506h
	MOV L,B
	MOV H,C
	SHLD 9504h
	
	RST 5
