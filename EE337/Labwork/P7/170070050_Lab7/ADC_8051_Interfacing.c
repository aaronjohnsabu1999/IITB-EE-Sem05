// ADC IC TLV1543 Interfacing with 8051

#include <at89c5131.h>
#include "LCDControl.h"
#include "TLV1543_Header.h"

char adc_ip_data_ascii[6]={0,0,0,0,0,'\0'};
char display_msg1[]="ADC channel-";
char display_msg2[]=" mV";

void main(void)
{
	unsigned int  j = 0;
	char cMSB[] = {'0', '\0'};
	char cLSB[] = {'0', '\0'};
	unsigned int adc_data=0;
	unsigned int dac_data=0;
	
	spi_init();
	adc_init();
	lcd_init();
	
	while(1)
	{
		msdelay(2000);
		adc_data = adc(j);
		
		adc_data = (unsigned int)(3.225806452*adc_data);	//Convert to milli volt (3.3*1000*(input)/1023)
		int_to_string(adc_data,adc_ip_data_ascii);
		
		cMSB[0] = (char)(j/10);
		cLSB[0] = (char)(j%10);
		lcd_cmd(0x80);
		lcd_write_string(display_msg1);
		lcd_write_string(cMSB);
		lcd_write_string(cLSB);
	
		lcd_cmd(0xC0);
		lcd_write_string(adc_ip_data_ascii);
		lcd_write_string(display_msg2);
		
		if (j == 0) j = 5;
		else j = 0;
	}
}