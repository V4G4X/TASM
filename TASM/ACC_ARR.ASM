SCAN_DATA MACRO DAT


.MODEL SMALL
.DATA
	MSG1 DB 'ENTER THE NUMBER OF ELEMENTS YOU WILL BE ADDING',10,13,'$'
	LEN  DB 53
	MSG2 DB ''
	DATA DB ?
.CODE 
	MOV AX,@DATA
	MOV DS,AX
	
	
