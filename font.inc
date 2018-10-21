ETF_LOGO_CODE			= 2000
DELETE_CODE				= 2001






CreateLetter PROTO,
				oHandle			:HANDLE,
				Array_Size		:COORD,
				Start_Position	:COORD,
				Letter_Array	:PTR _CHAR_INFO,
				Letter_Color	:DWORD
WriteLetter PROTO,
				oHandle					:HANDLE,
				Ascii_Code				:WORD,
				Letter_Start_Position	:COORD,
				Font_Group				:WORD,
				Color					:DWORD

WriteBigString PROTO,
				oHandle			:HANDLE,
				String			:PTR WORD,
				L				:DWORD,
				Font_Group		:WORD,
				Array_Font_Color:PTR DWORD,
				Start_Position	:COORD,
				Font_Step		:DWORD


.data
Delete_Array		WORD 5 DUP(DELETE_CODE)











							
