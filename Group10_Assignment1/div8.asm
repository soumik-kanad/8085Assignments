;Assembly Code for Division of 2 8-bit numbers on 8085 processor
cpu "8085.tbl"
hof "int8"

	org 9000h
	MVI C,00h
	LDA 9501h
	MOV B,A
	LDA 9500h

divloop: CMP B
	JC loop
 	SUB B
 	INR C
	JMP divloop        

loop: STA 9503h
	MOV A,C
	STA 9502h
	RST 5	
