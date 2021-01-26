// This is the header file for 12-bit SPI DAC TLV5616

#ifndef spi_h
	#include "SPIControl.h"
#endif

void dac_init(void);
void dac(unsigned int);

sbit cs_bar_dac	=	P1^2;
sbit fs			=	P1^3;
void dac_init(void)
{
		cs_bar_dac	=	1;
		fs			=	1;
}

void dac(unsigned int temp_dac_data)
{
	//SPCON		&=	0xB7;
	//SPCON		= 	0x37;					// 0b00111011
	//SPCON		|=	0x40;
	SPCON=0x00;
	SPCON=0x77;
	cs_bar_dac = 0;
	fs = 0;
	temp_dac_data = spi_trx_16_bit(temp_dac_data);
	fs = 1;
	cs_bar_dac = 1;
	return;		
}