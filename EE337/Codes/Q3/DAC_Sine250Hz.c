// Quiz 3 Part 1

#include <at89c5131.h>
#include "TLV5616_Header.h"							
// #include "TLV1543_Header.h"							
// #include "filters.h"																

unsigned int count = 0;
int lookup[32] = {0x00, 0x18, 0x30, 0x46, 0x5a, 0x6a, 0x75, 0x7d, 0x7f, 0x7d, 0x75, 0x6a, 0x5a, 0x46, 0x30, 0x18, 0x00, 0xe7, 0xcf, 0xb9, 0xa5, 0x95, 0x8a, 0x82, 0x80, 0x82, 0x8a, 0x95, 0xa5, 0xb9, 0xcf, 0xe7};
unsigned int value = 0;
void msdelay(unsigned int);
void timer_ISR(void);

void main(void)
{
	unsigned int adc_data = 0, dac_data = 0;
	spi_init();
	// adc_init();
	dac_init();
  
	TMOD  = 0x22;
	TH0		=	  -8;
	ET0		=	1;
	TR0		=	1;
	while(1)
	{
		//dac(value);
		// P1		&=	0x7F;
		
	}
	
}

void msdelay(unsigned int time)
{
	int i, j;
	for(i=0; i<time; i++)
	{
		for(j=0;j<382;j++);
	}
}

void timer_ISR(void) interrupt 1
{
	TR0		=	0;
	count++;
	if(count == 32)
	{
		count = 0;
	}
	value = (unsigned int) (lookup[count] + 128);
	P2 = (lookup[count] + 128) ;

	value = value<<4;
		value= value && 0x0fff ;
	
	dac(value);
	TH0		=	-8;
	TR0		=	1;
	TF0		=	0;
}