;Now that you have been able to manipulate input and output try
;simulating an elevator whose switches form the bits of the input port
;while those of the output port symbolize the eight floors. Requests
;(multiple too) could come from any floor on the input (port) side.
;Accordingly display how the elevator ascends or descends the floors and
;services the resp. floors and brings people back to the ground floor.

cpu "8085.tbl"
hof "int8"


org 9200h
	MVI A,8BH			;initial setup
	OUT 43H
	MVI A,01H			;inital position of lift is 0
	OUT 40H
	MOV D,A				; D is current position of lift, now 0
	MVI E,01H			; E is flag to indicate that 1 means go up
	
RECE:   IN 41H
	ANA D
	JNZ RECE			; if input is current position then no need, take input again
	MOV A,E
	CPI 01H
	JZ UPWARD			; go upward if flag E is 1
DOWN:	MOV A,D			
	CPI 01H				
	JZ GROUNDFLOOR		;groundfloor if flag is 1 means cant go below.
GODOWN:	MOV A,D
	RRC					;right shift the lift or coming down
	OUT 40H
	MOV D,A
	CALL DELAY
	JMP RECE			;return to RECE to check the new inputs again
GROUNDFLOOR:MVI E,01H
	JMP RECE			;go to initial setup again
	
UPWARD: IN 41H
	CMP D
	JNC GOUP			;if input is greater thn D then go up
	MVI E,00H
	JMP RECE

GOUP:MOV A,D
	RLC					;left shift the lift or move upward
	OUT 40H
	MOV D,A
	CALL DELAY
	JMP RECE			;return to RECE to check the new inputs again
 	

	
	



Delay:
	LXI B,0FFFFH		;set value of delay
DLoop:					; loop to decrement the delay
	DCX B
	MOV A,B
	ORA C
	JNZ DLoop			;return when delay is 0
	RET
