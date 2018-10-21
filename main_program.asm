INCLUDE AdditionalDef.inc
INCLUDE WelcomeScreen.INC
INCLUDE Configuration.inc
INCLUDE structure.inc
INCLUDE Function.inc
INCLUDE Font.inc


.data
oHandle HANDLE ?
DelayBlock DWORD 0

.code
main PROC
	;This part of code move pointer to console to variable oHandle
	INVOKE GetSTDHandle , STD_OUTPUT_HANDLE
	mov OHandle,eax


	INVOKE WriteWelcomeScreen,oHandle,1
	
L2:	INVOKE CLRSCR
	
	INVOKE SetStartWindow,			oHandle,	GameBufferSize,			ADDR GameWindowSize, ADDR AppTitle
	INVOKE WriteStartLine,			oHandle,	ADDR StartLine
	INVOKE WriteConsoleOutputA,		ohandle,	ADDR GameInfoBackround,	GameInfoSize,		 GameInfoStartPosition,		ADDR GameInfoA

	INVOKE MakeStartBlocksMatrix,	oHandle,	ADDR Blocks_Cell_Array, Blocks_Matrix_Size,	 ADDR Blocks_Collor_Array,	ADDR BLocks_Points_Array,	ADDR Blocks_Hit_Array,	ADDR Blocks_Fall_Array
	INVOKE SetConsoleCursorInfo,	oHandle,	ADDR Cursor_Info
	INVOKE SetStartPosition,		ADDR Pad,   ADDR Ball
	INVOKE WritePoints,				ohandle,	Game_Points
	INVOKE LifeCheck,				oHandle,	Game_Lifes , ADDR Ball
	
	mov edx, OFFSET Ball


L1: INVOKE MovPadCell,				oHandle,	ADDR Pad,				ADDR Pad_Time_Info
	INVOKE MovBall,					oHandle,	ADDR Ball,				ADDR Blocks_Cell_Array,	ADDR Ball_Time_Info, ADDR Game_Lifes 
	INVOKE UpdateScreenMatrix,		oHandle,	ADDR Blocks_Cell_Array,	ADDR Pad,				ADDR Game_Points
	
	mov edx, Offset ball
	movzx eax, (BALL_ PTR[edx]).Active
	.IF eax == 0
		mov edx,OFFSET Game_Points
		mov eax,0
		mov [edx],eax
		mov edx,OFFSET Game_Lifes
		mov eax,DWORD PTR [edx]
		.IF eax>0
			mov eax,3000
			INVOKE delay
		.ELSE 
			mov eax,1000
			INVOKE delay
		.ENDIF
		mov eax,1
		mov edx, Offset ball
		mov (BALL_ PTR[edx]).Active,al
		JMP L2 
	.ENDIF





SKIP:push ecx
	 mov eax,KEY_TIME_PRESS
	 INVOKE Delay
	 add DelayBlock,Pad_Speed
	 INVOKE GetKeyState,VK_ESCAPE
	 AND eax,KEY_DOWN
	 JNZ THEEND
	 mov eax,Game_Lifes
	 .IF eax == 0
		JMP THEEND
	 .ENDIF	
	 pop ecx
	 JMP L1
	


THEEND:
    INVOKE clrscr
	INVOKE WriteStartLine,			oHandle,	ADDR StartLine
	INVOKE WriteConsoleOutputA,		ohandle,	ADDR GameInfoBackround,	GameInfoSize,			GameInfoStartPosition,		ADDR GameInfoA
	INVOKE MakeStartBlocksMatrix,	Ohandle,	ADDR Blocks_Cell_Array, Blocks_Matrix_Size,		ADDR Blocks_Collor_Array,	ADDR BLocks_Points_Array,	ADDR Blocks_Hit_Array,	ADDR Blocks_Fall_Array
	INVOKE WriteBigString,			oHandle,	ADDR GameOverString,	GameOverStringLengt,	2,							ADDR GameOverStringColor,	GameOverStringPosition,	2

	mov eax, 3000
	INVOKE delay
	exit
main ENDP
END main