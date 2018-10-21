INCLUDE AdditionalDef.inc
INCLUDE Configuration.inc
INCLUDE structure.inc
INCLUDE Function.inc
INCLUDE Font.inc


.code

;--------------------------------------------------------------------------------------------------------------
;---------------------------------------Start condition procedure----------------------------------------------
;--------------------------------------------------------------------------------------------------------------
;In this section there are Procedure which cinfugure start condition of game such as windows size, start block
;position, ....
;This procedure set Window size,Window Title and Window Buffer size.Procedure call kernel32 procedure such as 
;SetConsoleSreenBufferSize, SetConsoleWindowInfo, SetConsoleTitle . For understanding this Procedure visit MSDM WebSIte 
SetStartWindow PROC ,
			oHandle:HANDLE,
			BuffSize:COORD,
			WinSize:PTR SMALL_RECT,
			GameName:PTR BYTE	
			pushad
			INVOKE SetConsoleScreenBufferSize, oHandle, BuffSize	
			INVOKE SetConsoleWindowInfo, oHandle, TRUE, WinSize	
			INVOKE SetConsoleTitle, GameName
			popad
			ret
SetStartWindow ENDP

;This function make Start Matrix and Initializes BLOKCS CELL
MakeStartBlocksMatrix PROC,						
			oHandle				:HANDLE,		;Handle to window
			Cell_Matrix			:PTR CELL,		;Pointer to Uninitialize Matrix
			Cell_Matrix_Size	:COORD,			;Size of matrix. X is number of rows and Y is number of columns
			Collor_Array		:PTR DWORD,		;This Array contains color for each row 
			Points_Array		:PTR DWORD,		;This Array contains points for each row
			Hit_Array			:PTR WORD,		
			Fall_Array			:PTR DWORD		

			LOCAL RowStartPosition	:DWORD,
					CollorArrayPTR	:DWORD, 
					PointsArrayPTR	:DWORD,
					HitArrayPTR		:DWORD,
					FallArrayPTR	:DWORD,
					ArraySize		:DWORD,
					RowColor		:DWORD,
					RowValue		:DWORD,
					Temp			:DWORD,
					HitCounter		:WORD,
					FallFlag		:DWORD
			pushad
			
			movzx ecx, Cell_Matrix_Size.Y ;Initialize Counter

			movzx edx, Cell_Matrix_Size.X
			mov ArraySize, edx
			
			mov edi, Cell_Matrix
			mov esi,0
			mov RowStartPosition, 0
			
			mov eax,Collor_Array
			mov CollorArrayPTR,eax
			
			mov eax,Points_Array
			mov PointsArrayPTR,eax
			
			mov eax,Hit_Array
			mov HitArrayPTR,eax
			
			mov eax,Fall_Array
			mov FallArrayPTR,eax
		
		L1:	mov eax,esi
			mov edx,Block_Height
		    mul edx

			;Calculating rows start position
			mov RowStartPosition,eax
			add RowStartPosition,1
			add RowStartPosition,StartLinePosition

			mov edx,CollorArrayPTR
			mov eax,[edx]
			mov RowColor,eax

			mov edx,PointsArrayPTR
			mov eax,[edx]					
			mov RowValue,eax

			mov edx,HitArrayPTR
			movzx eax,WORD PTR [edx]					
			mov HitCounter,ax

			mov edx,FallArrayPTR
			mov eax,[edx]
			mov FallFlag,eax

			JMP L3
	L2:     JMP L1									;I need to cut this Because MASM error told that this loop is too long
	L3:
			INVOKE WriteRow, oHandle, edi, Arraysize, WORD PTR RowStartPosition, RowColor, RowValue,HitCounter,FallFlag
			
			mov eax,CollorArrayPTR
			add eax,4
			mov CollorArrayPTR,eax
			
			mov eax,PointsArrayPTR
			add eax,4
			mov PointsArrayPTR,eax
			
			mov eax,HitArrayPTR
			add eax,2
			mov HitArrayPTR,eax
			
			mov eax,FaLLArrayPTR
			add eax,4
			mov FallArrayPTR,eax
			
			inc esi
			
			mov eax,TYPE CELL
			mov edx,ArraySize			
			mul edx
			add edi,eax			
			
			LOOP L2
			
			popad
			ret
MakeStartBlocksMatrix ENDP

;This procedure Initializes all blocks in one row
;This procedure is call by:
;		- MakeStartCellMatrix procedure
WriteRow PROC,
			oHandle				:HANDLE,
			Cell_Array			:PTR CELL,
			Cell_Array_Size		:DWORD,
			Row_Start_Position	:WORD,
			Row_Color			:DWORD,
			Row_Point			:DWORD,
			Hit_Count			:WORD,
			Fall_Flag			:DWORD
			
			LOCAL	RowStartPositionYTOP	:WORD,
					RowStartPositionYBOTTOM	:WORD,
					RowStartPositionXLEFT	:WORD,
					RowStartPositionXRIGHT	:WORD
			pushad
			
			mov ecx,Cell_Array_Size
			mov edi,Cell_Array

			mov ax, Row_Start_Position
			mov RowStartPositionYTOP, ax
			add eax, Block_Height	
			sub eax, 1
			mov RowStartPositionYBOTTOM,ax
			mov ax,1

			;This Part of code calculating Left,Right,Top and Bottom position for each cell.
			;Than call WriteCell procedure for write that particular cell 
		L1:	mov RowStartPositionXLEFT,ax
			add eax, Block_Width
			sub eax,1
			mov RowStartPositionXRIGHT,ax
			add ax,1
			mov edx,Fall_Flag
			mov (CELL PTR [edi]).Fall_Flag, edx
			movzx edx,Hit_Count
			mov (CELL PTR [edi]).HitCount, dx
			mov edx,1
			mov (CELL PTR [edi]).Activate, dl				
			mov esi,Row_Color
			mov (CELL PTR [edi]).Color, esi
			mov esi,Row_Point
			mov (CELL PTR [edi]).Value, esi
			mov dx,RowStartPositionYTOP
			mov (CELL PTR [edi]).Area_position.TOP, dx
			mov dx,RowStartPositionYBOTTOM
			mov (CELL PTR [edi]).Area_position.BOTTOM, dx
			mov dx,RowStartPositionXLEFT
			mov (CELL PTR [edi]).Area_position.LEFT, dx
			mov dx,RowStartPositionXRIGHT
			mov (CELL PTR [edi]).Area_position.RIGHT, dx
			
			add dx,Block_Height					
			sub dx,1				
			mov ax,dx
			
			INVOKE WriteBlock, oHandle, edi 
			
			add edi,TYPE CELL
			
			LOOP L1
			


			popad
			ret
WriteRow ENDP
;This procedute write start line to screen.Start line indicate new upper bound of GameScreen.Above this line is Game information such as
;points and Remaining lifes
;This procedure is call by :
;		- Main procedure
WriteStartLine PROC ,
				oHandle		:HANDLE,
				Line		:PTR _CHAR_INFO

				LOCAL	ArraySize					:COORD,
						ReadFromPosition			:COORD,
						WriteToScreenBufferPosition	:SMALL_RECT
				pushad

				mov ArraySize.X,GameWindow_Width
				mov ArraySize.Y,1
				mov ReadFromPosition.X,0
				mov ReadFromPosition.Y,0
				mov WriteToScreenBufferPosition.LEFT, 0
				mov WriteToScreenBufferPosition.TOP, StartLinePosition
				mov WriteToScreenBufferPosition.BOTTOM, StartLinePosition
				mov WriteToScreenBufferPosition.RIGHT,GameWindow_Width-1
				
				INVOKE WriteConsoleOutputA, oHandle, Line, ArraySize, ReadFromPosition, ADDR WriteToScreenBufferPosition
				
				popad
				ret
WriteStartLine ENDP



;--------------------------------------------------------------------------------------------------------------
;-------------------------------------------------Block procedure----------------------------------------------
;--------------------------------------------------------------------------------------------------------------
;Write Block to Screen and remember information about cell in CELL structure
;This Procedure is call by next procedures:
;		- WriteRow
;		- GoDown
;		- UpdateScreenMatrix
WriteBlock PROC ,			
			oHandle		:HANDLE,
			Cell_Info	:PTR CELL

			LOCAL 	CellArray[Max_Cell_Area]	:_CHAR_INFO,	;This array contains information(AsciiValue and collor) about CHAR from which it was created one Block
					color						:DWORD,		
					ArraySize					:COORD,			;This Data give information about Array size for read 		
					ArrayStartPosition			:COORD,
					RegionForWrite				:SMALL_RECT
			
			pushad

			mov esi,Cell_Info
			mov eax,(CELL PTR [esi]).Color
			mov color,eax
			
			;Each individual block is composed of three sets(Arrays):
			;	- Up array 
			;	- Central array	
			;	- Down array
			;Each of them is array of AscII char.Length of Array is equal to Block_Width 
			
			INVOKE SetColorAndASCII,ADDR (sCellRow0),color,	220, Block_Width ;220 is AscII code for up block side
			INVOKE SetColorAndASCII,ADDR (sCellRow1),color,	219, Block_Width ;219 is AscII code for cetral part of the block
			INVOKE SetColorAndASCII,ADDR (sCellRow2),color,	223, Block_Width ;223 is AscII code for Bottom part of the block
			
			mov Arraysize.X,Block_Width
			mov Arraysize.Y,Block_Height

			mov ArrayStartPosition.X,0
			mov ArrayStartPosition.Y,0
			
			mov ax,(CELL PTR [esi]).Area_Position.Left
			mov  RegionForWrite.Left,ax
			mov ax,(CELL PTR [esi]).Area_Position.Top
			mov RegionForWrite.Top,ax
			mov ax,(CELL PTR [esi]).Area_Position.Right
			mov RegionForWrite.Right,ax
			mov ax,(CELL PTR [esi]).Area_Position.Bottom
			mov RegionForWrite.Bottom,ax

			INVOKE WriteConsoleOutputA, OHandle, ADDR CellArray, Arraysize, ArrayStartPosition, ADDR RegionForWrite
			popad			
			ret
WriteBlock ENDP
;This procedure Initializes _Char_Info Structure 
;This procedure is call by next procedures:
;		-WriteBlock 
;		-DeleteBlock
SetColorAndASCII PROC, 
			InArr	:PTR _CHAR_INFO,
			Color	:DWORD,
			ASCII	:DWORD,
			Siz		:DWORD
			pushad

			mov ecx,Siz
			mov edi,InArr
			mov eax, ASCII
			mov edx, COLOR
	L1:	    mov DWORD PTR [edi],eax 
			add edi,2
			mov DWORD PTR [EDI],edx
			add edi,2
			LOOP L1

			popad
			ret
SetColorAndASCII ENDP

;This procedure delete Block from screen.Procedure set zero value of color to area of screen defined by Cell_Info.
;;This Procedure is call by next procedures:
;		- GoDown
;		- UpdateScreenMatrix
DeleteBlock PROC ,			
			oHandle		:HANDLE,
			Cell_Info	:PTR CELL

			LOCAL	CellArray[Max_Cell_Area]	:_CHAR_INFO, 
					color:DWORD,Array_Size		:COORD,
					Array_Start_Position		:COORD,
					Region_For_Write			:SMALL_RECT,
					temp:DWORD
			pushad

			mov esi,Cell_Info
			mov eax,0
			mov color,eax
			mov temp,eax
			
			INVOKE SetColorAndASCII,ADDR (sCellRow0),color,220, Block_Width
			INVOKE SetColorAndASCII,ADDR (sCellRow1),color,219, Block_Width
			INVOKE SetColorAndASCII,ADDR (sCellRow2),color,223, Block_Width
			
			mov Array_size.X,Block_Width
			mov Array_size.Y,Block_Height
			mov Array_Start_Position.X,0
			mov Array_Start_Position.Y,0
			mov ax,(CELL PTR [esi]).Area_Position.Left
			mov  Region_For_Write.Left,ax
			mov ax,(CELL PTR [esi]).Area_Position.Top
			mov Region_For_Write.Top,ax
			mov ax,(CELL PTR [esi]).Area_Position.Right
			mov Region_For_Write.Right,ax
			mov ax,(CELL PTR [esi]).Area_Position.Bottom
			mov Region_For_Write.Bottom,ax
			
			INVOKE WriteConsoleOutputA, OHandle, ADDR CellArray, Array_size, Array_Start_Position, ADDR Region_For_Write
			;After seting color to 0 we must return original color information to Block
			
			INVOKE SetColorAndASCII,ADDR (sCellRow0),temp,220, Block_Width
			INVOKE SetColorAndASCII,ADDR (sCellRow1),temp,219, Block_Width
			INVOKE SetColorAndASCII,ADDR (sCellRow2),temp,223, Block_Width
			
			popad			
			ret
DeleteBlock ENDP
;This procedure lowers the block position.This is used when we have Fall block
;This Procedure is call by next procedures:
;		- MovBlock

GoDown PROC,
			oHandle		:HANDLE,
			Block		:PTR CELL,
			Bottom_Flag	:PTR DWORD

			LOCAL	lSize			:COORD,
					StartPosition	:COORD,
					AreaForWrite	:SMALL_RECT
			
			pushad
			
			mov edi,Bottom_Flag		;Set bottom flag to 0
			mov DWORD PTR [edi],0
			
			mov edx, block			;set edx to be Pointer to block
			mov lSize.X,Block_Width
			mov lSize.Y,Block_Height
			mov StartPosition.X,0
			mov StartPosition.Y,0			
			
			;Decreasing Block position
			movzx eax, (CELL PTR[edx]).Area_Position.Bottom
			INC eax
			mov AreaForWrite.Bottom,ax
			movzx eax, (CELL PTR[edx]).Area_Position.Top
			INC eax
			mov AreaForWrite.TOP,ax

			;Check if BLOCK is at the bottom
			SUB eax,GameWindow_height
			JNZ SKIP
			mov DWORD PTR [edi],1                         ;Indicate that cell is Disappeared from screen
	   SKIP:mov ax,(CELL PTR[edx]).Area_Position.Left
			mov AreaForWrite.Left,ax
			mov ax,(CELL PTR[edx]).Area_Position.Right
			mov AreaForWrite.Right,ax
			
			;Frist we delete block from old position
			INVOKE DeleteBlock,ohandle, Block
			
			;Mov new position coordinate to block 
			mov ax,AreaForWrite.Left
			mov (CELL PTR[edx]).Area_Position.Left,ax
			mov ax,AreaForWrite.Right
			mov (CELL PTR[edx]).Area_Position.Right,ax
			mov ax,AreaForWrite.Top
			mov (CELL PTR[edx]).Area_Position.Top,ax
			mov ax,AreaForWrite.Bottom
			mov (CELL PTR[edx]).Area_Position.Bottom,ax

			;Call WriteBlock procedute to write block with new coordinate
			INVOKE WriteBlock, oHandle, Block
			
			popad
			ret
GoDown ENDP

;This procedure move block down with desire speed.Also this procedure give information to outside world about collision between block and pad.
;That information is remember in PAD cell
;Procedure is call by next procedures:
;		- UpdateScreenMatrix
MovBlock PROC,
			oHandle				:HANDLE,
			Block				:PTR CELL,
			Pad_				:PTR CELL

			
			LOCAL	RowPTR					:DWORD, 
					DownFlag				:DWORD,
					Temp					:WORD,
					BlockPadCollisionFlag	:DWORD
			pushad
			
			;Frist we check if time condition is satisfied.
			mov BlockPadCollisionFlag,0
			mov DownFlag,0
			mov edx,Block					;edx is now pointer to Block
			mov eax,(CELL PTR[edx]).Time
			INC eax
			mov (CELL PTR[edx]).Time,eax
			.IF eax>=Fall_Speed
				;If time condition is satisfied than
				;Time reset
				mov eax,0
				mov (CELL PTR[edx]).Time,eax
				
				;Decrese Block Position
				INVOKE GoDown,oHandle,Block,ADDR DownFlag
				
				;Did new block coordinates in collision with pad?
				mov edi,Pad_					;edi is now pointer to pad
				;Frist we check is Top side of pad equal to Bottom side of block
				movzx eax,(CELL PTR [edx]).Area_Position.Bottom
				movzx ecx,(CELL PTR[edi]).Area_Position.Top 
				.IF eax == ecx
					
					;if Top side of pad equal to Bottom side of block than we check is pad left side lower or eqal to block right side
					movzx eax,(CELL PTR [edx]).Area_Position.Right
					movzx ecx,(CELL PTR[edi]).Area_Position.Left
					.IF ecx<=eax
						
						;if pad left side lower or eqal to block right side than we check is par left side greater than block left side Reduced by pad  width 
						movzx eax,(CELL PTR [edx]).Area_Position.Left
						sub eax,Pad_width
						movzx ecx,(CELL PTR[edi]).Area_Position.left
						cmp ecx,eax						
						.IF !Sign? || Zero? ;This way to compare sign value.This is equal to ecx>=eax
							mov BlockPadCollisionFlag,1 ;
						.ENDIF
					.ENDIF
				.ENDIF
				mov eax,BlockPadCollisionFlag
				.IF eax == 1
						;Now we set new value of fall fleg IN PAD CELL which indicate collision betwen fall block and pad
						;This remember information about collision In an area that's out of procedure
						mov (CELL PTR[edi]).Fall_Flag,1
						
						;Mov bonus point to pad value
						;This remember information about collision In an area that's out of procedure
						mov eax,(CELL PTR [edx]).Value
						mov (CELL PTR [edi]).Value,eax
						
						;Now set fall flag in block to 0 which indicate that Falling block is now ordinary block
						mov eax,0
						mov (CELL PTR [edx]).Fall_Flag,eax
				.ENDIF		
				;Is block at the bottom?
				.IF DownFlag == 1
					mov eax,0
					mov (CELL PTR [edx]).Fall_Flag,eax					
				.ENDIF
			.ENDIF	
			popad
			ret
MovBlock ENDP



;--------------------------------------------------------------------------------------------------------------
;---------------------------------------------------Pad procedure----------------------------------------------
;--------------------------------------------------------------------------------------------------------------


;This procedure write PAD cell to screen
;This Procedure is call by next procedures:
;	- MovPad

WritePAD PROC ,			
			oHandle:HANDLE,
			Cell_Info:PTR CELL
			LOCAL Cell_Array[Max_Cell_Area]:_CHAR_INFO, color:DWORD,Array_Size:COORD,Array_Start_Position:COORD,Region_For_Write:SMALL_RECT
			pushad

			mov esi,Cell_Info
			mov eax,(CELL PTR [esi]).Color
			mov color,eax
			
			INVOKE SetColorAndASCII,ADDR (PadRow0),color,219, Pad_Width
			INVOKE SetColorAndASCII,ADDR (PadRow1),color,219, Pad_Width
			mov Array_size.X,Pad_Width
			mov Array_size.Y,Pad_Height
			mov Array_Start_Position.X,0
			mov Array_Start_Position.Y,0
			mov ax,(CELL PTR [esi]).Area_Position.Left
			mov  Region_For_Write.Left,ax
			mov ax,(CELL PTR [esi]).Area_Position.Top
			mov Region_For_Write.Top,ax
			mov ax,(CELL PTR [esi]).Area_Position.Right
			mov Region_For_Write.Right,ax
			mov ax,(CELL PTR [esi]).Area_Position.Bottom
			mov Region_For_Write.Bottom,ax
			INVOKE WriteConsoleOutputA, OHandle, ADDR Cell_Array, Array_size, Array_Start_Position, ADDR Region_For_Write
			popad			
			ret
WritePAD ENDP

;This procedure write PAD cell to screen
;This Procedure is call by next procedures:
;	- MovPad
DeletePAD PROC ,			
			oHandle:HANDLE,
			Cell_Info:PTR CELL
			LOCAL Cell_Array[Max_Cell_Area]:_CHAR_INFO, color:DWORD,Array_Size:COORD,Array_Start_Position:COORD,Region_For_Write:SMALL_RECT
			pushad

			mov esi,Cell_Info
			mov eax,0
			mov color,eax
			
			INVOKE SetColorAndASCII,ADDR (PadRow0),color,220, Pad_Width
			INVOKE SetColorAndASCII,ADDR (PadRow1),color,223, Pad_Width
			mov Array_size.X,Pad_Width
			mov Array_size.Y,Pad_Height
			mov Array_Start_Position.X,0
			mov Array_Start_Position.Y,0
			mov ax,(CELL PTR [esi]).Area_Position.Left
			mov  Region_For_Write.Left,ax
			mov ax,(CELL PTR [esi]).Area_Position.Top
			mov Region_For_Write.Top,ax
			mov ax,(CELL PTR [esi]).Area_Position.Right
			mov Region_For_Write.Right,ax
			mov ax,(CELL PTR [esi]).Area_Position.Bottom
			mov Region_For_Write.Bottom,ax
			INVOKE WriteConsoleOutputA, OHandle, ADDR Cell_Array, Array_size, Array_Start_Position, ADDR Region_For_Write
			popad			
			ret
DeletePAD ENDP
;This procedure check is pressed left or is pressed right key and move pad to appropriate side if key is down
;This procedure is call by next procedures:
;	- MovPadCell
MovPad PROC,
		oHandle	:HANDLE,
		Pad_		:PTR CELL

		pushad

		INVOKE WritePad, oHandle, Pad_
		;Check if left key arrow is down?
START:  INVOKE GetKeyState,VK_LEFT
		AND eax, KEY_DOWN	;If key is pressed , the highest bit in EAX register is equal to 1
		JNZ LEFT			;If left key is pressed than we jump to part of code where MOVE PAD TO LEFT  
		
		INVOKE GetKeyState,VK_RIGHT
		AND eax, KEY_DOWN
		JNZ RIGHT			;If right key is pressed than we jump to part of code where MOVE PAD TO right 
		
		JMP GO_EXIT			;If no one is pressed than exit from procedure

		;Code where procces left move for PAD cell
LEFT:	INVOKE DeletePad, oHandle, Pad_
		mov edx, Pad_		;EDX in now pointer to PAD
		sub (CELL PTR[edx]).Area_Position.Right,Pad_Step	;Decrease Right PAD side
		sub (CELL PTR[edx]).Area_Position.Left, Pad_Step	;Decrease LEFT PAD side
		JLE CORRECTION_LEFT			;if left side is lower than screen border JMP to the part of the code where we return pad to screen

M_LEFT:	INVOKE WritePad,oHandle,Pad_ 
		
		JMP GO_EXIT

		;Code where procces right move for PAD cell.This is same like left PAD move
RIGHT:	INVOKE DeletePad,oHandle,Pad_
		mov edx, Pad_
		add (CELL PTR[edx]).Area_Position.Right,Pad_Step
		add (CELL PTR[edx]).Area_Position.Left,Pad_Step
		MOVZX eax,(CELL PTR[edx]).Area_Position.Right
		mov edi,GameWindow_Width
		SUB edi,1
		SUB eax,edi
		JGE CORRECTION_RIGHT

M_RIGHT:INVOKE WritePad,oHandle,Pad_
		JMP GO_EXIT

CORRECTION_LEFT:
		add (CELL PTR[edx]).Area_Position.Right,Pad_Step
		add (CELL PTR[edx]).Area_Position.Left,Pad_Step
		JMP M_LEFT

		
CORRECTION_RIGHT:
		sub (CELL PTR[edx]).Area_Position.Right,Pad_Step
		sub (CELL PTR[edx]).Area_Position.Left,Pad_Step
		JMP M_RIGHT
		
 GO_EXIT:popad
		ret
MovPad ENDP
;This procedure mov PAD with define speed
;This procedure is call by next procedures:
;	- Main procedure
MovPadCell PROC,
			oHandle			:HANDLE,
			Pad_			:PTR CELL, 
			Row_Time_Info	:PTR DWORD
			
			pushad
			
			mov edx, Row_Time_Info
			mov eax, [edx]
			INC eax
			mov [edx],eax
			CMP eax,Pad_Speed               ;Check if speed is satisfied
			JL GO_END
				INVOKE MovPad, Ohandle, Pad_
				mov eax,0
				mov [edx], eax
	 GO_END:popad
			
			ret
MovPadCell ENDP

;-----------------------------------------------------------------------------------------------------------------
;---------------------------------------------------Screen procedure----------------------------------------------
;-----------------------------------------------------------------------------------------------------------------

;This Complex function Update screen blocks matrix.Update is Re-writing of blocks cell if it becomes inactive.Blocks becomes inactive
;if ball hit block enough number of times.HitCount is a number that shows how many times a block should be hit.If that number is reach
;than block becomes inactive.
;This procedure is call by next procedures:
;		- Main procedure
UpdateScreenMatrix PROC,
			oHandle			:HANDLE,
			Matrix			:PTR CELL,
			Pad_			:PTR CELL,
			Points			:PTR DWORD
			
			pushad
			mov edx,Matrix	;now is edx pointer to matrix
			mov ecx,Start_Blocks_Array_Size
START:		movzx eax,(CELL PTR [edx]).Activate;Check if block active?
			.IF eax ==1;If block is active than we check if rich enough hit number
				movsx eax,(CELL PTR [edx]).HitCount
				cmp eax,0
				.IF SIGN? || ZERO? ;If HitCount <= 0 .This is way for compare two sign number
					mov eax,(CELL PTR [edx]).Fall_Flag
					.IF eax == 1
						INVOKE MovBlock,ohandle,edx,Pad_
						mov edi,Pad_
						mov eax,(CELL PTR[edi]).Fall_Flag
						.IF eax == 1
							mov eax,(CELL PTR[edi]).Value
							mov esi,points
							add [esi],eax
							mov eax,[esi]
							JMP SKIP
CUT:						JMP START
SKIP:
							INVOKE WritePoints,ohandle,eax
							mov eax,0
							mov (CELL PTR[edi]).Fall_Flag,eax
							mov (CELL PTR[edi]).Value,eax
						.ENDIF
					.ELSE
						mov eax,0
						mov (CELL PTR[edx]).Activate,al
						mov eax,(CELL PTR[edx]).Value
						mov edi,Points
						add [edi],eax
						mov eax,[edi]
						INVOKE WritePoints,ohandle,eax 
						INVOKE DeleteBlock, ohandle,edx
						JMP END_LOOP
					.ENDIF
				.ENDIF
				INVOKE WriteBlock,ohandle,edx
			.ENDIF
END_LOOP:	add edx,Cell_Size
			LOOP CUT

			popad
			ret
UpdateScreenMatrix ENDP



WritePoints PROC,
		ohandle			:HANDLE,
		Points			:DWORD
		LOCAL  Ascii_Array[5]	:WORD,
					Counter		:DWORD,
					temp		:DWORD		
		pushad
		mov Counter,0
		mov eax,Points
		LEA ecx,AscII_Array
		.IF eax ==0 
			add eax,48
			mov WORD PTR [ecx],ax
			mov Counter,1
			JMP WRITE_POINTS
		.ENDIF
		
		DecimalToAscIIm
		ReverseArraym

WRITE_POINTS:
		INVOKE WriteBigString, oHandle, ADDR Delete_array, 5	  , 1, ADDR Points_Color_Array, Points_Start_Position, 1
		INVOKE WriteBigString, ohandle,	ADDR Ascii_Array , Counter, 1, ADDR Points_Color_Array, Points_Start_Position, 1

		popad
		ret
WritePoints ENDP

LifeCheck PROC,
		ohandle			:HANDLE,
		Lifes			:DWORD,
		Ball_Cell		:PTR BALL_
		LOCAL  Ascii_Array[5]	:WORD,
					Counter		:DWORD,
					temp		:DWORD		
		pushad
		mov Counter,0
		mov eax,Lifes
		LEA ecx,AscII_Array

			DecimalToAscIIm
			ReverseArraym

			INVOKE WriteBigString, oHandle, ADDR Delete_array, 5	  , 1, ADDR Life_Color_Array, Life_Start_Position	, 1
			INVOKE WriteBigString, ohandle,	ADDR Ascii_Array , Counter, 1, ADDR Life_Color_Array, Life_Start_Position	, 1   
			mov edx,Ball_Cell	
		popad
		ret
LifeCheck ENDP










WriteBallCell PROC,
			oHandle  :	HANDLE,
			Ball_Cell:	PTR BALL_
			LOCAL char:WORD,Attribute:WORD,WrittenChar:DWORD,Position:COORD
			pushad
			mov char,25CBh
			mov Attribute,Ball_color
			mov edx, Ball_Cell
			movzx eax, (BALL_ PTR [edx]).CurrentPos.x
			mov Position.x,ax
			movzx eax, (BALL_ PTR [edx]).CurrentPos.y
			mov Position.y,ax
			INVOKE WriteConsoleOutputCharacterW,oHandle,ADDR char,1,Position,ADDR WrittenChar
			INVOKE WriteConsoleOutputAttribute,oHandle,ADDR Attribute,1,Position,ADDR WrittenChar

			popad
			ret
WriteBallCell ENDP
DeleteBallCell PROC,
			oHandle  :	HANDLE,
			Ball_Cell:	PTR BALL_
			LOCAL char:WORD,Attribute:WORD,WrittenChar:DWORD,Position:COORD
			pushad
			mov char,25CBh
			mov Attribute,0
			mov edx, Ball_Cell
			movzx eax, (BALL_ PTR [edx]).CurrentPos.x
			mov Position.x,ax
			movzx eax, (BALL_ PTR [edx]).CurrentPos.y
			mov Position.y,ax
			INVOKE WriteConsoleOutputCharacterW,oHandle,ADDR char,1,Position,ADDR WrittenChar
			INVOKE WriteConsoleOutputAttribute,oHandle,ADDR Attribute,1,Position,ADDR WrittenChar


			popad
			ret
DeleteBallCell ENDP













FindCollision PROC,   ;This function return 0 in EAX register if dont find collision betwen Ball and Block or Ball and Pad.In other case return 1 in EAX register
			Array:PTR CELL,
			Coordinate:COORD,
			Out_BLOCK:PTR DWORD
			LOCAL Counter:DWORD,Top:DWORD,Left:DWORD,Right:DWORD,Bottom:DWORD
			mov Counter,0
			.WHILE (Counter<Start_Blocks_Array_Size+1)
				mov eax,counter
				mov edx,Cell_Size
				mul edx
				add eax,array
				mov edx,eax
				movzx  eax,(CELL PTR [edx]).Area_Position.Left
				mov Left ,eax
				movzx  eax,(CELL PTR [edx]).Area_Position.Right
				mov Right ,eax
				movzx  eax,(CELL PTR [edx]).Area_Position.Top
				mov Top ,eax
				movzx  eax,(CELL PTR [edx]).Area_Position.Bottom
				mov Bottom ,eax
				movzx eax, Coordinate.Y
				.IF (eax>=Top) && (eax<=Bottom)				;Check is BALL in range?
					movzx eax, Coordinate.X
					.IF (eax>=Left) && (eax<=Right)	
						movzx eax, Coordinate.Y
						.IF(eax == Bottom) || (eax == Top)
							mov eax,TopBottom_Collision
							JMP Check_Active
						.ENDIF
						movzx eax, Coordinate.X
						.IF ( eax == Left)
							 mov eax,Right_Collision 
							 JMP Check_Active
						.ELSEIF (eax == Right)
							 mov eax,Left_Collision
							 JMP Check_Active
						.ENDIF
						

					.ENDIF
				.ENDIF
				INC Counter
				.CONTINUE
Check_Active:	movzx edi, (CELL PTR [edx]).Activate
				.IF  edi == 1
					mov edi, Out_Block
					mov [edi],edx
					JMP END_PROC
				.ELSE
					mov eax, NoCollision
					JMP END_PROC
				.ENDIF
			.ENDW
			mov eax,NoCollision
	END_PROC:
			ret
FindCollision ENDP

ReBoundBall PROC, 
			Ball_Cell:PTR BALL_,
			Direction:DWORD
			LOCAL x_curr:DWORD,y_curr:DWORD,NextPosition:COORD
			pushad
			mov eax,Direction
			mov edx,Ball_Cell
			.IF eax==UP_Left
				JMP UP_LEFTL
			.ELSEIF eax==UP_RIGHT
				JMP UP_RIGHTL
			.ELSEIF eax==DOWN_RIGHT
				JMP DOWN_RIGHTL
			.ELSEIF eax==DOWN_LEFT
				JMP DOWN_LEFTL
			.ENDIF
			JMP END_PROC
UP_RIGHTL:  movzx eax,(BALL_ PTR[edx]).CurrentPos.X
			INC eax
			mov NextPosition.X,ax
			movzx eax,(BALL_ PTR[edx]).CurrentPos.Y
			DEC eax
			mov NextPosition.Y,ax
			INVOKE SetNextBallPosition, edx, NextPosition
			JMP END_PROC
UP_LEFTL:   movzx eax,(BALL_ PTR[edx]).CurrentPos.X
			DEC eax
			mov NextPosition.X,ax
			movzx eax,(BALL_ PTR[edx]).CurrentPos.Y
			DEC eax
			mov NextPosition.Y,ax
			INVOKE SetNextBallPosition, edx, NextPosition
			JMP END_PROC
DOWN_RIGHTL:movzx eax,(BALL_ PTR[edx]).CurrentPos.X
			INC eax
			mov NextPosition.X,ax
			movzx eax,(BALL_ PTR[edx]).CurrentPos.Y
			INC eax
			mov NextPosition.Y,ax
			INVOKE SetNextBallPosition, edx, NextPosition
			JMP END_PROC
DOWN_LEFTL: movzx eax,(BALL_ PTR[edx]).CurrentPos.X
			DEC eax
			mov NextPosition.X,ax
			movzx eax,(BALL_ PTR[edx]).CurrentPos.Y
			INC eax
			mov NextPosition.Y,ax
			INVOKE SetNextBallPosition, edx, NextPosition
			JMP END_PROC

END_PROC:   popad
			ret

ReBoundBall ENDP

NextBallPosition PROC,		;This Procedure calculate next ball position by Previos and current position of BALL.Also this procedure check if Ball is at the window edge or fall from window
			oHandle:HANDLE,
			Ball_Cell:PTR BALL_,
			BLocks_Matrix:PTR CELL,
			Lifes	:PTR DWORD
			LOCAL NextPosition:COORD, CurrentPosition:COORD,CollisionBlockPTR:DWORD
			pushad
			mov edx,Ball_Cell
			movzx eax, (BALL_ PTR [edx]).CurrentPos.X
			mov CurrentPosition.X,ax
			movzx eax, (BALL_ PTR [edx]).CurrentPos.Y
			mov CurrentPosition.Y,ax
			movzx eax,(BALL_ PTR [edx]).PrevPos.X
			.IF ax > CurrentPosition.X
				movzx eax,(BALL_ PTR [edx]).PrevPos.Y
				JMP LEFTL
			.ELSE 
				movzx eax,(BALL_ PTR [edx]).PrevPos.Y
				JMP RIGHTL
			.ENDIF
LEFTL:		.IF ax > CurrentPosition.Y
				JMP UP_LEFTL
			.ELSE 
				JMP DOWN_LEFTL
			.ENDIF	
RIGHTL:		.IF ax > CurrentPosition.Y
				JMP UP_RIGHTL
			.ELSE 
				JMP DOWN_RIGHTL
			.ENDIF
UP_LEFTL:	DEC CurrentPosition.X
			DEC CurrentPosition.Y
			INVOKE FindCollision,Blocks_Matrix, CurrentPosition,ADDR CollisionBlockPTR
			.IF eax != NoCollision
				mov edx,CollisionBlockPTR
				DEC (CELL PTR [edx]).HitCount
				movzx edi, (CELL PTR [edx]).HitCount
				.IF edi == 1
					mov (CELL PTR [edx]).Color,HitColor
				.ENDIF
				mUP_Left
			.ELSEIF 
				INVOKE IsAtScreenEdge,CurrentPosition
				.IF eax!=NoCollision && eax != DeadBall
					mUP_Left
				.ELSEIF eax == DeadBall
					mov edx,Ball_Cell
					mov (BALL_ PTR[edx]).Active,0
					mov edx,Lifes
					mov eax,DWORD PTR [edx]
					dec eax
					mov DWORD PTR [edx],eax
					INVOKE LifeCheck,				oHandle,	eax,		ADDR Ball
				.ELSE 
					INVOKE SetNextBallPosition,Ball_Cell,CurrentPosition
				.ENDIF
			.ENDIF
			JMP END_PROC
UP_RIGHTL:	INC CurrentPosition.X
			DEC CurrentPosition.Y
			INVOKE FindCollision,Blocks_Matrix, CurrentPosition,ADDR CollisionBlockPTR
			.IF eax != NoCollision
				mov edx,CollisionBlockPTR
				DEC (CELL PTR [edx]).HitCount
				movzx edi, (CELL PTR [edx]).HitCount
				.IF edi == 1
					mov (CELL PTR [edx]).Color,HitColor
				.ENDIF
				mUP_Right
			.ELSEIF 
				INVOKE IsAtScreenEdge,CurrentPosition
				.IF eax!=NoCollision && eax!= DeadBall
					mUP_Right
				.ELSEIF eax == DeadBall
					mov edx,Ball_Cell
					mov (BALL_ PTR[edx]).Active,0
					mov edx,Lifes
					mov eax,DWORD PTR [edx]
					dec eax
					mov DWORD PTR [edx],eax
					INVOKE LifeCheck,				oHandle,	eax,		ADDR Ball
				.ELSE 
					INVOKE SetNextBallPosition,Ball_Cell,CurrentPosition
				.ENDIF
			.ENDIF
			JMP END_PROC
DOWN_LEFTL:	DEC CurrentPosition.X
 			INC CurrentPosition.Y
			INVOKE FindCollision,Blocks_Matrix, CurrentPosition,ADDR CollisionBlockPTR
			.IF eax != NoCollision
				mov edx,CollisionBlockPTR
				DEC (CELL PTR [edx]).HitCount
				movzx edi, (CELL PTR [edx]).HitCount
				.IF edi == 1
					mov (CELL PTR [edx]).Color,HitColor
				.ENDIF
				mDown_Left
			.ELSEIF 
				INVOKE IsAtScreenEdge,CurrentPosition
				.IF eax!=NoCollision && eax != DeadBall
					mDown_Left
				.ELSEIF eax == DeadBall
					mov edx,Ball_Cell
					mov (BALL_ PTR[edx]).Active,0
					mov edx,Lifes
					mov eax,DWORD PTR [edx]
					dec eax
					mov DWORD PTR [edx],eax
					INVOKE LifeCheck,				oHandle,	eax,		ADDR Ball
				.ELSE 
					INVOKE SetNextBallPosition,Ball_Cell,CurrentPosition
				.ENDIF
			.ENDIF
			JMP END_PROC
DOWN_RIGHTL:	INC CurrentPosition.X
			INC CurrentPosition.Y
			INVOKE FindCollision,Blocks_Matrix, CurrentPosition,ADDR CollisionBlockPTR
				.IF eax != NoCollision
				mov edx,CollisionBlockPTR
				DEC (CELL PTR [edx]).HitCount
				movzx edi, (CELL PTR [edx]).HitCount
				.IF edi == 1
					mov (CELL PTR [edx]).Color,HitColor
				.ENDIF
				mDown_Right
			.ELSEIF 
				INVOKE IsAtScreenEdge,CurrentPosition
				.IF eax!=NoCollision && eax != DeadBall
					mDown_Right
				.ELSEIF eax == DeadBall
					mov edx,Ball_Cell
					mov (BALL_ PTR[edx]).Active,0
					mov edx,Lifes
					mov eax,DWORD PTR [edx]
					dec eax
					mov DWORD PTR [edx],eax
					INVOKE LifeCheck,				oHandle,	eax,		ADDR Ball
				.ELSE 
					INVOKE SetNextBallPosition,Ball_Cell,CurrentPosition
				.ENDIF
			.ENDIF
END_PROC:   popad
			ret
NextBallPosition ENDP
SetNextBallPosition PROC,
			Ball_Cell:PTR BALL_,
			NextPosition:COORD
			pushad
			mov edx,Ball_Cell
			movzx eax, (BALL_ PTR [edx]).CurrentPos.X
			mov (BALL_ PTR [edx]).PrevPos.X, ax
			movzx eax, (BALL_ PTR [edx]).CurrentPos.Y
			mov (BALL_ PTR [edx]).PrevPos.Y, ax
			movzx eax, NextPosition.X
			mov (BALL_ PTR [edx]).CurrentPos.X, ax
			movzx eax, NextPosition.Y
			mov (BALL_ PTR [edx]).CurrentPos.Y, ax
			popad
			ret
SetNextBallPosition ENDP


IsAtScreenEdge PROC,				;this function return 0 in EAX if Ball is in window,1 if BALL is window edge and 2 if ball fall
			Position:COORD
			mov eax,0
			.IF Position.x>=GameWindow_Width
				mov eax,Right_Collision
			.ELSEIF Position.X<=0
				mov eax,Left_Collision
			.ELSEIF Position.Y<=StartLinePosition
				mov eax,TopBottom_Collision
			.ELSEIF Position.Y>=GameWindow_height
				mov eax,4
			.ENDIF
			ret
IsAtScreenEdge ENDP
MovBall PROC,
		oHandle:HANDLE,
		BALL_CELL:PTR BALL_,
		Blocks_Matrix:PTR CELL,
		Time_Info:PTR DWORD,
		Lifes:PTR DWORD
		pushad
		mov edx,Time_info
		mov eax,[edx]
		.IF eax>=Ball_Speed
			INVOKE DeleteBallCell,ohandle,BaLL_CELL
			INVOKE NextBallPosition,ohandle, BAll_CeLL,Blocks_Matrix,Lifes
			INVOKE WriteBallCell,ohandle,Ball_CeLL
			mov edx,Time_info
			mov eax,[edx]
			mov WORD PTR[edx],0 
			JMP END_P
		.ENDIF
		mov edx,Time_info
		mov eax,[edx]
		INC eax
		mov [edx],eax
END_P:
		popad
		ret
MovBall ENDP
SetStartPosition PROC,
		Pad_Cell:PTR CELL,
		Ball_Cell:PTR BALL_
		LOCAL	tempc:COORD,
				tempp:COORD,
				randomVal:DWORD
		pushad
		mov eax,GameWindow_Width
		INVOKE RandomRange
		mov randomVal,eax
		mov edx,Pad_Cell
		mov edi,Ball_Cell
		mov (CELL PTR [edx]).Area_Position.Left,ax
		mov ebx,Pad_Width
		add eax,ebx
		dec eax
		mov (CELL PTR [edx]).Area_Position.Right,ax
		dec eax
		dec eax
		mov (BALL_ PTR [edi]).CurrentPos.X,ax
		dec eax
		mov (BALL_ PTR [edi]).PrevPos.X,ax
		mov eax,GameWindow_Height
		dec eax
		mov (CELL PTR [edx]).Area_Position.Bottom,ax
		sub eax,Pad_Height
		mov (BALL_ PTR [edi]).CurrentPos.Y,ax
		inc eax
		mov (CELL PTR [edx]).Area_Position.Top,ax
		mov (BALL_ PTR [edi]).PrevPos.Y,ax








		

		popad
		ret
SetStartPosition ENDP



END


