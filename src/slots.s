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

    .import _slot1_init
    .import _slot1_run
    .import _slot1_nmi
    .import _slot1_irq

    .export _set_slot

    .export current_init_slot
    .export current_run_slot
    .export current_nmi_slot
    .export current_irq_slot

    .ZEROPAGE

current_init_slot:
    .res 3
current_run_slot:
    .res 3
current_nmi_slot:
    .res 3
current_irq_slot:
    .res 3

.struct Slot
              init  .faraddr
              run   .faraddr
              nmi   .faraddr
              irq   .faraddr
.endstruct

   .segment "UTILCODE"

slot_table:
s0:
    .faraddr _slot0_init
    .faraddr _slot0_run
    .faraddr _slot0_nmi
    .faraddr _slot0_irq
s1:
    .faraddr _slot1_init
    .faraddr _slot1_run
    .faraddr _slot1_nmi
    .faraddr _slot1_irq

_set_slot:
    ; assume the index is in register A

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

    rts;


