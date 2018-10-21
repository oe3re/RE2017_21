;==========================================================================================================================
;--------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------- fontemplate9x13.inc ----------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------ Authors: ----------------------------------------------------------
;---------------------------------------------- Turkmanovic Haris 516/2014 ------------------------------------------------
;----------------------------------------------- Vukoje David 541/2014 ----------------------------------------------------
;==========================================================================================================================
;Description:
;	This include file contain font templates which size is 9 screen point width and 13 screen point hight
;	This include file is create special for draw ETF logo
;	In this include file you need to import template for other font which size is 9x13
;==========================================================================================================================

;This part of code contain default font information like font color and font backround

Font_Block		= 219
Font_Color		= Red
Font_Backround	= 80h

Point		TEXTEQU <<Font_Block,Font_Color>>
None		TEXTEQU <<0,Font_Backround>>
.data
Letter_Size3 COORD <9,13>

ETF_Logo	_CHAR_INFO Point,Point,Point,Point,Point,Point,Point,Point,Point
ETF_logo1	_CHAR_INFO Point, None, None, None, None, None, None, None,Point
ETF_logo2   _CHAR_INFO Point, None,Point,Point,Point,Point,Point, None,Point
ETF_logo3	_CHAR_INFO Point, None, None, None,Point, None, None, None,Point
ETF_logo4	_CHAR_INFO Point, None, None,Point,Point,Point, None, None,Point
ETF_logo5	_CHAR_INFO Point, None,Point, None,Point, None,Point, None,Point
ETF_logo6	_CHAR_INFO Point,Point,Point,Point,Point,Point,Point,Point,Point
ETF_logo7	_CHAR_INFO Point, None,Point, None,Point, None,Point, None,Point
ETF_logo8	_CHAR_INFO Point, None, None,Point,Point,Point, None, None,Point
ETF_logo9	_CHAR_INFO Point, None, None, None,Point, None, None, None,Point
ETF_logo10	_CHAR_INFO Point, None,Point,Point,Point,Point,Point, None,Point
ETF_logo11	_CHAR_INFO Point, None, None, None, None, None, None, None,Point
ETF_logo12	_CHAR_INFO Point,Point,Point,Point,Point,Point,Point,Point,Point