/* sh@sighup.ch */

#include <snes.h>

/* DMA code, probably to be rewritten in assembler */
static unsigned char _dmaChannelArm;
static unsigned char _hdmaChannelArm;

void initDMATransfer(void) {
	_dmaChannelArm = 0;
}

void initHDMATransfer(void) {
	_hdmaChannelArm = 0;
}

void addDMAChannel(
		unsigned char channel,
		unsigned char dest,
		unsigned char srcbank,
		unsigned short srcaddr,
		unsigned int size,
		enum DMA_MODES mode)
{
	_dmaChannelArm |= 1 << channel;

	DMA_DEST				(channel, dest);
	DMA_SRC				(channel, srcaddr);
	DMA_SRC_BANK			(channel, srcbank);
	DMA_TFR_SIZE			(channel, (unsigned short)size);
	DMA_TFR_SIZE_HIGH	(channel, 0/*(unsigned char)(size >> 16)*/);
	DMA_CTRL				(channel, (unsigned char)mode);
}


//
//void addHDMAChannel(unsigned char channel,
//		unsigned char dest,
//		unsigned char srcbank,
//		unsigned short srcaddr,
//		unsigned short size,
//		enum DMA_MODES mode) {
//
//	unsigned char co = channel * 16;	// channel offset
//
//	_hdmaChannelArm |= 1 << channel;
//
//
//	__REGB__(0x4301 + co) = (unsigned char)dest;
//	__REGB__(0x4302 + co) = (unsigned char)srcaddr;
//	__REGB__(0x4303 + co) = (unsigned char)(srcaddr >> 8);
//	__REGB__(0x4304 + co) = srcbank;
//
//	__REGB__(0x4305 + co) = (unsigned char)size;
//	__REGB__(0x4306 + co) = (unsigned char)(size >> 8);
//	__REGB__(0x4307 + co) = 0x0;
//
//	__REGB__(0x4300 + co) = (unsigned char)mode;
//}

void startHDMATransfer() {
	DMA_HMAIN_CTRL(_hdmaChannelArm);
	_hdmaChannelArm = 0;
}

void startDMATransfer() {
	DMA_MAIN_CTRL(_dmaChannelArm);
	_dmaChannelArm = 0;

	// busy wait for dma completion
	// while(DMA_MAIN_CTRL);
}

void clearAllDMA(void) {
	//	printsnes("clear dma\n");
	DMA_HMAIN_CTRL(0x0);
	DMA_MAIN_CTRL(0x0);
}


static void puth(char n)
{
	static const char hex[16] = { '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};
	NOCASHDEBUGREG(hex[n & 0xF]);
}

void snes_print_char(char c) {
	puth(c >> 4);
	puth(c & 0xF);
}

void snes_print_short(short s) {
	puth(s >> 12);
	puth((s >> 8) & 0xF);
	puth((s >> 4) & 0xF);
	puth(s & 0xF);
}

void snes_print_int(int i) {
	puth(i >> 28);
	puth((i >> 24) & 0xF);
	puth((i >> 20) & 0xF);
	puth((i >> 16) & 0xF);

	puth((i >> 12) & 0xF);
	puth((i >> 8) & 0xF);
	puth((i >> 4) & 0xF);
	puth(i & 0xF);
}
