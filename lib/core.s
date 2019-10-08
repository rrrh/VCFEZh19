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

    .import _slot0_init
    .import _slot0_run
    .import _slot0_nmi
    .import _slot0_irq

    .importzp current_init_slot
    .importzp current_run_slot
    .importzp current_nmi_slot
    .importzp current_irq_slot

    .CODE


core_init:

    ; set up slot0 slots - the holy default...

    lda #.LOBYTE(_slot0_init)
    sta current_init_slot
    lda #.HIBYTE(_slot0_init)
    sta current_init_slot + 1
    lda #.BANKBYTE(_slot0_init)
    sta current_init_slot + 2

    lda #.LOBYTE(_slot0_run)
    sta current_run_slot
    lda #.HIBYTE(_slot0_run)
    sta current_run_slot + 1
    lda #.BANKBYTE(_slot0_run)
    sta current_run_slot + 2

    lda #.LOBYTE(_slot0_nmi)
    sta current_nmi_slot
    lda #.HIBYTE(_slot0_nmi)
    sta current_nmi_slot + 1
    lda #.BANKBYTE(_slot0_nmi)
    sta current_nmi_slot + 2

    lda #.LOBYTE(_slot0_irq)
    sta current_irq_slot
    lda #.HIBYTE(_slot0_irq)
    sta current_irq_slot + 1
    lda #.BANKBYTE(_slot0_irq)
    sta current_irq_slot + 2

    rts
