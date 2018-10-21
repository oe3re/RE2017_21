INCLUDE Additionaldef.inc
INCLUDE WelcomeScreen.inc
INCLUDE Configuration.inc
INCLUDE Function.inc
INCLUDE Structure.inc
INCLUDE Font.inc


.code

;This is procedure which create WelcomeScreen.
WriteWelcomeScreen PROC,
		oHandle			:HANDLE,
		StartColor		:DWORD
		LOCAL temp:DWORD,ArrPTR:DWORD
.data
WSBackround				_CHAR_INFO		WSBackroundAreaSize	 DUP(<0,WSBackroundColor>)
WSBackroundSize			COORD			<WelcomeScreen_Width,WelcomeScreen_Hight>
WSBackroundStartPosition COORD			<0,0>	
WSBackroundArea			SMALL_RECT		<0,0,WelcomeScreen_Width-1,WelcomeScreen_Hight-1>
WSTemp					DWORD			0
WSString1				BYTE			"U N I V E R Z I T E T   U   B E O G R A D U",0
WSString2				BYTE			"E L E K T R O T E H N I C K I    F A K U L T E T",0
WSString3				BYTE			"K A T E D R A    Z A    E L E K T R O N I K U",0
WSString4				BYTE			"I g r i c u    r e a l i z o v a l i :",0
WSString5				BYTE			"T U R K M A N O V I C    H A R I S ",0
WSString6				BYTE			"V U K O J E    D A V I D ",0
WSString1Size			DWORD			0
WSString2Size			DWORD			0
WSString3Size			DWORD			0
WSString4Size			DWORD			0
WSString5Size			DWORD			0
WSString6Size			DWORD			0
WSString1Attribute		WORD			Blue
WSString2Attribute		WORD			Red
WSString3Attribute		WORD			Red
WSString4Attribute		WORD			Blue
WSString5Attribute		WORD			Red
WSString6Attribute		WORD			Red
WSString1StartPosition	COORD			<StartTextAreaPositionX+2,StartTextAreaPositionY+2>
WSString2StartPosition	COORD			<StartTextAreaPositionX,StartTextAreaPositionY+7>
WSString3StartPosition	COORD			<StartTextAreaPositionX+2,StartTextAreaPositionY+9>
WSString4StartPosition	COORD			<StartTextAreaPositionX+1,WelcomeScreen_Hight-5>
WSString5StartPosition	COORD			<StartTextAreaPositionX+1,WelcomeScreen_Hight-3>
WSString6StartPosition	COORD			<StartTextAreaPositionX+7,WelcomeScreen_Hight-1>
WSLine					_CHAR_INFO		100 DUP(<223,WSLineColor>)
WSLineSize				COORD			<0,1>
WSLineStartPosition		COORD			<0,0>
WSLineArea1				SMALL_RECT      <StartTextAreaPositionX,StartTextAreaPositionY,0,StartTextAreaPositionY+1>
WSLineArea2				SMALL_RECT      <StartTextAreaPositionX,StartTextAreaPositionY+4,0,StartTextAreaPositionY+5>
WSLineArea3				SMALL_RECT      <StartTextAreaPositionX,StartTextAreaPositionY+11,0,StartTextAreaPositionY+12>
MaxStringSize			DWORD			0
WSETFLogoStartPosition  COORD           <0,0>
WSETFLogoColor			DWORD			Red
WSArkanoidString        WORD			'A','R','K','A','N','O','I','D'
WSArkanoidStringSize	DWORD			8
WSArkanoidColor			DWORD			Blue,Red,Green,Yellow,Blue,Red,Green,Yellow
WSArkanoidStartPosition COORD			<0,0>
WSArkanoidXindent		DWORD			3
WSArkanoidYindent		DWORD			4


.code
		
		pushad
		INVOKE SetConsoleCursorInfo,ohandle,ADDR Cursor_Info
		INVOKE SetStartWindow, oHandle, WelcomeScreenBufferSize,ADDR WelcomeScreenWindowSize, ADDR AppTitle
		INVOKE WriteConsoleOutputA,	oHandle,	ADDR WSBackround,	WSBackroundSize,WSBackroundStartPosition,ADDR WSBackroundArea	
		
		mov eax,StartTextAreaPositionY
		sub eax,1
		mov WSETFLogoStartPosition.Y,ax
		mov eax,StartTextAreaPositionX
		sub eax,11
		mov WSETFLogoStartPosition.X,ax
		add eax,WSArkanoidXindent
		mov WSArkanoidStartPosition.X,ax
		movzx eax,WSLineArea3.Bottom
		add eax,WSArkanoidYindent
		mov WSArkanoidStartPosition.Y,ax

		INVOKE WriteLetter,	ohandle, ETF_LOGO_CODE,WSETFLogoStartPosition,3 ,WSETFLogoColor
		
		mov eax,WSBackroundColor
		or  ax,WSString1Attribute
		mov WSString1Attribute,ax
		mov eax,WSBackroundColor
		or  ax,WSString2Attribute
		mov WSString2Attribute,ax
		mov eax,WSBackroundColor
		or  ax,WSString3Attribute
		mov WSString3Attribute,ax
		mov eax,WSBackroundColor
		or  ax,WSString4Attribute
		mov WSString4Attribute,ax
		mov eax,WSBackroundColor
		or  ax,WSString5Attribute
		mov WSString5Attribute,ax
		mov eax,WSBackroundColor
		or  ax,WSString6Attribute
		mov WSString6Attribute,ax


		mov eax,LENGTHOF WSString1
		mov WSString1Size,eax
		.IF eax>MaxStringSize
			mov MaxStringSize,eax
		.ENDIF
		mov eax,LENGTHOF WSString2
		mov WSString2Size,eax
		.IF eax>MaxStringSize
			mov MaxStringSize,eax
		.ENDIF
		mov eax,LENGTHOF WSString3
		mov WSString3Size,eax
		.IF eax>MaxStringSize
			mov MaxStringSize,eax
		.ENDIF
		mov eax,MaxStringSize
		mov WSLineSize.X,ax
		movzx ecx,WsLineArea1.Left
		add eax,ecx
		mov WSLineArea1.Right,ax
		mov WSLineArea2.Right,ax
		mov WSLineArea3.Right,ax

		mov eax,LENGTHOF WSString4
		mov WSString4Size,eax
		mov eax,LENGTHOF WSString5
		mov WSString5Size,eax
		mov eax,LENGTHOF WSString6
		mov WSString6Size,eax




		INVOKE WriteConsoleOutputA,	oHandle,	ADDR WSLine,	WSLineSize,WSLineStartPosition,ADDR WSLineArea1
		INVOKE WriteConsoleOutputA,	oHandle,	ADDR WSLine,	WSLineSize,WSLineStartPosition,ADDR WSLineArea2
		INVOKE WriteConsoleOutputA,	oHandle,	ADDR WSLine,	WSLineSize,WSLineStartPosition,ADDR WSLineArea3

		INVOKE SetConsoleCursorPosition,ohandle,WSString1StartPosition
		mov edx,OFFSET WSString1
		INVOKE WriteString
		INVOKE FillConsoleOutputAttribute, ohandle, WSString1Attribute	,WSString1Size,WSString1StartPosition,ADDR WSTemp

		INVOKE SetConsoleCursorPosition,ohandle,WSString2StartPosition
		mov edx,OFFSET WSString2
		INVOKE WriteString
		INVOKE FillConsoleOutputAttribute, ohandle, WSString2Attribute	,WSString2Size,WSString2StartPosition,ADDR WSTemp

		INVOKE SetConsoleCursorPosition,ohandle,WSString3StartPosition
		mov edx,OFFSET WSString3
		INVOKE WriteString
		INVOKE FillConsoleOutputAttribute, ohandle, WSString3Attribute	,WSString3Size,WSString3StartPosition,ADDR WSTemp
		
		INVOKE SetConsoleCursorPosition,ohandle,WSString4StartPosition
		mov edx,OFFSET WSString4
		INVOKE WriteString
		INVOKE FillConsoleOutputAttribute, ohandle, WSString4Attribute	,WSString4Size,WSString4StartPosition,ADDR WSTemp

		INVOKE SetConsoleCursorPosition,ohandle,WSString5StartPosition
		mov edx,OFFSET WSString5
		INVOKE WriteString
		INVOKE FillConsoleOutputAttribute, ohandle, WSString5Attribute	,WSString5Size,WSString5StartPosition,ADDR WSTemp

		INVOKE SetConsoleCursorPosition,ohandle,WSString6StartPosition
		mov edx,OFFSET WSString6
		INVOKE WriteString
		INVOKE FillConsoleOutputAttribute, ohandle, WSString6Attribute	,WSString6Size,WSString6StartPosition,ADDR WSTemp
		
		
		mov edx,WS_Time_Duration
		.WHILE !SIGN?
			mov eax,WSFontRefreshTime
			INVOKE Delay
			Invoke WriteBigString,ohandle,ADDR WSArkanoidString ,WSArkanoidStringSize,2,ADDR WSArkanoidColor	,WSArkanoidStartPosition,2	
				
			push edx
			mov edi,OFFSET WSArkanoidColor
			mov ArrPTR,edi
			add edi,28
			mov esi,edi
			sub esi,TYPE DWORD
			mov eax,DWORD PTR [edi]
			mov temp,eax
				
			.WHILE edi!=ArrPTR
				mov eax,DWORD PTR[esi]
				mov DWORD PTR[edi],eax
				SUB esi,TYPE DWORD
				sub edi,TYPE DWORD
			.ENDW
			mov eax,temp
			mov DWORD PTR [edi],eax
			pop edx			
			dec edx
			CMP edx,0
		.ENDW
		popad
		Ret
WriteWelcomeScreen ENDP

END