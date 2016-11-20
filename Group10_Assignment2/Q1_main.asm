;Write a program for the following:
;When an interrupt (to be chosen based on your findings) occurs for the first
;time, it multiplies the values in two known memory location &
;displays the result. When it comes the second time,it divides the two
;numbers & displays the result. Finally when it arrives a third
;time, it adds the previous two results and displays it.

cpu "8085.tbl"
hof "int8"

;; Main program having an infinite loop
;; which waits for interrupts

org 9000h
	
	; Initial configuration for interrupts
	MVI A,0Bh
	SIM
	EI
	
	;initialise choice variable
	MVI A,01h
	STA 9500h

LOOP: INR A
	  JMP LOOP