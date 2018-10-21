;==========================================================================================================================
;--------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------- COnfiguration.inc ------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------ Authors: ----------------------------------------------------------
;---------------------------------------------- Turkmanovic Haris 516/2014 ------------------------------------------------
;----------------------------------------------- Vukoje David 541/2014 ----------------------------------------------------
;==========================================================================================================================
;Description:
;	This include file contains game properties like number of lives,ball speed,pad speed, ....
;   Also , there is game windows properties 
;	Thanks to this .inc file game is more flexible and the player can adjust the game according to his affinities
;	Part of .inc file mark as private can't be modified by player
;==========================================================================================================================


;Windows size
GameWindow_Width		= 122 ;Start width of game window
GameWindow_Height		= 55  ;Start Hight of game window
WelcomeScreen_Width		= 70
WelcomeScreen_Hight		= 35

;GameGraphic
StartLinePosition		= 7 ;+1 position where is Frist Block Matrix row start. Unit is CHAR
StartLineColor			= Blue 
Block_Width				= 10
BLock_Height			= 3 
Pad_Width				= 16
Pad_Height				= 2 
Pad_Color               = White 
Ball_Color				= 7
HitColor				= lightRed
Points_color			= BLUE
Life_color				= Yellow		      



;GameOptions
Start_Life_Number		= 2
Pad_speed				= 0
Ball_Speed				= 1
Pad_step				= 1
Fall_Speed				= 4
Number_Of_Colors		= 6
Number_of_Cell_in_Row	= 11
Max_Cell_Area			= 100; This is max area which cell can obtain. Unit is CHAR
WS_Time_Duration		= 50


AppName TEXTEQU <"Arkanoid",0>

;------------------------------------
;-----------Private-----------------
KEY_DOWN EQU 80000000h
KEY_TIME_PRESS		= 10
Cell_Size			= 27
Dec_LIFE			= 0 ;Flag which indicate that Ball is fall

sCellRow0 EQU CellArray+0*4*Block_Width
sCellRow1 EQU CellArray+1*4*Block_Width
sCellRow2 EQU CellArray+2*4*Block_Width

PadRow0 EQU Cell_Array+0*4*Pad_Width
PadRow1 EQU Cell_Array+1*4*Pad_Width

MatrixRow0 EQU Blocks_Cell_Array+0*Number_of_Cell_in_Row*Cell_Size
MatrixRow1 EQU Blocks_Cell_Array+1*Number_of_Cell_in_Row*Cell_Size
MatrixRow2 EQU Blocks_Cell_Array+2*Number_of_Cell_in_Row*Cell_Size
MatrixRow3 EQU Blocks_Cell_Array+3*Number_of_Cell_in_Row*Cell_Size
MatrixRow4 EQU Blocks_Cell_Array+4*Number_of_Cell_in_Row*Cell_Size
MatrixRow5 EQU Blocks_Cell_Array+5*Number_of_Cell_in_Row*Cell_Size

Pad_X_Start_Position	= GameWindow_width/2-Pad_Width/2;Private
Pad_Y_Start_Position	= GameWindow_height-1-Pad_Height;Private

Row EQU StartLinePosition+1+esi*Cell_Height
Start_Blocks_Array_Size EQU Number_Of_Colors*Number_of_Cell_in_Row

NoCollision			=	0
TopBottom_Collision	=	1 
Left_Collision		=	2
Right_Collision		=	3
UP_LEFT				=	1
UP_RIGHT			=	2
DOWN_LEFT			=	3
DOWN_RIGHT			=	4
DeadBall			=   4

GameInfoArea EQU GameWindow_width*StartLinePosition

