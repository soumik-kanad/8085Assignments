;Given just the processor on the kit, is it possible for you to write a
;program to generate a square wave with a time period of one
;second. One should be able to observe the wave on  a CRO. (Hint: Use the
;knowledge gained from the lectures delivered to date).
;IF so Try it out AND also attempt the next two questions -

;i) Write a program to repeatedly display a waveform having the foll.
;pattern
;……__ __ __ | |__| |__ .......
;ii) What is the height (Y-axis) of the waveform? Is it possible to
;increase/decrease it?


cpu "8085.tbl"
hof "int8"

; Load program
org 9000h

;Initial Configuration for output port
MVI A,80H
OUT 43H   ;43H is output control port

;; Amplitude of output can be changed 
;; by changing output high value(0FFH in this case)

Repeat:
	MVI A,00H ; Load initial 
	OUT 40H   ; value of 00H 
	
	CALL Delay
	CALL Delay ; Delay  
	CALL Delay
	
	MVI A,0FFH  ; High output(logical 1)
	OUT 40H

	CALL Delay
	MVI A,00H   ; Low output (logical 0)
	OUT 40H
	
	CALL Delay
	MVI A,0FFH
	OUT 40H
	
	CALL Delay
	JMP Repeat  ; Repeat cycle

; Delay loop for .5 sec
Delay:  
	LXI B,0FFFFH
DLoop:
	DCX B
	MOV A,B
	ORA C
	JNZ DLoop
	RET
	

RST 5