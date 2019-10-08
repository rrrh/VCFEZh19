#ifndef __SNES_REGS_H__
#define __SNES_REGS_H__

#include "snes_addresses.h"
#include "snes_funcs.h"

//#define set_register_char(r, v) (*(volatile char*)((short)r)) = v
//#define set_register_short(r, v) (*(volatile short*)((short)r)) = v

#define INIDISP(val)			set_register_char(INIDISP_ADDR, val)
#define SETINI(val)			set_register_char(SETINI_ADDR, val)



/*
 * ----------------------------
 * Palette registers
 * ----------------------------
 */

#define CGADD(val) 			set_register_char(CGADD_ADDR, val)
#define CGDATA(val) 			set_register_char(CGDATA_ADDR, val)

/*
 * ----------------------------
 * Object memory registers
 * ----------------------------
 */

#define OBJSEL(val) 			set_register_char(OBJSEL_ADDR, val)
#define OBJADDR(val)			set_register_short(OBJADDRL_ADDR, val)
#define OBJADDRL(val)		set_register_char(OBJADDRL_ADDR, val)
#define OBJADDRH(val)		set_register_char(OBJADDRH_ADDR, val)
#define OBJDATA(val)			set_register_char(OBJDATA_ADDR, val)
#define OBJDATAR(val)		set_register_char(ROBJDATA_ADDR, val)
#define MOSAIC(val)			set_register_char(MOSAIC_ADDR, val)

#define BG1SC(val) 			set_register_char(BG1SC_ADDR, val)
#define BG2SC(val) 			set_register_char(BG2SC_ADDR, val)
#define BG3SC(val) 			set_register_char(BG3SC_ADDR, val)
#define BG4SC(val) 			set_register_char(BG4SC_ADDR, val)

#define BG12NBA(val)			set_register_char(BG12NBA_ADDR, val)
#define BG34NBA(val)			set_register_char(BG34NBA_ADDR, val)

#define VMAINC(val)			set_register_char(VMAINC_ADDR, val)

#define VMADD(val)			set_register_short(VMADDL_ADDR, val)
#define VMADDL(val)			set_register_char(VMADDL_ADDR, val)
#define VMADDH(val)			set_register_char(VMADDH_ADDR, val)

#define VMDATA(val)			set_register_short(VMDATA_ADDR, val)
#define VMDATAL(val)			set_register_char(VMDATAL_ADDR, val)
#define VMDATAH(val)			set_register_char(VMDATAH_ADDR, val)

#define M7SEL(val)			set_register_char(M7SEL_ADDR, val)
#define M7A(val)				set_register_char(M7A_ADDR, val)
#define M7B(val)				set_register_char(M7B_ADDR, val)
#define M7C(val)				set_register_char(M7C_ADDR, val)
#define M7D(val)				set_register_char(M7D_ADDR, val)

#define M7X(val)				set_register_char(M7X_ADDR, val)
#define M7Y(val)				set_register_char(M7Y_ADDR, val)

#define BGMODE(val)			set_register_short(BGMODE_ADDR, val)

#define BG1H0FS(val)			set_register_char(BG1H0FS_ADDR, val)
#define BG1V0FS(val)			set_register_char(BG1V0FS_ADDR, val)

#define BG2H0FS(val)			set_register_char(BG2H0FS_ADDR, val)
#define BG2V0FS(val)			set_register_char(BG2V0FS_ADDR, val)

#define BG3H0FS(val)			set_register_char(BG3H0FS_ADDR, val)
#define BG3V0FS(val)			set_register_char(BG3V0FS_ADDR, val)

#define BG4H0FS(val)			set_register_char(BG4H0FS_ADDR, val)
#define BG4V0FS(val)			set_register_char(BG4V0FS_ADDR, val)

#define CGSWSEL(val)			set_register_char(CGSWSEL_ADDR, val)
#define CGADSUB(val)			set_register_char(CGADDSUB_ADDR, val)
#define COLDATA(val)			set_register_char(COLDATA_ADDR, val)

#define MPYL(val)			set_register_char(MPYL_ADDR, val)
#define MPYM(val)			set_register_char(MPYM_ADDR, val)
#define MPYH(val)			set_register_char(MPYH_ADDR, val)

/* 
 * -----------------------------
 *  Window registers
 *  ----------------------------
 */

#define W12SEL(val) 			set_register_char(W12SEL_ADDR, val)
#define W34SEL(val) 			set_register_char(W34SEL_ADDR, val)
#define WOBJSEL(val) 		set_register_char(WOBJSEL_ADDR, val)

#define WH0(val) 			set_register_char(WH0_ADDR, val)
#define WH1(val) 			set_register_char(WH1_ADDR, val)
#define WH2(val) 			set_register_char(WH2_ADDR, val)
#define WH3(val) 			set_register_char(WH3_ADDR, val)

#define WBGLOG(val) 			set_register_char(WBGLOG_ADDR, val)
#define WOBJLOG(val)			set_register_char(WOBJLOG_ADDR, val)

/* 
 * ------------------------------
 * Screen registers 
 * ------------------------------
 */

#define TM(val)				set_register_char(TM_ADDR, val)
#define TWM(val) 			set_register_char(TWM_ADDR, val)

#define TM_BIT_BG1				0x01
#define TM_BIT_BG2				0x02
#define TM_BIT_BG3				0x04
#define TM_BIT_BG4				0x08
#define TM_BIT_OBJ				0x10

#define TS(val) 				set_register_char(TS_ADDR, val)
#define TSW(val) 			set_register_char(TSW_ADDR, val)

#define TS_BIT_BG1				0x01
#define TS_BIT_BG2				0x02
#define TS_BIT_BG3				0x04
#define TS_BIT_BG4				0x08
#define TS_BIT_OBJ				0x10

/*
 * ------------------------------
 *  Audio registers
 * ------------------------------
 */

#define APUSTATUS(val)		set_register_char(APUSTATUS_ADDR, val)
#define APUCMD(val)			set_register_char(APUCMD_ADDR, val)

#define APUADDR 				(*(unsigned short*)0x2142)

// CHECKME: are the address sizes correct?

#define APUPORT0(val)		set_register_char(APUPORT0_ADDR, val)
#define APUPORT1(val)		set_register_char(APUPORT1_ADDR, val)
#define APUPORT2(val) 		set_register_short(APUPORT2_ADDR, val)
#define APUPORT3(val) 		set_register_short(APUPORT3_ADDR, val)

/*
 * ------------------------------
 *  Work memory
 * ------------------------------
 */

#define WMDATA(val)			get_register_char(WMDATA_ADDR, val)
#define WMADD(val)			set_register_short(WMADD_ADDR, val)

/*
 * ------------------------------
 *  DMA registers
 *  -----------------------------
 */

#define PPCAT_NX(A, B, C) A ## B ## C
#define PPCAT(A, B, C) PPCAT_NX(A, B, C)

#define DMA_MAIN_CTRL(val) 				set_register_char(DMA_MAIN_CTRL_ADDR, val)
#define DMA_HMAIN_CTRL(val) 				set_register_char(DMA_HMAIN_CTRL_ADDR, val)

#define DMA_CTRL(channel, val) 			set_register_char(DMA_CTRL_ADDR + channel * 16, val)
#define DMA_DEST(channel, val) 			set_register_char(DMA_DEST_ADDR + channel * 16, val)
#define DMA_SRC(channel, val) 			set_register_short(DMA_SRC_ADDR + channel * 16, val)
#define DMA_SRC_BANK(channel, val) 		set_register_char(DMA_SRC_BANK_ADDR + channel * 16, val)
#define DMA_TFR_SIZE(channel, val) 		set_register_short(DMA_TFR_SIZE_ADDR + channel * 16, val)
#define DMA_TFR_SIZE_HIGH(channel, val) 	set_register_char(DMA_TFR_SIZE_HIGH_ADDR + channel * 16, val)
#define DMA_DMA_CTRL(val)				set_register_char(DMA_DMA_CTRL_ADDR, val)
#define DMA_HDMA_CTRL(val)				set_register_char(DMA_HDMA_CTRL_ADDR, val)

#define DMA_0_SRC_TEST 			(*(unsigned long*)0x4302)

#define NMITIMEN(val) 					set_register_char(0x4200, val)

#define NMITIMEN_BIT_NMIEN	0x01

#define RDNMI 					(*(unsigned char*)0x4210)
#define TIMERIRQ				(*(unsigned char*)0x4211)
#define HVBJOY(val)				set_register_char(0x4212)

#define HTIME					(*(unsigned char*)0x4207)
#define VTIME					(*(unsigned char*)0x4209)

/*
 * ------------------------------
 *  Controls
 * ------------------------------
 */

#define STDCNTRL1(val)			set_register_short(STDCNTRL1_ADDR, val)
#define STDCNTRL1L(val)			set_register_char(STDCNTRL1L_ADDR, val)
#define STDCNTRL1H(val)			set_register_char(STDCNTRL1H_ADDR, val)

#define NOCASHDEBUGREG(val)		set_register_char(NOCASHDEBUGREG_ADDR, val)

/*
 * ###########################################################################
 * SPC700 DSP REGISTER ADDRESSES
 */

#define DSP_VOL_0 				0x00
#define DSP_VOL_L_0				0x00
#define DSP_VOICE0_VOL_R 		0x01
#define DSP_VOICE0_PITCH 		0x02
#define DSP_VOICE0_PITCH_L 		0x02
#define DSP_VOICE0_PITCH_R 		0x03
#define DSP_VOICE0_SRC 			0x04
#define DSP_VOICE0_ADSR 		0x05

#define DSP_VOICE1_VOL 			0x10
#define DSP_VOICE1_VOL_L 		0x10
#define DSP_VOICE1_VOL_R 		0x11
#define DSP_VOICE1_PITCH 		0x12
#define DSP_VOICE1_PITCH_L 		0x12
#define DSP_VOICE1_PITCH_R 		0x13
#define DSP_VOICE1_SRC 			0x14
#define DSP_VOICE1_ADSR 		0x15

#endif
