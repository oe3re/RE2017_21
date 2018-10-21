;==========================================================================================================================
;--------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------- Function.inc --------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------ Authors: ----------------------------------------------------------
;---------------------------------------------- Turkmanovic Haris 516/2014 ------------------------------------------------
;----------------------------------------------- Vukoje David 541/2014 ----------------------------------------------------
;==========================================================================================================================
;Description:
;	This .inc file contains declaration of function which is located in windows system Libraries such as kernel32.lin and
;user32.lib . These declaration are necessary because they are not directly declared in Irvine32.lib
;==========================================================================================================================


INCLUDE Irvine32.inc
FreeConsole PROTO
AllocConsole PROTO

WriteConsoleOutputA PROTO ,
			oHandle:HANDLE,
			ArrayForRead:PTR _CHAR_INFO,
			SizeOfArrayForRead:COORD,
			StartPositionForRead:COORD,
			ScreenBufferAreaForWrite:PTR SMALL_RECT
WriteConsoleOutputW PROTO ,
			oHandle:HANDLE,
			ArrayForRead:PTR _CHAR_INFO,
			SizeOfArrayForRead:COORD,
			StartPositionForRead:COORD,
			ScreenBufferAreaForWrite:PTR SMALL_RECT
WriteConsoleOutputCharacterW PROTO,
			hConsoleOutput:HANDLE,
			lpCharacter:PTR WORD,
			nLength:DWORD,
			dwWriteCoord:COORD,
			lpNumberOfCharsWritten:PTR DWORD
SetConsoleCursorPosition PROTO,
            hConsoleOutput:HANDLE,
			wCursorPosition:COORD
ReadConsoleOutputA PROTO ,
			oHandle:HANDLE,
			ArrayForRead:PTR _CHAR_INFO,
			SizeOfArrayForRead:COORD,
			StartPositionForRead:COORD,
			ScreenBufferAreaForWrite:PTR SMALL_RECT
CreateConsoleScreenBuffer PROTO,
			dwDesiredAccess			:DWORD ,
			dwShareMode				:DWORD ,
			lpSecurityAttributes	:PTR _SECURITY_ATTRIBUTES ,
            dwFlags					:DWORD,
			lpScreenBufferData		:PTR DWORD  
SetConsoleActiveScreenBuffer PROTO,
			handlee:HANDLE   
FillConsoleOutputAttribute PROTO,
			hConsoleOutput:HANDLE,
			lpCharacter:WORD,
			nLength:DWORD,
			dwWriteCoord:COORD,
			lpNumberOfCharsWritten:PTR DWORD  
WriteConsoleOutputW PROTO ,
			oHandle:HANDLE,
			ArrayForRead:PTR _CHAR_INFO,
			SizeOfArrayForRead:COORD,
			StartPositionForRead:COORD,
			ScreenBufferAreaForWrite:PTR SMALL_RECT       




_CHAR_INFO STRUCT
		AsciiChar WORD 219
		Attributes WORD 0
_CHAR_INFO ENDS

_SECURITY_ATTRIBUTES STRUCT 
		nLength DWORD 0 
		lpSecurityDescriptor DWORD 0
   bInheritHandle DWORD 0
_SECURITY_ATTRIBUTES ENDS



