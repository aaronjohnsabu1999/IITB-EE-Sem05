// Functions related to the 8051 SPI module

#ifndef spi_h
	#define spi_h 1
#endif

void spi_init(void);
unsigned int spi_trx_16_bit(unsigned int spi_data_tx);
void spi_interrupt(void);

bit transmit_completed = 0;
unsigned char temp_spi_data;

void spi_init(void)
{
	SPCON =  0x33;	// 0b00110011
	IEN1	|= 0x04;	// 0b00000100
	EA		=  1;
	SPCON |= 0x40;	// 0b01000000
}

unsigned int spi_trx_16_bit(unsigned int spi_data_tx)
{
	unsigned int  spi_data_rx;
	unsigned char spi_data_high;
	unsigned char spi_data_low;
	
	transmit_completed	= 0;
	SPDAT				= (spi_data_tx>>8);
	while(!transmit_completed);
	spi_data_high		= temp_spi_data;
	
	transmit_completed	= 0;
	SPDAT				= (spi_data_tx%256);
	while(!transmit_completed);
	spi_data_low		= temp_spi_data;
	
	spi_data_rx			= (spi_data_high<<8) + spi_data_low;
	return spi_data_rx;
}

void spi_interrupt(void) interrupt 9
{
	switch(SPSTA)
	{
		case 0x80:
			temp_spi_data		= SPDAT;
			transmit_completed	= 1;
 		break;
		
		case 0x10:
			
		break;
	
		case 0x40:
		
		break;
	}
}