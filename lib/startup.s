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

; Settings

    .setcpu     "65816"
    .feature    c_comments

    .import     __SOFTSTACK_START__
    .import     __SOFTSTACK_SIZE__
    .import     __ZP_START__        ; Linker generated
    .include    "zeropage.inc"

    .importzp   sp
    .importzp   ptr1
    .importzp   ptr2
    .importzp   tmp1


    .import clear_snes
    .import force_vblank
    .import end_force_vblank
    .import relocatedata
    .import storeZP
    .import restoreZP

    .import core_init

    .import _slot0_init
    .import _slot0_run
    .import _slot0_nmi
    .import _slot0_irq

    .import _set_slot

    .importzp current_init_slot
    .importzp current_run_slot
    .importzp current_nmi_slot

    .export native_nmi
    .export native_irq
    .export native_brk
    .export native_reset
    .export emu_reset



; make the linker happy
    .segment "SOFTSTACK"
    .segment "HARDSTACK"

; data
    .bss
    .res 256
intrStack:

retsav:	.res	2	; Save buffer for return address

; code
.code

native_nmi:
    pha
    phx
    phy

    php
   ; sep #$30


    lda     $4210       ; Clear NMI flag

   	jsr     storeZP     ; Swap stuff

;    lda     #<intrStack ; Set new stack
;    sta     sp
;    lda     #>intrStack
;    sta     sp+1

	ldx		#$00
    jsr     (current_nmi_slot,x); Call C code
    jsr     restoreZP   ; Swap stuff back

    plp

    ply
    plx
    pla
    rti

native_irq:
	rti

native_brk:
    rti

native_reset:
    jsr force_vblank
    jsr clear_snes

    ; setup stack
    rep     #$10    ; switch to 16bit mode
    .i16

    ldx     #$1FFF  ; new stack pointer
    txs

    sep     #$10    ; switch to 8bit mode
    .i8

    ; setup soft stack
    lda     #<(__SOFTSTACK_START__ + __SOFTSTACK_SIZE__)
    sta     sp
    lda     #>(__SOFTSTACK_START__ + __SOFTSTACK_SIZE__)
    sta     sp+1

    ; copy data
    jsr relocatedata

    ; call kernel init routine - setup slot0 - later with param
    jsr _set_slot


    ; call slot 0 init

:   ; from now on every slot that returns ends up calling the next init

    ;; TODO: disable interrupts
    ldx #$00
    jsr (current_init_slot,x)
	jsr end_force_vblank
    cli

    ; call slot 0 run routine
    ldx #$00
    jsr (current_run_slot,x)
	jsr force_vblank

    bra :-          ;

emu_reset:          ; get to the native mode!
    sei
    clc
    xce
	jmp native_reset
