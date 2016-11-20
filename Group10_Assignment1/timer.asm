;Real-Time Clock: Using the 7-seg LED display on-board (Address & Data
;fields) to display the Hours: Mts: Seconds in decimal.
;Ability to switch between 12 hour format and 24 hour format
cpu "8085.tbl"
hof "int8"

	org 9000h
;get user input for choosing 12 hour or 24 hour format
	mvi B,01H
	call 030Eh
	mov A,E

	STA 9802h
	mvi B,01H
	call 030Eh
	mov A,E

	STA 9801h
	mvi B,01H
	call 030Eh
	mov A,E

	LHLD 9801h
	JMP SEC

START: 	LXI H,0000H

MIN: 	MVI A,00H
SEC: 	PUSH PSW
	PUSH H
	PUSH H
;storing appropropriate values at memory locations 
;for calling display routines
	STA 8FF1h
	MOV D,A
	MOV A,H
	STA 8FF0h
	MOV A,L
	STA 8FEFh
	MOV A,D
	CALL 044CH
	POP H
	CALL 0440H
	CALL DELAY
	CALL DELAY
	POP H
	POP PSW
	ADI 01h
	DAA

	CPI 60h
	JNZ SEC
;if sixty seconds
	MOV A,L
	ADI 01h
	DAA

	MOV L,A
	CPI 60h
;if sixty minutes
	JNZ MIN
	MVI L,00
	MOV A,H
	ADI 01H
	DAA

	MOV H,A
	CPI 24h
;if twenty four hours
	JNZ MIN
	JMP START

;routine for delay
DELAY: LXI B,9FFFh
DLOOP: DCX B
	MOV A,B
	ORA C
	JNZ DLOOP
	RET

INF:	CALL DELAY
	JMP INF

	RST 5
