// Quiz 3 Part 1

#include <at89c5131.h>
#include "TLV5616_Header.h"							
// #include "TLV1543_Header.h"							
#include "filters.h"																

void msdelay(unsigned int);
void timer_ISR(void);

unsigned int count = 0, countMT = 0;
char value = 0, valueMT = 0, final = 0;
int lookup[32] = {0x00, 0x18, 0x30, 0x46, 0x5a, 0x6a, 0x75, 0x7d, 0x7f, 0x7d, 0x75, 0x6a, 0x5a, 0x46, 0x30, 0x18, 0x00, 0xe7, 0xcf, 0xb9, 0xa5, 0x95, 0x8a, 0x82, 0x80, 0x82, 0x8a, 0x95, 0xa5, 0xb9, 0xcf, 0xe7};
// void msdelay(unsigned int);
void timer_ISR(void);

void main(void)
{
	// unsigned int adc_data = 0, dac_data = 0;
	spi_init();
	// adc_init();
	dac_init();
	EA		=	1;
	ET0		=	1;
	TR0		=	1;
	ET1		=	1;
	TR1		=	1;
	TMOD  	= 0x22;
	while(1)
	{
		P1		&=	0x7F;
		TH0		=	  -8;
		TH1		=	  -80;
		final = value*valueMT;
		final = final + 128;
		dac(final);
	}
}

/*
void msdelay(unsigned int time)
{
	int i, j;
	for(i=0; i<time; i++)
	{
		for(j=0;j<382;j++);
	}
}
*/

void timer_ISR(void) interrupt 1
{
	count++;
	if(count == 32)
		count = 0;
	value = lookup[count];
	timecount++;
	if(timecount%10==0)
	{
		countMT++;
		if(countMT == 32)
			countMT = 0;
		valueMT = lookup[countMT];
	}
	TH0		=	-8;
	TR0		=	1;
	TF0		=	0;
}