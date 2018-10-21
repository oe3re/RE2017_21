;==========================================================================================================================
;--------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------- fontemplate5x7.inc ----------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------
;------------------------------------------------------ Authors: ----------------------------------------------------------
;---------------------------------------------- Turkmanovic Haris 516/2014 ------------------------------------------------
;------------------------------------------------- Vukoje David 541/2014 --------------------------------------------------
;==========================================================================================================================
;Description:
;	This include file contain font templates which size is 5 screen point width and 7 screen point hight
;	This include file is create to storage templates for Letter.This letter is used in welcomeScreen 
;	In this include file you can import template for other font which size is 5x7
;	Here are the fonts that are used but can be added afterwards
;==========================================================================================================================

;This part of code contain default font information like font color and font backround

Font_Block		= 219
Font_Color		= Red
Font_Backround	= 80h

Point			TEXTEQU <<Font_Block,Font_Color>>
None			TEXTEQU <<0,Font_Backround>>

.data
Letter_Size2 COORD <5,7>

;This is template for SPACE char
Delete_Font20 _CHAR_INFO None,None,None,None,None
Delete_Font21 _CHAR_INFO None,None,None,None,None
Delete_Font22 _CHAR_INFO None,None,None,None,None
Delete_Font23 _CHAR_INFO None,None,None,None,None
Delete_Font24 _CHAR_INFO None,None,None,None,None
Delete_Font25 _CHAR_INFO None,None,None,None,None
Delete_Font26 _CHAR_INFO None,None,None,None,None

;This is template for Letter A
A_Letter_20 _CHAR_INFO Point,Point,Point,Point,Point
A_Letter_21 _CHAR_INFO Point,None,None,None,Point
A_Letter_22 _CHAR_INFO Point,None,None,None,Point
A_Letter_23 _CHAR_INFO Point,Point,Point,Point,Point
A_Letter_24 _CHAR_INFO Point,None,None,None,Point
A_Letter_25 _CHAR_INFO Point,None,None,None,Point
A_Letter_26 _CHAR_INFO Point,None,None,None,Point

;This is template for Letter R
R_Letter_20 _CHAR_INFO Point,Point,Point,None,None
R_Letter_21 _CHAR_INFO Point,None,None,Point,None
R_Letter_22 _CHAR_INFO Point,None,None,None,Point
R_Letter_23 _CHAR_INFO Point,None,None,Point,None
R_Letter_24 _CHAR_INFO Point,Point,Point,None,None
R_Letter_25 _CHAR_INFO Point,None,None,Point,None
R_Letter_26 _CHAR_INFO Point,None,None,None,Point

;This is template for Letter K
K_Letter_20 _CHAR_INFO Point,None,None,None,Point
K_Letter_21 _CHAR_INFO Point,None,None,Point,None
K_Letter_22 _CHAR_INFO Point,None,Point,None,None
K_Letter_23 _CHAR_INFO Point,Point,None,None,None
K_Letter_24 _CHAR_INFO Point,None,Point,None,None
K_Letter_25 _CHAR_INFO Point,None,None,Point,None
K_Letter_26 _CHAR_INFO Point,None,None,None,Point

;This is template for Letter N
N_Letter_20 _CHAR_INFO Point,None,None,None,Point
N_Letter_21 _CHAR_INFO Point,None,None,None,Point
N_Letter_22 _CHAR_INFO Point,Point,None,None,Point
N_Letter_23 _CHAR_INFO Point,None,Point,None,Point
N_Letter_24 _CHAR_INFO Point,None,None,Point,Point
N_Letter_25 _CHAR_INFO Point,None,None,None,Point
N_Letter_26 _CHAR_INFO Point,None,None,None,Point

;This is template for Letter O
O_Letter_20 _CHAR_INFO Point,Point,Point,Point,Point
O_Letter_21 _CHAR_INFO Point,None,None,None,Point
O_Letter_22 _CHAR_INFO Point,None,None,None,Point
O_Letter_23 _CHAR_INFO Point,None,None,None,Point
O_Letter_24 _CHAR_INFO Point,None,None,None,Point
O_Letter_25 _CHAR_INFO Point,None,None,None,Point
O_Letter_26 _CHAR_INFO Point,Point,Point,Point,Point

;This is template for Letter I
I_Letter_20 _CHAR_INFO None,None,Point,None,None
I_Letter_21 _CHAR_INFO None,None,Point,None,None
I_Letter_22 _CHAR_INFO None,None,Point,None,None
I_Letter_23 _CHAR_INFO None,None,Point,None,None
I_Letter_24 _CHAR_INFO None,None,Point,None,None
I_Letter_25 _CHAR_INFO None,None,Point,None,None
I_Letter_26 _CHAR_INFO None,None,Point,None,None

;This is template for Letter D
D_Letter_20 _CHAR_INFO Point,Point,Point,None,None
D_Letter_21 _CHAR_INFO Point,None,None,Point,None
D_Letter_22 _CHAR_INFO Point,None,None,None,Point
D_Letter_23 _CHAR_INFO Point,None,None,None,Point
D_Letter_24 _CHAR_INFO Point,None,None,None,Point
D_Letter_25 _CHAR_INFO Point,None,None,Point,None
D_Letter_26 _CHAR_INFO Point,Point,Point,None,None

;This is template for Letter G
G_Letter_20 _CHAR_INFO None, None, Point,Point, None
G_Letter_21 _CHAR_INFO None, Point, None, None,Point
G_Letter_22 _CHAR_INFO Point, None, None, None,Point
G_Letter_23 _CHAR_INFO Point, None, None, None, None
G_Letter_24 _CHAR_INFO Point, None, None,Point,Point
G_Letter_25 _CHAR_INFO None ,Point, None, None,Point
G_Letter_26 _CHAR_INFO None , None, Point,Point,None

;This is template for Letter M
M_Letter_20 _CHAR_INFO Point, None, None, None,Point
M_Letter_21 _CHAR_INFO Point,Point, None,Point,Point
M_Letter_22 _CHAR_INFO Point, None,Point, None,Point
M_Letter_23 _CHAR_INFO Point, None, None, None,Point
M_Letter_24 _CHAR_INFO Point, None, None, None,Point
M_Letter_25 _CHAR_INFO Point, None, None, None,Point
M_Letter_26 _CHAR_INFO Point, None, None, None,Point

;This is template for Letter E
E_Letter_20 _CHAR_INFO Point,Point,Point,Point,Point
E_Letter_21 _CHAR_INFO Point, None, None, None, None
E_Letter_22 _CHAR_INFO Point, None, None, None, None
E_Letter_23 _CHAR_INFO Point,Point,Point,Point, None
E_Letter_24 _CHAR_INFO Point, None, None, None, None
E_Letter_25 _CHAR_INFO Point, None, None, None, None
E_Letter_26 _CHAR_INFO Point,Point,Point,Point,Point

;This is template for Letter V
V_Letter_20 _CHAR_INFO Point, None, None, None,Point
V_Letter_21 _CHAR_INFO Point, None, None, None,Point
V_Letter_22 _CHAR_INFO Point, None, None, None,Point
V_Letter_23 _CHAR_INFO  None,Point, None,Point, None 
V_Letter_24 _CHAR_INFO  None,Point, None,Point, None
V_Letter_25 _CHAR_INFO  None, None,Point, None, None
V_Letter_26 _CHAR_INFO  None, None,Point, None, None