/*
 BSD 2-Clause License

 Copyright (c) 2017, rrrh
 All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
   DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
   CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include "snes.h"

#include "res.h"

static volatile unsigned char next_frame = 0;
static volatile unsigned char frame_done = 0;

struct OAM {
	unsigned char hpos;
	unsigned char vpos;
	unsigned char name;
	unsigned char cntrl;
};

struct OAM oam[128];
unsigned short oam_obj[16];

unsigned int frame_counter = 0;

unsigned short frame = 0;
unsigned char even = 0;

unsigned short animcounterA = 0;
unsigned short animcounterB = 0;

unsigned char frameA_bank = 0;
unsigned short* frameA_next = 0;

static unsigned short key;
static unsigned short last_key;

char animationA_fadeIn = 0;
char animationA_hold = 0;
char animationA_fadeOut = 0;
short animationA_hold_time = 0;

char animationB_fadeIn = 0;
char animationB_hold = 0;
char animationB_fadeOut = 0;
short animationB_hold_time = 0;

unsigned char* us = (&sin_table_us);
signed char* s = (&sin_table_s);
//signed char* ts = (&sin_text);

unsigned char mosaic = 0;
char mosaicDir = 0;

char text_wobble = 0;

char nextDivSubVal = 0xC3;

unsigned char hasMosaic = 0;

void state_idle(void);
void state_fadeIn(void);

void state_run(void);
void state_text(void);
void state_fadeOut(void);

void state_text_idle(void);
void state_text_run(void);

void state_anim_idle(void);
void state_anim_fadeIn(void);
void state_anim_run(void);
void state_anim_fadeOut(void);


void (*current_state)(void) = state_idle;
void (*current_text_state)(void) = state_text_idle;
void (*current_anim_state)(void) = state_anim_idle;

int lenA = 320;
int lenB = 118;

static void clear_bg(void) {
	int x, y;
	for(y = 0; y < 32; ++y) {
		for(x = 0; x < 32; ++x) {
			//text_table[y][x] = 0x0000;
		}
	}
}


void memcpy(char* dst, char* src, int size) {
	int i = 0;
	for(i = 0; i < size; i++) {
		//printsnes("bla\n");

		*dst = *src;
		dst++;
		src++;
	}
}

int strlen(char* str) {
	int ret = 0;
	while(*str++ != '\0') {
		ret++;
	}
	return ret;
}


static unsigned char disp = 0x80;
//static short* plasma_col = (short*)&res_plasma_colors;

void slot0_init(void)
{
	int i = 0;
	short x = 0;
	short y = 0;

	INIDISP(disp);
	SETINI(0x04);

	clear_bg();

	BGMODE(0x09);

	BG1SC(0x43);
	BG2SC(0x53);
	BG3SC(0x78);

	OBJSEL(0x83);

	BG12NBA(0x00);
	BG34NBA(0x07);

	VMAINC(0x80);

	TM(TM_BIT_BG1 | TM_BIT_OBJ);
	TS(TS_BIT_BG2);

	BG1V0FS(0x00);	BG1V0FS(0x00);
	BG1H0FS(0x00);	BG1H0FS(0x00);

	CGSWSEL(0x02);
//	CGADSUB(0x00);
	CGADSUB(0xC3);

	COLDATA(0xAA);

	initDMATransfer();

	VMADD(0x0000);
	CGADD(0x0);


	addDMAChannel(1, 0x22, 0x42, (short)&img_A_clr, 32, DMA_MODE_BYTE_TWICE);
	addDMAChannel(0, 0x18, 0x42, (short)&img_A_pic, 0x8000, DMA_MODE_SHORT);

	startDMATransfer();

	initDMATransfer();
	VMADD(0x4000);

	addDMAChannel(0, 0x18, 0x42, (short)&img_A_map, 8192, DMA_MODE_SHORT);

	startDMATransfer();

	// sound init...
	printsnes("transfer snd code\n");

	apuWaitReady();

	// FIXME:
	apuTransferDataBulk(65280, 0x41, (unsigned short)&snd_code, 0x0100);

	printsnes("execute snd code\n");
	apuSndStartExec(0x400);

	frame_counter = 25;



	NMITIMEN(0x81);

	// FIXME:

	MOSAIC(0x03);

	//SetPal(0x0, clampRGB(0xFF, 0, 0xFF));

	next_frame = 1;
}



//**************************************** Overall states
void state_idle(void) {
	disp = 0x00;
	current_state = state_fadeIn;
}

void state_fadeIn(void) {
	static unsigned char brightness = 0;
	static unsigned int delay = 0;

	if(delay++ == 10) {
		brightness++;
		disp = brightness;
		if(brightness == 15) {
			current_state = state_text;
		}
		delay = 0;
	}
}

void state_run(void) {
	if(frame_counter == 600) {
		current_state = state_text;
	}
}

void state_text(void) {

}

void state_fadeOut(void) {

}

//**************************************** Text states

void state_text_idle(void)
{
	if(frame_counter > 600) {
		current_text_state = state_text_run;
	}
}

#define ROW_OFFSET 16

void state_text_run(void)
{
}

//**************************************** Anim states



void state_anim_idle(void)
{
	current_anim_state = state_anim_run;
	animationA_hold_time = 0;
	animationB_hold_time = 0;
}

void state_anim_fadeIn(void)
{

}

void state_anim_run(void)
{
}

void state_anim_fadeOut(void) { }

//****************************************




void timeline(void) 
{
}

void slot0_run(void)
{
	unsigned short x = 0;
	unsigned short y = 0;
	unsigned char c = 0;
	unsigned char d = 64;
	unsigned short pathPos = 0;
	unsigned short tmpPathPos = 0;

	char buf[3] = { 0, '\n', 0};

	while(1) {
		if(next_frame) {

			timeline();

			current_state();
			current_text_state();
			current_anim_state();


			// Handle key inputs
			if(!(last_key & 0x80) && (key & 0x80)) {
			/*	plasma_col_table_A_index++;
				// A pressed
				if(sub_add) {
					sub_add = 0;
					sub_add_val |= 0x80;
				} else {
					sub_add = 1;
					sub_add_val &= ~0x80;
				}
				*/

				snes_print_int(frame_counter);
				printsnes("\n");
			}
			if(!(last_key & 0x8000) && (key & 0x8000)) {
			/*		// A pressed
					if(div2) {
						div2 = 0;
						sub_add_val |= 0x40;
					} else {
						div2 = 1;
						sub_add_val &= ~0x40;
					}
					*/
			}
			// keys
			/*
			if(!(last_key & 0x0100) && (key & 0x0100)) {
				plasma_col_table_A_index++;
				plasma_col_table_A_index &= 0xF;
				newColor = 1;
			}
			if(!(last_key & 0x0200) && (key & 0x0200)) {
				plasma_col_table_A_index--;
				plasma_col_table_A_index &= 0xF;
				newColor = 1;
			}
			if(!(last_key & 0x0400) && (key & 0x0400)) {
				plasma_col_table_B_index++;
				plasma_col_table_B_index &= 0xF;
				newColor = 1;
			}
			if(!(last_key & 0x0800) && (key & 0x0800)) {
				plasma_col_table_B_index--;
				plasma_col_table_B_index &= 0xF;
				newColor = 1;
			}
			*/
			last_key = key;


			// reset after 1 minute
			if(frame_counter > 3195) {
				frame_counter = 40;
			}

			next_frame = 0;
			frame_done = 1;
		}
	}
}



void slot0_nmi(void)
{
	INIDISP(disp);

	frame_counter++;

	if(frame_done) {
		even++;

		frame_done = 0;
		next_frame = 1;
	} else {
		printsnes("missed\n");
	}
}

void slot0_irq(void)
{

}

