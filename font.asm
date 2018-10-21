INCLUDE Additionaldef.INC
INCLUDE Font.Inc
INCLUDE fontemplate3x5.INC
INCLUDE fontemplate5x7.INC
INCLUDE fontemplate9x13.INC

.code
CreateLetter PROC,
				oHandle			:HANDLE,
				Array_size		:COORD,
				Start_Position	:COORD,
				Letter_Array	:PTR _CHAR_INFO,
				Letter_Color	:DWORD

				LOCAL	ToWriteArea			:SMALL_RECT,
						WriteStartPosition	:COORD

				pushad
				
				mov eax,Letter_Color
				CMP eax,0
				.IF !SIGN?;If Color >=0 than we change color
					mov edx,Letter_Array
					movzx eax,Array_Size.x
					movzx ecx,Array_Size.Y
					mul ecx
					mov ecx,eax
					mov edx,Letter_Array
					.WHILE ecx>0
						 mov eax,Letter_Color
						 movzx edi,(_CHAR_INFO PTR [edx]).Attributes
						 .IF edi != Font_Backround
						 mov (_CHAR_INFO PTR [edx]).Attributes,ax
						 .ENDIF
						 dec ecx
						 add edx,TYPE _CHAR_INFO
					.ENDW

				.ENDIF


				movzx eax,Start_Position.X
				mov ToWriteArea.Left,ax
				movzx eax,Start_Position.Y
				mov ToWriteArea.Top,ax
				movzx eax,Array_Size.x
				movzx ecx,Start_Position.X
				add eax,ecx
				mov ToWriteArea.Right,ax
				movzx eax,Array_Size.Y
				movzx ecx,Start_Position.Y
				add eax,ecx
				mov ToWriteArea.Bottom,ax
				mov WriteStartPosition.X,0
				mov WriteStartPosition.Y,0
				INVOKE WriteConsoleOutputA,ohandle,Letter_Array,Array_Size,WriteStartPosition,ADDR ToWriteArea
				popad
				ret
CreateLetter ENDP

WriteLetter PROC,
				oHandle					:HANDLE,
				Ascii_Code				:WORD,
				Letter_Start_Position	:COORD,
				Font_Group				:WORD,
				Color					:DWORD
				pushad

				movzx eax,Ascii_Code
				.IF eax == DELETE_CODE
					movzx eax,Font_Group
					.IF eax == 1
						INVOKE CreateLetter,ohandle,Letter_Size1,Letter_Start_Position,ADDR Delete_font10,color
					.ELSEIF eax == 2
						INVOKE CreateLetter,ohandle,Letter_Size1,Letter_Start_Position,ADDR Delete_font20,color
					.ENDIF
				.ELSEIF eax == ETF_LOGO_CODE
					movzx eax,Font_Group
					.IF eax == 3
						INVOKE CreateLetter,ohandle,Letter_Size3,Letter_Start_Position,ADDR ETF_Logo,color
					.ENDIF
				.ELSEIF eax == '1' 
					movzx eax,Font_Group
					.IF eax == 1
						INVOKE CreateLetter,ohandle,Letter_Size1,Letter_Start_Position,ADDR NUMBER_ONE,color
					.ELSEIF eax == 2
					
					.ENDIF
				.ELSEIF eax == '2' 
					movzx eax,Font_Group
					.IF eax == 1
						INVOKE CreateLetter,ohandle,Letter_Size1,Letter_Start_Position,ADDR NUMBER_TWO,color
					.ELSEIF eax == 2
					
					.ENDIF
				.ELSEIF eax == '3' 
					movzx eax,Font_Group
					.IF eax == 1
						INVOKE CreateLetter,ohandle,Letter_Size1,Letter_Start_Position,ADDR NUMBER_THREE,color
					.ELSEIF eax == 2
					
					.ENDIF
				.ELSEIF eax == '4' 
					movzx eax,Font_Group
					.IF eax == 1
						INVOKE CreateLetter,ohandle,Letter_Size1,Letter_Start_Position,ADDR NUMBER_FOUR,color
					.ELSEIF eax == 2
					
					.ENDIF
				.ELSEIF eax == '5' 
					movzx eax,Font_Group
					.IF eax == 1
						INVOKE CreateLetter,ohandle,Letter_Size1,Letter_Start_Position,ADDR NUMBER_FIVE,color
					.ELSEIF eax == 2
					
					.ENDIF
				.ELSEIF eax == '6' 
					movzx eax,Font_Group
					.IF eax == 1
						INVOKE CreateLetter,ohandle,Letter_Size1,Letter_Start_Position,ADDR NUMBER_SIX,color
					.ELSEIF eax == 2
					
					.ENDIF
				.ELSEIF eax == '7' 
					movzx eax,Font_Group
					.IF eax == 1
						INVOKE CreateLetter,ohandle,Letter_Size1,Letter_Start_Position,ADDR NUMBER_SEVEN,color
					.ELSEIF eax == 2
					
					.ENDIF
				.ELSEIF eax == '8' 
					movzx eax,Font_Group
					.IF eax == 1
						INVOKE CreateLetter,ohandle,Letter_Size1,Letter_Start_Position,ADDR NUMBER_EIGHT,color
					.ELSEIF eax == 2
					
					.ENDIF
				.ELSEIF eax == '9' 
					movzx eax,Font_Group
					.IF eax == 1
						INVOKE CreateLetter,ohandle,Letter_Size1,Letter_Start_Position,ADDR NUMBER_NINE,color
					.ELSEIF eax == 2
					
					.ENDIF
				.ELSEIF eax == '0' 
					movzx eax,Font_Group
					.IF eax == 1
						INVOKE CreateLetter,ohandle,Letter_Size1,Letter_Start_Position,ADDR NUMBER_ZERO,color
					.ELSEIF eax == 2
					
					.ENDIF
				.ELSEIF eax == 'A'
				movzx eax,Font_Group
					.IF eax == 1
					.ELSEIF eax == 2
						INVOKE CreateLetter,ohandle,Letter_Size2,Letter_Start_Position,ADDR A_Letter_20	,color				
					.ENDIF
				.ELSEIF eax == 'R'
				movzx eax,Font_Group
					.IF eax == 1
					.ELSEIF eax == 2
						INVOKE CreateLetter,ohandle,Letter_Size2,Letter_Start_Position,ADDR R_Letter_20	,color				
					.ENDIF
				.ELSEIF eax == 'K'
				movzx eax,Font_Group
					.IF eax == 1
					.ELSEIF eax == 2
						INVOKE CreateLetter,ohandle,Letter_Size2,Letter_Start_Position,ADDR K_Letter_20	,color				
					.ENDIF
				.ELSEIF eax == 'N'
				movzx eax,Font_Group
					.IF eax == 1
					.ELSEIF eax == 2
						INVOKE CreateLetter,ohandle,Letter_Size2,Letter_Start_Position,ADDR N_Letter_20	,color				
					.ENDIF
				.ELSEIF eax == 'O'
				movzx eax,Font_Group
					.IF eax == 1
					.ELSEIF eax == 2
						INVOKE CreateLetter,ohandle,Letter_Size2,Letter_Start_Position,ADDR O_Letter_20	,color			
					.ENDIF
				.ELSEIF eax == 'I'
				movzx eax,Font_Group
					.IF eax == 1
					.ELSEIF eax == 2
						INVOKE CreateLetter,ohandle,Letter_Size2,Letter_Start_Position,ADDR I_Letter_20	,color				
					.ENDIF
				.ELSEIF eax == 'D'
				movzx eax,Font_Group
					.IF eax == 1
					.ELSEIF eax == 2
						INVOKE CreateLetter,ohandle,Letter_Size2,Letter_Start_Position,ADDR D_Letter_20,color					
					.ENDIF
				.ELSEIF eax == 'G'
			movzx eax,Font_Group
					.IF eax == 1
					.ELSEIF eax == 2
						INVOKE CreateLetter,ohandle,Letter_Size2,Letter_Start_Position,ADDR G_Letter_20,color					
					.ENDIF
				.ELSEIF eax == 'M'
			movzx eax,Font_Group
					.IF eax == 1
					.ELSEIF eax == 2
						INVOKE CreateLetter,ohandle,Letter_Size2,Letter_Start_Position,ADDR M_Letter_20,color					
					.ENDIF
				.ELSEIF eax == 'E'
			movzx eax,Font_Group
					.IF eax == 1
					.ELSEIF eax == 2
						INVOKE CreateLetter,ohandle,Letter_Size2,Letter_Start_Position,ADDR E_Letter_20,color					
					.ENDIF
				.ELSEIF eax == 'V'
			movzx eax,Font_Group
					.IF eax == 1
					.ELSEIF eax == 2
						INVOKE CreateLetter,ohandle,Letter_Size2,Letter_Start_Position,ADDR V_Letter_20,color					
					.ENDIF
				.ENDIF

				popad
				ret
WriteLetter ENDP
WriteBigString PROC,
				oHandle			:HANDLE,
				String			:PTR WORD,
				L				:DWORD,
				Font_Group		:WORD,
				Array_Font_Color:PTR DWORD,
				Start_Position	:COORD,
				Font_Step		:DWORD
				
				LOCAL	Letter_Start_Position	:COORD,
						Char					:WORD,
						Color					:DWORD
				pushad
				movzx eax,Start_Position.X
				mov Letter_Start_Position.X,ax
				movzx eax,Start_Position.Y
				mov Letter_Start_Position.Y,ax
				mov edx,String
				mov edi,Array_Font_Color				
				mov ecx,0
				.WHILE ecx<L
					movzx eax,WORD PTR [edx]
					mov char,ax
					mov eax,DWORD PTR [edi]
					mov Color,eax
					INVOKE WriteLetter,ohandle,Char,Letter_Start_Position,Font_Group,Color
					.IF Font_Group == 1
						movzx eax,Letter_Size1.x
					.ELSEIF Font_Group == 2
						movzx eax,Letter_Size2.x
					.ELSEIF Font_Group == 3
						movzx eax,Letter_Size3.x
					.ENDIF
					add eax,Font_Step
					add Letter_Start_Position.X,ax
					add edx,TYPE WORD
					add edi,TYPE DWORD
					INC ecx
				.ENDW
				popad
				ret
WriteBigString ENDP
END