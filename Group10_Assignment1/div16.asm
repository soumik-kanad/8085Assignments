;Assembly Code for Division of 2 16-bit numbers on 8085 processor
cpu "8085.tbl"
hof "int8"

org 9000h

	LXI B,0000H
	LHLD 9502H
	XCHG
	LHLD 9500H

DIVLOOP: MOV A,L
	SUB E
	MOV L,A
	MOV A,H
	SBB D
	MOV H,A
	JC FINISHED
	
	INX B
	JMP DIVLOOP

FINISHED: DAD D
	SHLD 9506H
	MOV L,B
	MOV H,C
	SHLD 9504H

RST 5
