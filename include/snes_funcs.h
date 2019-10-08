#ifndef __SNES_FUNCS_H__
#define __SNES_FUNCS_H__

//void SetBrightness(unsigned char brightness);
void SetPal(unsigned char i, unsigned short c);

void set_register_short(unsigned short addr, unsigned short val);
void set_register_char(unsigned short addr, unsigned char val);

unsigned short clampRGB(unsigned char r, unsigned char g, unsigned char b);

void initDMATransfer(void);
void initHDMATransfer(void);

void startDMATransfer(void);
void startHDMATransfer(void);

void printsnes(char* str);

void clearAllDMA(void);

void addDMAChannel(unsigned char channel,
		unsigned char dest,
		unsigned char srcbank,
		unsigned short srcaddr,
		unsigned int size,
		enum DMA_MODES mode);

void addHDMAChannel(unsigned char channel,
		unsigned char dest,
		unsigned char srcbank,
		unsigned short srcaddr,
		unsigned short size,
		enum DMA_MODES mode);


void snes_print_char(char c);
void snes_print_short(short s);
void snes_print_int(int i);

//---------------------------------------
// Sound functions
//---------------------------------------

void apuWaitReady(void);
void apuSetTransferAddr(unsigned short addr);
void apuSetNextTransferAddr(unsigned short addr);

void apuTransferDataBulk(unsigned short len, unsigned char bank, unsigned short src, unsigned short dst);

void apuTransferBlock(unsigned short len, unsigned char bank, unsigned short addr);
void apuTransferData(unsigned short dstAddr, unsigned short len, unsigned char bank, unsigned short srcAddr);


void apuSndStartExec(unsigned short addr);

char apuReadAddr(unsigned short addr);
void apuWriteAddr(unsigned short addr, char data);

void apuReady(void);

void apuWriteDSPReg(unsigned char addr, unsigned char data);

#define APU_WRITE_DSP_REG(x,y) { apuWriteAddr(0x00F2, x); apuWriteAddr(0x00F3, y); }


#endif
