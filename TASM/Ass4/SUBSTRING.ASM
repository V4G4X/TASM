PRINT_STR MACRO STR
LEA DX,STR
MOV AH,09H
INT 21H
ENDM

SCAN_STR MACRO STR
MOV DX,OFFSET STR
MOV AH,0AH
INT 21H
ENDM

PRINTC_DL MACRO
MOV AH,02H
INT 21H
ENDM

FINISH	MACRO
MOV AH,4CH
INT 21H
ENDM

.MODEL SMALL
.DATA
	STR1	DB	20 DUP('$')
	L1	DB	0
	STR2	DB	20 DUP('$')
	L2	DB	0
	M1	DB	'ENTER THE MAIN STRING: $'
	NL	DB	10,13,'$'
	M2	DB	'ENTER THE SUB-STRING: $'
	INV	DB	'NOT A SUBSTRING.$'
	N	DB	0
	M3	DB	'NO OF OCCURANCES: $'
.CODE
	MOV AX,@DATA
	MOV DS,AX

	PRINT_STR M1			;ASK FOR MAIN STRING
	SCAN_STR STR1			;ACCEPT MAIN STRING
	MOV BL,[STR1+1]
	MOV [L1],BL			;STORE IN L1 THE LENGTH OF MAIN STRING
	PRINT_STR NL			;NEWLINE

	PRINT_STR M2			;ASK FOR SUB-STRING
	SCAN_STR STR2			;ACCEPT SUB-STRING
	MOV BL,[STR2+1]
	MOV [L2],BL			;STORE IN L2 THE LENGTH OF SUB-STRING
	MOV BH,L1			;BH HAS L1, BL HAS L2 DATA
	PRINT_STR NL

	CMP BH,BL			;COMPARE L1 AND L2
	JL INVALID_CASE			;IF MAIN STRING IS SHORTER THAN SUB-STRING, THEN INVALID OCCURANCE
	JMP POSSIBLE			;ELSE SUB-STRING OCCURANCE POSSIBLE
INVALID_CASE:
	PRINT_STR INV
	FINISH
POSSIBLE:
	MOV AX,0
	MOV AL,OFFSET STR1+2		;LEA ADDRESS OF STR1 INTO AX   
	MOV SI,2			
	
	MOV BX,0
	MOV BL,OFFSET STR2+2		;LEA ADDRESS OF STR2 INTO BX
	MOV BH,[L1]
	MOV BL,[L2]
LOOP1:	
	MOV CX,SI
	MOV CH,CL
	MOV CL,2
	MOV DH,STR1[CH]
	MOV DL,STR2[CL]
	CMP DH,DL
	JE LOOP2
	INC SI
	JMP LOOP1
	LOOP2:
		MOV DH,STR1[CH]
		MOV DL,STR2[CL]
		;ADD DX,DI
		;MOV DH,[STR1+DX]
		INC CH
		INC CL
		CMP DH,DL
		JNE 
	FINISH
END
