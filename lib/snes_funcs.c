/*
 *
 * BSD 2-Clause License
 *
 * Copyright (c) 2017, rrrh
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 *   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 *   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 *   DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 *   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 *   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 *   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 *   CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 *   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

/**
 * @brief Set one color in the palette
 *
 * Set a given color entry in the palette
 *
 * @param i Index to the color to change
 * @param c SNES color data
 *
 */

#include "snes.h"

#pragma codeseg (push, "UTILCODE")

void ForceVBlank()
{
	INIDISP(0x80);
}
void EndForceVBlank()
{
	INIDISP(0x00);
}

void SetPal(unsigned char i, unsigned short c)
{
	CGADD(i);
	CGDATA((char)(c));
	CGDATA((char)(c >> 8));
}

unsigned short clampRGB(unsigned char r, unsigned char g, unsigned char b) {
	return (b >> 3) << 10 | (g >> 3) << 5 | (r >> 3);
}

void apuTransferDataBulk(unsigned short len, unsigned char bank, unsigned short src, unsigned short dst) {
	unsigned short current_addr = dst;
	unsigned char rem = len % 256;
	unsigned short i = 0;
	unsigned short iters =  len / (unsigned short)256;


	apuSetTransferAddr(dst);
	if(len > 256) {
		printsnes("uploading data block\n");
		for(i = 0; i < iters; i++) {
			apuTransferBlock(255, bank, src);
			dst += 256;
			apuSetNextTransferAddr(dst);
			src += 256;
		}
	}
    apuTransferBlock(rem, 0x0, src);
}


/* debug functions */
void printsnes(char* str) {
	while(*str != 0) {
		NOCASHDEBUGREG(*str++);
	}
}



#pragma codeseg (pop)
