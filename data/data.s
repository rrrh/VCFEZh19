
	.setcpu         "65816"

	.export _sin_table_s
	.export _sin_table_us
	.export _sin_text

	.export _res_snd_code

	.export _font_9x16_tiles_clr
	.export _font_9x16_tiles_pic

	.export _snd_code

	.export _img_A_pic
	.export _img_A_clr
	.export _img_A_map

.segment "PAD"

.segment "RODATA"

_sin_table_s:
	.include "data/utils/sin_table_s.s"

_sin_table_us:
	.include "data/utils/sin_table_us.s"

_sin_text:
	.include "data/text_sin.s"
	.include "data/text_sin_rev.s"
;_circles:
;	.include "circles.s"

_res_snd_code:
;    .incbin "snd/SND_CORE.OBJ"

.segment "GFX01"

_snd_code:
	.incbin "snd/Skyrunner-One_Effect_Demo-Final.raw"

.segment "GFX02"

_img_A_pic:
;	.incbin "data/imgs/Freaks_1_4bpp.pic"
	.incbin "data/imgs/Mainframe_3_4bpp.pic"
;	.incbin "data/imgs/Woman_1_4bpp.pic"

_img_A_clr:
;	.incbin "data/imgs/Freaks_1_4bpp.clr"
	.incbin "data/imgs/Mainframe_3_4bpp.clr"
	;.incbin "data/imgs/Woman_1_4bpp.clr"

_img_A_map:
;	.incbin "data/imgs/Freaks_1_4bpp.map"
	.incbin "data/imgs/Mainframe_3_4bpp.map"
	;.incbin "data/imgs/Woman_1_4bpp.map"



.segment "GFX03"
.segment "GFX04"
.segment "GFX05"
.segment "GFX06"
.segment "GFX07"
.segment "GFX08"
.segment "GFX09"
.segment "GFX0A"
.segment "GFX0B"
.segment "GFX0C"
.segment "GFX0D"
.segment "GFX0E"
.segment "GFX0F"

_font_9x16_tiles_clr:
	.incbin "data/font_9x16_tiles.clr"

_font_9x16_tiles_pic:
	.incbin "data/font_9x16_tiles.pic"


;.segment "GFX10"
;.segment "GFX11"
;.segment "GFX12"
;.segment "GFX13"
;.segment "GFX14"
;.segment "GFX15"
;.segment "GFX16"
;.segment "GFX17"
;.segment "GFX18"
;.segment "GFX19"
;.segment "GFX1A"
;.segment "GFX1B"
;.segment "GFX1C"
;.segment "GFX1D"
;.segment "GFX1E"
;.segment "GFX1F"



;.segment "GFX20"
;.segment "GFX21"
;.segment "GFX22"
;.segment "GFX23"
;.segment "GFX24"
;.segment "GFX25"
;.segment "GFX26"
;.segment "GFX27"
;.segment "GFX28"
;.segment "GFX29"
;.segment "GFX2A"
;.segment "GFX2B"
;.segment "GFX2C"
;.segment "GFX2D"
;.segment "GFX2E"
;.segment "GFX2F"

















