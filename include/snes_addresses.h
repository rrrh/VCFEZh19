/*
 * snes_addresses.h
 *
 *  Created on: 09.07.2013
 *      Author: hns
 */

#ifndef SNES_ADDRESSES_H_
#define SNES_ADDRESSES_H_

#define INIDISP_ADDR				0x2100
#define CGADD_ADDR					0x2121
#define CGDATA_ADDR					0x2122

#define BG1SC_ADDR					0x2107
#define BG2SC_ADDR					0x2108
#define BG3SC_ADDR					0x2109
#define BG4SC_ADDR					0x210A

#define OBJSEL_ADDR					0x2101
#define OBJADDRL_ADDR				0x2102
#define OBJADDRH_ADDR				0x2103
#define OBJDATA_ADDR				0x2104
#define MOSAIC_ADDR					0x2106

#define BG12NBA_ADDR				0x210B
#define BG34NBA_ADDR				0x210C

#define BG1H0FS_ADDR				0x210D
#define BG1V0FS_ADDR				0x210E

#define BG2H0FS_ADDR				0x210F
#define BG2V0FS_ADDR				0x2110

#define BG3H0FS_ADDR				0x2111
#define BG3V0FS_ADDR				0x2112

#define BG4H0FS_ADDR				0x2113
#define BG4V0FS_ADDR				0x2114

#define VMAINC_ADDR					0x2115

#define VMADDL_ADDR					0x2116
#define VMADDH_ADDR					0x2117

#define VMDATA_ADDR					0x2118

#define VMDATAL_ADDR				0x2118
#define VMDATAH_ADDR				0x2119

#define M7SEL_ADDR					0x211A
#define M7A_ADDR					0x211B
#define M7B_ADDR					0x211C
#define M7C_ADDR					0x211D
#define M7D_ADDR					0x211E

#define M7X_ADDR					0x211F
#define M7Y_ADDR					0x2120

#define BGMODE_ADDR					0x2105

#define SETINI_ADDR					0x2133

#define MPYL_ADDR					0x2134

#define MPYL_ADDR					0x2134
#define MPYM_ADDR					0x2135
#define MPYH_ADDR					0x2136

#define ROBJDATA_ADDR				0x2138

#define TM_ADDR						0x212C
#define TWM_ADDR					0x212E
#define TS_ADDR						0x212D
#define TSW_ADDR					0x212F

#define W12SEL_ADDR 				0x2123
#define W34SEL_ADDR 				0x2124
#define WOBJSEL_ADDR 				0x2125

#define WH0_ADDR 					0x2126
#define WH1_ADDR 					0x2127
#define WH2_ADDR 					0x2128
#define WH3_ADDR 					0x2129

#define WBGLOG_ADDR 				0x212A
#define WOBJLOG_ADDR				0x212B

#define CGSWSEL_ADDR				0x2130
#define CGADDSUB_ADDR			0x2131
#define COLDATA_ADDR				0x2132


#define APUSTATUS_ADDR				0x2140
#define APUCMD_ADDR					0x2141
#define APUADDR_ADDR 				0x2142

#define APUPORT0_ADDR				0x2140
#define APUPORT1_ADDR				0x2141
#define APUPORT2_ADDR				0x2142
#define APUPORT3_ADDR				0x2143

#define WMDATA_ADDR					0x2180
#define WMADDL_ADDR					0x2181
#define WMADDM_ADDR					0x2182
#define WMADDH_ADDR					0x2183

#define WMADD_ADDR					0x2181

#define NOCASHDEBUGREG_ADDR			0x21FC

#define STDCNTRL1_ADDR				0x4218
#define STDCNTRL1L_ADDR				0x4218
#define STDCNTRL1H_ADDR				0x4219

#define DMA_MAIN_CTRL_ADDR 			0x420B
#define DMA_HMAIN_CTRL_ADDR			0x420C

#define DMA_CTRL_ADDR 			0x4300
#define DMA_DEST_ADDR 			0x4301
#define DMA_SRC_ADDR 			0x4302
#define DMA_SRC_BANK_ADDR 		0x4304
#define DMA_TFR_SIZE_ADDR 		0x4305
#define DMA_TFR_SIZE_HIGH_ADDR	0x4307
#define DMA_DMA_CTRL_ADDR		0x420B
#define DMA_HDMA_CTRL_ADDR		0x420C

#define DMA_0_SRC_TEST_ADDR 		0x4302



#endif /* SNES_ADDRESSES_H_ */
