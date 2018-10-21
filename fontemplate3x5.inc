;==========================================================================================================================
;--------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------- fontemplate3x5.inc -----------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------ Authors: ----------------------------------------------------------
;---------------------------------------------- Turkmanovic Haris 516/2014 ------------------------------------------------
;----------------------------------------------- Vukoje David 541/2014 ----------------------------------------------------
;==========================================================================================================================
;Description:
;	This include file contain font templates which size is 3 screen point width and 5 screen point hight
;	This include file is create to storage tempaltes for digit.This digit is used with points but can be used by other text
;	In this include file you can import template for other font which size is 3x5
;==========================================================================================================================

;This part of code contain default font information like font color and font backround
Font_Block		= 219
Font_Color		= Red
Font_Backround	= 80h

Point			TEXTEQU		<<Font_Block,Font_Color>>
None			TEXTEQU		<<0,Font_Backround>>

.data
Letter_Size1	COORD <3,5>

;This is template for SPACE char
Delete_font10	_CHAR_INFO None,None,None
Delete_font11   _CHAR_INFO None,None,None
Delete_font12	_CHAR_INFO None,None,None
Delete_font13   _CHAR_INFO None,None,None
Delete_font14   _CHAR_INFO None,None,None

;This is template for Digit 1
Number_One  _CHAR_INFO None,None,Point
Number_One1  _CHAR_INFO None,none,Point
Number_One2  _CHAR_INFO none,None,Point
Number_One3  _CHAR_INFO None,None,Point
Number_One4  _CHAR_INFO None,None,Point

;This is template for Digit 2
Number_Two  _CHAR_INFO Point,Point,Point
Number_Two1  _CHAR_INFO None,None,Point
Number_Two2  _CHAR_INFO Point,Point,Point
Number_Two3  _CHAR_INFO point,None,None
Number_Two4  _CHAR_INFO Point,Point,Point

;This is template for Digit 3
Number_Three  _CHAR_INFO Point,Point,Point
Number_Three1  _CHAR_INFO None,None,Point
Number_Three2  _CHAR_INFO Point,Point,Point
Number_Three3  _CHAR_INFO none,none,point
Number_Three4  _CHAR_INFO Point,Point,Point

;This is template for Digit 4
Number_Four  _CHAR_INFO Point,none,Point
Number_FOur1  _CHAR_INFO point,None,Point
Number_Four2  _CHAR_INFO Point,Point,Point
Number_Four3  _CHAR_INFO none,none,point
Number_Four4  _CHAR_INFO none,none,Point

;This is template for Digit 5
Number_Five  _CHAR_INFO Point,Point,Point
Number_Five1  _CHAR_INFO Point,None,None
Number_Five2  _CHAR_INFO Point,Point,Point
Number_Five3  _CHAR_INFO None,None,Point
Number_Five4  _CHAR_INFO Point,Point,Point

;This is template for Digit 6
Number_Six  _CHAR_INFO Point,Point,Point
Number_Six1  _CHAR_INFO Point,None,None
Number_Six2  _CHAR_INFO Point,Point,Point
Number_Six3  _CHAR_INFO Point,None,Point
Number_Six4  _CHAR_INFO Point,Point,Point

;This is template for Digit 7
Number_Seven  _CHAR_INFO Point,Point,Point
Number_Seven1  _CHAR_INFO none,none,Point
Number_Seven2  _CHAR_INFO none,none,Point
Number_Seven3  _CHAR_INFO none,none,Point
Number_Seven4  _CHAR_INFO none,none,Point

;This is template for Digit 8
Number_Eight  _CHAR_INFO Point,Point,Point
Number_Eight1  _CHAR_INFO Point,None,Point
Number_Eight2  _CHAR_INFO Point,point,point
Number_Eight3  _CHAR_INFO Point,None,Point
Number_Eight4  _CHAR_INFO Point,point,Point

;This is template for Digit 9
Number_Nine  _CHAR_INFO Point,Point,Point
Number_Nine1  _CHAR_INFO Point,None,Point
Number_Nine2  _CHAR_INFO Point,point,point
Number_Nine3  _CHAR_INFO none,None,Point
Number_Nine4  _CHAR_INFO none,none,Point

;This is template for Digit 0
Number_Zero  _CHAR_INFO Point,Point,Point
Number_Zero1  _CHAR_INFO Point,None,Point
Number_Zero2  _CHAR_INFO Point,none,point
Number_Zero3  _CHAR_INFO Point,None,Point
Number_Zero4  _CHAR_INFO Point,point,Point