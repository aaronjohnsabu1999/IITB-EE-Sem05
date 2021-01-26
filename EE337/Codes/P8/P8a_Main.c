#include <at89c5131.h>
//#include "lcd.h"																	
#include "TLV1543_Header.h"															
#include "TLV5616_Header.h"							
#include "filters.h"																

void msdelay(unsigned int);

void main(void)
{
	unsigned int adc_data=0,dac_data=0;
	
	unsigned int value = 0;
	bit dir = 0;

	spi_init();
	adc_init();
	dac_init();
  
	//lcd_init();
			
		while(1)
			{
				msdelay(7);
				if(dir == 0)
					value = value + 5;
				else
					value = value - 5;
				dac(value);
				if(value <= 5 || value >= 0xF000)
					dir = 0;
				else if(value >= 0x0FFF)
					dir = 1;
			}
}

void msdelay(unsigned int time)
{
	int i, j;
	for(i=0;i<time;i++)
	{
		for(j=0;j<382;j++);
	}
}