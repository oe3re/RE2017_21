;==========================================================================================================================
;--------------------------------------------------------------------------------------------------------------------------
;----------------------------------------------------- structure.inc ------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------ Authors: ----------------------------------------------------------
;---------------------------------------------- Turkmanovic Haris 516/2014 ------------------------------------------------
;----------------------------------------------- Vukoje David 541/2014 ----------------------------------------------------
;==========================================================================================================================
;Description:
;	Include file contain data and properties which is important for game.In this file is defined CELL structure which is basic 
; part of the game.Also here is defined BALL_ structure which represent moving ball in game.Here are also data which is imortant
; for game window and game itself. Here we can set how much points is Assigned to row , row color, ball start position , ....
;	Thanks to this file we can change the performance of the game itself
;==========================================================================================================================

;------------------------------------------
;-------------Graphic part-----------------
CELL STRUCT
	Activate	BYTE	1
	Value		DWORD	0
	Color		DWORD	0
	HitCount	WORD	0
	AREA_Position SMALL_RECT <0,0,0,0> ; Position of cell in console. This is set by PROCEDURE which use this STRUCTURE
	FALL_Flag	DWORD 0 ;This flag mark Falling Block
	TIME		DWORD 0;
CELL ENDS

BALL_ STRUCT
	CurrentPos	COORD <>
	PrevPos		COORD <>
	Active      BYTE  1
BALL_ ENDS


.data
;-----------------------------------------------------
;-------------Welcome screen Window data--------------
;-----------------------------------------------------
WelcomeScreenBufferSize				COORD		<WelcomeScreen_Width	,WelcomeScreen_Hight>
WelcomeScreenWindowSize				SMALL_RECT	<0,0,WelcomeScreen_Width-1,WelcomeScreen_Hight-1>



;-------------GameWindow data--------------

GameBufferSize				COORD					<GameWindow_width,GameWindow_Height>
GameWindowSize				SMALL_RECT				<0,0,GameWindow_width-1,GameWindow_height-1>
AppTitle					BYTE					AppName
Cursor_Info					CONSOLE_CURSOR_INFO		<100,0>

;------------------------------------------
;-------------Graphic data-----------------

StartLine				_CHAR_INFO	GameWindow_width											DUP(<223,StartLineColor>)	
Blocks_Collor_Array		DWORD		BLUE, GREEN, RED, YELLOW, MAGENTA, GRAY
;!!! Blocks_Cell_Array And Pad_Cell NEED TO BE ADJACENT beacouse sometimes PROCEDURE look at this part of memory as one PART
Blocks_Cell_Array		CELL		Start_Blocks_Array_Size	DUP(<>)
Pad						CELL		<1,0,Pad_Color,0,<Pad_X_Start_Position,Pad_Y_Start_Position,Pad_X_Start_Position+Pad_width-1,Pad_Y_Start_Position+Pad_Height-1>>
Blocks_Points_Array     DWORD		50, 80, 90, 120, 100, 60
Ball					BALL_		<<0,0>,<0,0>>

;------------------------------------------
;----------------GAME data-----------------


Blocks_Hit_Array		WORD			1,	 1,  1,   1,   1,  2 
Blocks_Fall_Array		DWORD			0,	 0,  0,   0,   0,  1 
Blocks_Matrix_size		COORD			<Number_of_cell_in_Row,Number_Of_Colors>
Points_Start_Position	COORD			<10,1>
Points_Color_Array		DWORD			10				DUP(Points_Color)
Life_Start_Position		COORD			<80,1>
Life_Color_Array		DWORD			10				DUP(Life_Color)
GameInfoBackround		_CHAR_INFO		GameInfoArea	DUP(<0,80h>)
GameInfoSize			COORD			<GameWindow_width,StartLinePosition>
GameInfoA				SMALL_RECT		<0,0,GameWindow_width,StartLinePosition>
GameInfoStartPosition	COORD			<0,0>
Game_Points				DWORD			0
Game_Lifes				DWORD			Start_Life_Number
GameOverString			WORD			'G','A','M','E',DELETE_CODE,'O','V','E','R'
GameOverStringLengt		WORD			9
GameOverStringCOlor		DWORD			9 DUP(RED)
GameOverStringPosition	COORD			<30,0>

;---------------Time data-----------------
Gray_Row_Time_Info		DWORD		Number_of_cell_in_Row						DUP(0)
Pad_Time_Info			DWORD        0
Ball_Time_Info			DWORD        0







