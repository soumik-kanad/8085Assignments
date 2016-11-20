;When D6 on the input port is low, a program starts to make the LEDs on
;the outport blink one at a time (D0 first then D1, then D2...) cyclically
;with a delay of one second in between. When D5 of the input port is made
;low this programs stops and waits for D6 at the input port to go low and
;commence again. When D2 of the input port is made low the program
;terminates.

cpu "8085.tbl"
hof "int8"

RDKBD: EQU 03BAH
GETCH: EQU 0C12H
org 9200h
	MVI A,8BH			;initial setup
	OUT 43H
	MVI A,80H
	OUT 40H
	MOV D,A				;initial position of light is put in D that is 0th
	
RECE:IN 41H
	ANI 40H
	JNZ CONT			; if the D2 is high then continue
	RST 5
CONT:IN 41H
	ANI 02H			
	JZ ROTA				;if D7 is high then keep rotating
	JMP RECE
	
	

ROTA: MOV A,D			; D is current position of light
	RRC					; right rotate the output signal
	OUT 40H				;blink the light
	MOV D,A
	CALL DELAY
	JMP RECE			; jump to rece to check input 

Delay:
	LXI B,0FFFFH		; set value of delay
DLoop:					;loop decrementing delay
	DCX B
	MOV A,B
	ORA C
	JNZ DLoop			;loop terminates if delay becomes 0
	RET



