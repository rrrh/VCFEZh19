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

.define ROMTITLE "RORSCHACH VTG 2018"
.define MAKERCODE "C3"
.define SNES "ACTE"

; external vectors
.import native_nmi
.import native_irq
.import native_brk

.import emu_reset

.segment "CODE"

; null vectors
null_vect:
native_cop:
native_abort:
native_unused:
    rti

; FFB0
.segment "ROMRESHEADER"
    .byte MAKERCODE                     ; maker code b0/1
    .byte SNES                          ; game code (4 bytes) b2-b5
    .byte 0                             ; fixed	0xb6
    .byte 0                             ; fixed	0xb7
    .byte 0                             ; fixed	0xb8
    .byte 0                             ; fixed	0xb9
    .byte 0                             ; fixed	0xba
    .byte 0                             ; fixed	0xbb
    .byte 0                             ; fixed	0xbc
    .byte 0                             ; exp ram 0xbd
    .byte 0                             ; special version 0xbe
    .byte 0                             ; cart type 0xbf

.segment "ROMHEADER"
    .byte ROMTITLE
    .res $15 - .strlen(ROMTITLE),$20
    .byte $31                           ; HiRom	0xD5
    .byte $02                           ; No SRAM 0xD6
    .byte $0C                           ; 128K ROM 0xD7
    .byte $03                           ; no SRAM 0xD8
    .byte $02                           ; country code 0xD9
    .byte $33                           ; licensee code 0xDA
    .byte $0                            ; version number 0xDB
    .word $0489                         ; dummy complement 0xDC/D
    .word $fb76                         ; dummy checksum 0xDE/F

.segment "VECTORS"
    .word $0000                         ; what is this padding???
    .word $0000
    .word .loword(native_cop)           ; e0
    .word .loword(native_brk)           ; e2
    .word .loword(native_abort)         ; e4
    .word .loword(native_nmi)           ; ea
    .word .loword(native_brk)           ; ec
    .word .loword(native_irq)           ; ee
	
    .word $AAAA                         ; f0 checksum dummy
    .word $FFFF                         ; f2 checksum dummy

    .word .loword(null_vect)            ; f4
    .word .loword(null_vect)            ; f6
    .word .loword(null_vect)            ; f8
    .word .loword(null_vect)            ; fa
    .word .loword(emu_reset)            ; fc
    .word .loword(null_vect)            ; fe


