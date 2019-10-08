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

	.setcpu         "65816"
	.import 		__SOFTSTACK_START__, __SOFTSTACK_SIZE__
    .importzp       sp, ptr1, ptr2, tmp1

    .import         __ZP_START__            ; Linker generated
    .include        "zeropage.inc"

    .import incsp2
    .import incsp3
    .import incsp4
    .import incsp5

	.export _apuSndStartExec
	.export _apuWaitReady
	.export _apuSetTransferAddr
	.export _apuSetNextTransferAddr
	.export _apuTransferBlock

    .export _apuReady
	.export _apuReadAddr
	.export _apuWriteAddr

	APU_STAT 	= $2140 ;
	APU_CMD 	= $2141	;
	APU_ADDR 	= $2142	;

.code
; SND_ADDR = DIR * 100h + SRCN * 4
;
; eg. DIR = 4, SRCN = 0
; addr

; len (sp),3
; bank (sp),2
; addr (sp),0

; ********************************
; 50 stages of transfer :)


; Wait for the APU to be ready after reset.
_apuWaitReady:
	lda #$AA
:
	cmp	$2140
	bne :-

	lda #$BB
:
	cmp $2141
	bne :-

	rts

; Set the target address of the transfer
; (sp) addr - short
_apuSetTransferAddr:

	rep #$20
.a16
	lda (sp)
	sta $2142
.a8
	sep #$20

	lda #$CC
	sta $2141
	sta $2140

:
	cmp $2140
	bne :-

	jsr     incsp2
	rts

; (sp) addr
_apuSetNextTransferAddr:
	rep #$20
.a16
	lda (sp)
	sta $2142
.a8
	sep #$20

	lda $2140
	ina
; if value is zero after the +2 step, increment once more.
:	ina
	beq :-
	sta $2141
	sta $2140
:
	cmp $2140
	bne :-

    jsr     incsp2
	rts


; (sp) 		src addr
; (sp),2 	bank
; (sp),3	len
_apuTransferBlock:

	ldy #$03
	lda (sp),y
	ina
	tax

	rep #$20
.a16
	lda (sp)
	sta $A0	; zero page hack
.a8
	sep #$20

	dey
	lda (sp),y
	phb								; push the data bank reg

	pha								; push the new bank
	plb								; pull the data bank reg

	ldy #$00

:
	lda ($A0),y

	phb								; push the data bank reg

	phk								; je deteste ma vie..
	plb								;   we push the program register since
									;   it is zero..

	sta $2141 						; set data

	tya
	sta $2140 						; set counter

:
	cmp $2140
	bne :-

	plb

	iny
	dex
	txa
	bne :--

	plb
	jsr     incsp5
	rts

; (sp) addr
_apuSndStartExec:
	ldy #$00
	sty APU_CMD

	rep #$20
.a16
	lda (sp),y
	sta APU_ADDR
.a8
	sep #$20
	lda APU_STAT
	ina
	ina

	sta APU_STAT

    jsr     incsp2
	rts

; Wait for apu ready
_apuReady:
    lda #$00
:
    cmp APU_CMD
    bne :-

    lda #$01
:
    cmp APU_STAT
    bne :-

    ; yes, the apu code is ready.

    rts

_apuDone:
    lda #$02
:
    cmp APU_STAT
    bne :-
    rts

; (sp)      addr
_apuReadAddr:
; Wait for the APU to accept commands

    ; check if the apu code is accepting commands
    jsr _apuReady

    rep #$20
.a16
    lda (sp)
    sta APU_ADDR
.a8
    sep #$20

    lda #$0B
    sta APU_CMD

:
    lda APU_CMD
    bne :-

    ; wait for the command to be sampled
    ; the ready flag needs to go away..
:
    lda APU_STAT
    bne :-

    ; deflag the command
    lda #$00
    sta APU_CMD

    ; check for the apu to become ready again
    jsr _apuReady


    lda APU_ADDR

    jsr     incsp2
    rts


; (sp)      addr
; (sp),2    data
_apuWriteAddr:
; Wait for the APU to accept commands
    ; check if the apu code is accepting commands
    jsr _apuReady

    rep #$20
.a16
    ldy #$01
    lda (sp),y
    sta APU_ADDR
.a8
    sep #$20

    lda (sp)
    sta APU_STAT

    lda #$09
    sta APU_CMD

:
    lda APU_CMD
    bne :-

    ; wait for the command to be sampled
    ; the ready flag needs to go away..
:
    lda APU_STAT
    bne :-

    ; deflag the command
    lda #$00
    sta APU_CMD

    ; check for the apu to become ready again
    jsr _apuReady

    jsr     incsp3
    rts


