;==========================================================================================================================
;--------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------- Function.inc --------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------ Authors: ----------------------------------------------------------
;---------------------------------------------- Turkmanovic Haris 516/2014 ------------------------------------------------
;----------------------------------------------- Vukoje David 541/2014 ----------------------------------------------------
;==========================================================================================================================
;Description:
;	This .inc file contains prototype of function which is used in function.asm. Here are locate important function which control
; game behavior.A detailed description of all functions is located in function.asm file.
;==========================================================================================================================


DecimalToAscIIm MACRO
		push ebx
		.WHILE eax!=0
			mov edx,0
			mov ebx,10
			div ebx
			add edx,48
			mov WORD PTR[ecx],dx
			add ecx,2
			INC Counter
		.ENDW
		pop ebx
ENDM
ReverseArraym MACRO
		mov ecx,Counter	
		LEA edi,AscII_Array
		mov esi,edi
		.WHILE ecx>1
			add esi,TYPE WORD
			dec ecx
		.ENDW
		mov ecx,Counter
		.WHILE ecx>0
			movzx eax,WORD PTR[edi]
			movzx edx,WORD PTR[esi]
			mov WORD PTR[edi],dx
			mov WORD PTR[esi],ax
			sub esi,TYPE WORD
			add edi,TYPE WORD
			.IF edi>=esi
				.BREAK
			.ENDIF
		.ENDW
ENDM
mUP_Left MACRO
	.IF eax == Left_Collision
	    INVOKE ReBoundBall, Ball_Cell,Up_Right
	.ELSEIF eax == TopBottom_Collision
	    INVOKE ReBoundBall, Ball_Cell,Down_Left
	.ENDIF
ENDM
mUP_Right MACRO
	.IF eax == Right_Collision
	    INVOKE ReBoundBall, Ball_Cell,Up_Left
	.ELSEIF eax == TopBottom_Collision
	    INVOKE ReBoundBall, Ball_Cell,Down_Right
	.ENDIF
ENDM
mDown_Left MACRO
	.IF eax == Left_Collision
	    INVOKE ReBoundBall, Ball_Cell,Down_Right
	.ELSEIF eax == TopBottom_Collision
	    INVOKE ReBoundBall, Ball_Cell,UP_Left
	.ENDIF
ENDM
mDown_Right MACRO
	.IF eax == Right_Collision
	    INVOKE ReBoundBall, Ball_Cell,Down_Left
	.ELSEIF eax == TopBottom_Collision
	    INVOKE ReBoundBall, Ball_Cell,UP_Right
	.ENDIF
ENDM

SetColorAndASCII PROTO,
			InArr:PTR _CHAR_INFO,
			Color:DWORD,
			ASCII:DWORD,
			Siz:DWORD	

SetStartWindow PROTO,
			oHandle:HANDLE,
			BuffSize:COORD,
			WinSize:PTR SMALL_RECT,
			GameName:PTR BYTE

WriteBlock PROTO ,
			oHandle:HANDLE,
			Cell_Info:PTR CELL
DeleteBlock PROTO ,
			oHandle:HANDLE,
			Cell_Info:PTR CELL
WritePad PROTO ,
			oHandle:HANDLE,
			Cell_Info:PTR CELL
DeletePad PROTO ,
			oHandle:HANDLE,
			Cell_Info:PTR CELL

WriteStartLine PROTO,
			oHandle:HANDLE,
			Line:PTR _CHAR_INFO

WriteRow PROTO,
			oHandle:HANDLE,
			Cell_Array:PTR CELL,
			Cell_Array_Size:DWORD,
			Row_Start_Position:WORD,
			Row_Color:DWORD,
			Row_Point:DWORD,
			Hit_Count:WORD,
			Fall_Ready:DWORD

MakeStartBlocksMatrix PROTO,
			oHandle:HANDLE,
			Cell_Matrix:PTR CELL,
			Cell_Matrix_Size:COORD,
			Collor_Array:PTR DWORD,
			Points_Array:PTR DWORD,
			Hit_Array:PTR WORD,
			Fall_Array:PTR DWORD

MovPad PROTO,
			oHandle:HANDLE,
			Pad_:PTR CELL

GoDown PROTO,
			oHandle:HANDLE,
			Block:PTR CELL,
			BottomFlag:PTR DWORD
MovBlock PROTO,
			oHandle				:HANDLE,
			Block				:PTR CELL,
			Pad					:PTR CELL


UpdateScreenMatrix PROTO,
			oHandle			:HANDLE,
			Matrix			:PTR CELL,
			Pad				:PTR CELL,
			Points			:PTR DWORD
				
MovPadCell PROTO,
			oHandle:HANDLE,
			PadCell:PTR CELL, 
			Row_Time_Info:PTR DWORD

FindCollision PROTO,
			Array:PTR CELL,
			Cordinate:COORD,
			Out_BLOCK:PTR DWORD

ReBoundBall PROTO, ;Funkcija koja generise naredne koordinate Ball strukture u slucaju odbijanja od objekta
			Ball_Cell:PTR BALL_,
			Direction:DWORD

NextBallPosition PROTO,
			oHandle:HANDLE,		;This Procedure calculate next ball position by Previos and current position of BALL.Also this procedure check if Ball is at the window edge or fall from window.If there is Collision with the other block
			Ball_Cell:PTR BALL_,
			Blocks_Matrix: PTR CELL,
			Lifes	:PTR DWORD

SetNextBallPosition PROTO, ;This Procedute set next ball position define by NextPosition
			Ball_Cell:PTR BALL_,
			NextPosition:COORD

			
WriteBallCell PROTO,
			oHandle  :	HANDLE,
			Ball_Cell:	PTR BALL_
DeleteBallCell PROTO,
			oHandle  :	HANDLE,
			Ball_Cell:	PTR BALL_
IsAtScreenEdge PROTO,				;this function return 0 in EAX if Ball is in window,1 if BALL is window edge and 2 if ball fall
			Position:COORD 

MovBall PROTO,
		oHandle:HANDLE,
		BALL_CELL:PTR BALL_,
		Blocks_Matrix:PTR CELL,
		Time_Info:PTR DWORD,
		Lifes:PTR DWORD
WritePoints PROTO,
		ohandle			:HANDLE,
		Points			:DWORD
SetStartPosition PROTO,
		Pad_Cell:PTR CELL,
		Ball_Cell:PTR BALL_
LifeCheck PROTO,
		ohandle			:HANDLE,
		Lifes			:DWORD,
		Ball_Cell		:PTR BALL_


		









