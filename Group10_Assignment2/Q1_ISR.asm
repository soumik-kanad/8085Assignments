cpu "8085.tbl"
hof "int8"

org 9200h
	
	;Push initial content of accum and flags to stack
	PUSH PSW

	;Take choice variable from memory 
	LDA 9500h
	CPI 01h
	JNZ NotOne ; If not multiplication

	;Multiply the two numbers
	LDA 8500h
	MOV B,A
	LDA 8501h
	MOV C,A
	CPI 00h
	JZ Multiplyzero

	XRA A
	MulLoop: ADD B
			 DCR C
			 JNZ MulLoop
	
	;Store result
	Multiplyzero:	STA 8502h
					STA 8FF1h
	
	;Display result
					call 044Ch ;Points to data display
					MVI A,02h
					JMP endISR

	NotOne:CPI 02h
	JNZ nottwo
	
	;Divide the two numbers

	MVI C,00h
	LDA 8500h
	MOV B,A
	LDA 8501h
	divloop2: CMP B
	JC divloop1
	SUB B
	INR C
	JMP divloop2
	divloop1: MOV A,C
	STA 8503h
	STA 8FF1h
	call 044Ch
	MVI A,03h
	JMP endISR
	

	nottwo: 
	; Add the two results
	LDA 8502h
	MOV B,A
	LDA 8503H
	ADD B
	STA 8504h
	STA 8FF1h
	call 044Ch
	MVI A,01h


	endISR: STA 9500h ;End Input
		CALL DELAY
		MVI A,1Bh
		SIM
		EI
		POP PSW   ;Retrieve previous states
		RET


;Standard implementation for delay
DELAY: LXI D,0FFFFh
DLOOP: DCX D
	MOV A,D
	ORA E
	JNZ DLOOP
	RET