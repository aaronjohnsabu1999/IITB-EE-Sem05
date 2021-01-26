// Header file for 10-bit SPI ADC IC TLV1543

#ifndef SPIControl_h
	#include "SPIControl.h"
#endif

void 		 adc_init(void);
unsigned int adc(unsigned int);

sbit cs_bar_adc = P1^4;

void adc_init(void)
{
	cs_bar_adc	= 1;
}

unsigned int adc(unsigned int channel)
{
	unsigned int temp_adc_data;
	
	//SPCON		&=	0xB7;
	//SPCON		=		0x33;					// 0b0110011
	//SPCON		|=	0x40;
	SPCON=0x00;
	SPCON=0x73;
	cs_bar_adc 		= 0;
	temp_adc_data	= spi_trx_16_bit(channel<<12);
	cs_bar_adc		= 1;

	temp_adc_data	= temp_adc_data>>6;
	return temp_adc_data;
}