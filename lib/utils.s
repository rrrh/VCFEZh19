;
; BSD 2-Clause License
;
; Copyright (c) 2017, rrrh
; All rights reserved.
;
; Redistribution and use in source and binary forms, with or without
; modification, are permitted provided that the following conditions are met:
;
; * Redistributions of source code must retain the above copyright notice, this
;   list of conditions and the following disclaimer.
;
; * Redistributions in binary form must reproduce the above copyright notice,
;   this list of conditions and the following disclaimer in the documentation
;   and/or other materials provided with the distribution.
;
;   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
;   DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
;   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
;   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
;   CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
;   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
;   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;

    .setcpu     "65816"
    .feature    c_comments

    .include    "zeropage.inc"

    .importzp sp
    .importzp sreg
    .importzp regsave
    .importzp regbank
    .importzp tmp1
    .importzp ptr1
    .importzp ptr2

    .import incsp1
    .import incsp2
    .import incsp3
    .import incsp4
    .import incsp5
    .import incsp6
    .import incsp7

    .import __DATA_LOAD__
    .import __DATA_RUN__
    .import __DATA_SIZE__

    .import __RODATA_LOAD__
    .import __RODATA_RUN__
    .import __RODATA_SIZE__

    .import __UTILCODE_LOAD__
    .import __UTILCODE_RUN__
    .import __UTILCODE_SIZE__

    .import __ZP_START__

    .export _force_vblank
    .export force_vblank

    .export _end_force_vblank
    .export end_force_vblank

    .export _set_register_short
    .export _set_register_char

    .export storeZP
    .export restoreZP

    .export clear_snes
    .export relocatedata

    .BSS

tmpZPdata:
    .res    (zpspace)     ; Other stuff
tmpSP:
    .res    2

    .CODE

_force_vblank:
force_vblank:
    lda #$8F
    sta $2100
    rts

_end_force_vblank:
end_force_vblank:
    lda #$00
    sta $2100
    rts

clear_snes:
    stz $2101
    stz $2102
    stz $2103
    stz $2104
    stz $2105
    stz $2106
    stz $2107
    stz $2108
    stz $2109
    stz $210A
    stz $210B
    stz $210C

    ; words come here
    stz $210D
    stz $210D

    stz $210E
    stz $210E

    stz $210F
    stz $210F

    stz $2110
    stz $2110

    stz $2111
    stz $2111

    stz $2112
    stz $2112

    stz $2113
    stz $2113

    stz $2114
    stz $2114

    ; some bytes
    lda #$80
    sta $2115

    stz $2116
    stz $2117
    stz $2118
    stz $2119
    stz $211A

    ; more words
    stz $211B
    stz $211B

    stz $211C
    stz $211C

    stz $211D
    stz $211D

    stz $211E
    stz $211E

    stz $211F
    stz $211F

    stz $2120
    stz $2120

    ; and bytes again
    stz $2121
    stz $2122
    stz $2123
    stz $2124
    stz $2125
    stz $2126
    stz $2127
    stz $2128
    stz $2129
    stz $212A
    stz $212B
    stz $212C
    stz $212D
    stz $212E

    lda #$30
    sta $2130

    stz $2131

    lda #$E0
    sta $2132

    stz $2133
    stz $4200

    lda #$FF
    sta $4201

    stz $4202
    stz $4203
    stz $4204
    stz $4205
    stz $4206
    stz $4207
    stz $4208
    stz $4209
    stz $420A
    stz $420B
    stz $420C
    stz $420D

    rts

relocatedata:

; copy the data section to memory

    rep #$30
    .i16
    .a16

; copy rw data from rom to memory

    ldx #.LOWORD(__DATA_LOAD__)
    ldy #.LOWORD(__DATA_RUN__)
    lda #__DATA_SIZE__

    mvn .BANKBYTE(__DATA_RUN__), .BANKBYTE(__DATA_LOAD__)

; copy ro data to memory, to have it accessed via bank 0x7e...

    ldx #.LOWORD(__RODATA_LOAD__)
    ldy #.LOWORD(__RODATA_RUN__)
    lda #__RODATA_SIZE__

    mvn .BANKBYTE(__RODATA_RUN__), .BANKBYTE(__RODATA_LOAD__)

; copy util code from rom to memory

    ldx #.LOWORD(__UTILCODE_LOAD__)
    ldy #.LOWORD(__UTILCODE_RUN__)
    lda #__UTILCODE_SIZE__

    mvn .BANKBYTE(__UTILCODE_RUN__), .BANKBYTE(__UTILCODE_LOAD__)

    .i8
    .a8
    sep #$30

    rts

.segment "UTILCODE";

; set_register_short(short addr, short val)
_set_register_short:
    rep #$30
    .a16
    .i16
    ldy #$2
    lda (sp),y
    tax
    dey
    dey
    lda (sp),y
    sta 0,x
    .i8
    .a8
    sep #$30
    jsr     incsp4
    rts

; set_register_short(short addr, char val)
_set_register_char:
    rep #$30
    .a16
    .i16
    ldy #$1
    lda (sp),y
    tax
    dey
    .a8
    sep #$20
    lda (sp),y
    sta $00,x
    .i8
    sep #$10
    jsr     incsp3
    rts

storeZP:
    lda     sp;
    sta     tmpSP
    lda     sp+1
    sta     tmpSP+1

    ldy     #zpspace-1
:
    lda     <__ZP_START__,y
    sta     tmpZPdata,y
    dey
    bpl     :-

    rts

restoreZP:
    ldy     #zpspace-1
:
    lda     tmpZPdata,y
    sta     sp,y
    dey
    bpl     :-

    lda     tmpSP;
    sta     sp
    lda     tmpSP+1
    sta     sp+1

    rts;

