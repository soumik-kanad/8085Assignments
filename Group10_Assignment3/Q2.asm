;HuAngry Birds Ver 0.000
;Imagine a program that makes a couple of random LEDs on the LCI card to
;light up (while others are OFF) momentarily. If the LED#4 & 07 were lit up
;then you need to press the keys 4 & 7 immediately to feed these LED-bird
;within the very limited time for which the LEDs are ON. If you do so you
;get some points displayed on the screen. If you don’t you get penalties.
;The same goes for other LED-birds. You get 5 chances to feed these
;LED-birds. Speed of blinking, etc. could be adjusted. If the rewards
;accumulated crosses a certain mark you graduate the next level. But what’s
;the next level? Imagine and program a more complex task to be done by the
;gamer.

cpu "8085.tbl"
hof "int8"



org 9200h
;setting up mode of operation of 8255 in mode 0
		MVI A,8BH
		OUT 43H	

		MVI H,05H ; number of turns in one level
;SCORE STORED AT 8000H
		MVI A,00H
		STA 8000H
;LEVEL STORED AT 8001H
		MVI A,00H
		STA 8001H

CALL DISPLAYSCORE

;CHOOSE WHICH BLOCK TO RUN LEVEL1 OR LEVEL2
levelchoose: LDA 8001H
		CPI 00H
		JZ LEVEL1
		CPI 01H
		JZ LEVEL2
		jmp gameover



level1:

;code to generate a random number based on codepress
		MVI B,00H
RAND1:
		MOV A,B
		ADI 01H
		MOV B,A
		IN 31H
		ANI 07H
		JZ RAND1
		MVI A,40H
		OUT 31H
		IN 30H
		MOV A,B
		ANI 07H
		STA 9000H

;code to generate a random number based on codepress
		MVI B,00H
		RAND2:
		MOV A,B
		ADI 01H
		MOV B,A
		IN 31H
		ANI 07H
		JZ RAND2
		MVI A,40H
		OUT 31H
		IN 30H
		MOV A,B
		ANI 07H
		STA 9001H
; CHECK IF SAME
		LDA 9000H
		MOV B,A
		LDA 9001H
		CMP B
		JNZ NOTEQUAL
		MVI A,01H
		MVI B,04H
		STA 9000H
		MOV A,B
		STA 9001H



NOTEQUAL: MVI B,01H
		LDA 9000H
		MOV C,A
		ADI 00H
		JZ END1

;convert the random numbers into one bit form

CONV1:
		MOV A,B
		RLC
		MOV B,A
		MOV A,C
		DCR A
		MOV C,A
		JNZ CONV1 
END1:
		MOV D,B

		MVI B,01H
		LDA 9001H
		MOV C,A
		ADI 00H
		JZ END2
CONV2:
		MOV A,B
		RLC
		MOV B,A
		MOV A,C
		DCR A
		MOV C,A
		JNZ CONV2 
END2:
		MOV A,B
		ORA D
		STA 9002H
		OUT 40H
		JMP INPUTSTART









LEVEL2:

;generate three random numbers

		MVI B,00H
L2RAND1:
		MOV A,B
		ADI 01H
		MOV B,A
		IN 31H
		ANI 07H
		JZ L2RAND1
		MVI A,40H
		OUT 31H
		IN 30H
		MOV A,B
		ANI 07H
		STA 9000H

		MVI B,00H
L2RAND2:
		MOV A,B
		ADI 01H
		MOV B,A
		IN 31H
		ANI 07H
		JZ L2RAND2
		MVI A,40H
		OUT 31H
		IN 30H
		MOV A,B
		ANI 07H
		STA 9001H


		MVI B,00H
L2RAND3:
		MOV A,B
		ADI 01H
		MOV B,A
		IN 31H
		ANI 07H
		JZ L2RAND3
		MVI A,40H
		OUT 31H
		IN 30H
		MOV A,B
		ANI 07H
		STA 9003H


;CHECK IF SAME

		LDA 9000H
		MOV B,A
		LDA 9001H
		CMP B
		JZ L2EQUAL

		LDA 9001H
		MOV B,A
		LDA 9003H
		CMP B
		JZ L2EQUAL

		LDA 9000H
		MOV B,A
		LDA 9001H
		CMP B
		JZ L2EQUAL
		JMP L2NOTEQUAL

L2EQUAL:MVI A,01H
		STA 9000H
		MVI A,02H
		STA 9001H
		MVI A,05H
		STA 9003H



L2NOTEQUAL: MVI B,01H
		LDA 9000H
		MOV C,A
		ADI 00H
		JZ L2END1

;converting the random numbers into one bit form

L2CONV1:
		MOV A,B
		RLC
		MOV B,A
		MOV A,C
		DCR A
		MOV C,A
		JNZ L2CONV1 
L2END1:
		MOV A,B
		STA 9000H

		MVI B,01H
		LDA 9001H
		MOV C,A
		ADI 00H
		JZ L2END2
L2CONV2:
		MOV A,B
		RLC
		MOV B,A
		MOV A,C
		DCR A
		MOV C,A
		JNZ L2CONV2 
L2END2:
		MOV A,B
		STA 9001H

		MVI B,01H
		LDA 9001H
		MOV C,A
		ADI 00H
		JZ L2END3
L2CONV3:
		MOV A,B
		RLC
		MOV B,A
		MOV A,C
		DCR A
		MOV C,A
		JNZ L2CONV3 
L2END3:
		MOV A,B
		STA 9003H
;store the converted form in memory
		LDA 9000H
		MOV C,A
		LDA 9001H
		MOV B,A
		LDA 9003H
		ORA B
		ORA C

		STA 9002H
		OUT 40H
		JMP INPUTSTART












INPUTSTART: LXI B,0FFFFH
INPUT1:
		DCX B
		MOV A,B
		ORA C
		JZ TIMEOVER
		IN 31H
		ANI 07H
		JZ INPUT1
		MVI A,40H
		OUT 31H
		IN 30H
		JMP GOTINPUT
;user did not press input in time
TIMEOVER: LDA 8000H
		CPI 00H
		JNZ DECSCORE
		JMP checkgameover
;decreasing score
DECSCORE: LDA 8000H
		SUI 01H
		STA 8000H
		CALL DISPLAYSCORE
		JMP checkgameover
;user pressed input in time
GOTINPUT: MVI B,01H
		MOV C,A
		ADI 00H
		JZ END3
;convert input into one bit form
CONV3:
		MOV A,B
		RLC
		MOV B,A
		MOV A,C
		DCR A
		MOV C,A
		JNZ CONV3 
END3:
		MOV D,B

;one bit form in D
		LDA 9002H
		XRA D
		MOV B,A
		LDA 9002H
		CMP B
		JNC CORRECT
		LDA 8000H
		CPI 00H
		JNZ DECSCORE
		JMP checkgameover        


;user input was correct for at least one led
CORRECT:MOV A,B
		STA 9002H ;have to update led
		OUT 40H
		LDA 8000H
		ADD H
		STA 8000H;have to update score
		CALL DISPLAYSCORE
		JMP checkgameover

;check if game is over
checkgameover:LDA 9002H
		CPI 00H
		JNZ NOTSUCCESS
		LDA 8001H
		ADI 01H
		STA 8001H
		MVI H,05H
		JMP levelchoose

;if not success
NOTSUCCESS:MOV A,H
		DCR A
		JZ GAMEOVER
		MOV H,A
		jmp INPUTSTART



;game is over
GAMEOVER:
		MVI A,0FFH
		OUT 40H
		CALL DELAY
		CALL DELAY
		CALL DELAY
		RST 5



;routine for displaying score
DISPLAYSCORE:
		STA 8FF1H
		PUSH PSW
		PUSH B
		PUSH D
		PUSH H
		CALL 044CH
		POP H
		POP D
		POP B
		POP PSW
		RET

;routine for generating delay
Delay:
		LXI B,0FFFFH
DLoop:
		DCX B
		MOV A,B
		ORA C
		JNZ DLoop
		RET
