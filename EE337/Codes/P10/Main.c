#include "at89c5131.h"
#include "math.h"
#include<stdio.h>
#include<string.h>

#define LCD_data P2

#define SSIE_enable 0x40
#define start_comm 0x20
#define stop_comm 0xD1
#define bitrate 0x81

#define clear_TWI_start_stop_interrupt 0xC7
#define clear_TWI_stop_interrupt 0xE7

#define send_Ack 0xC5
#define send_Nack 0xC3
#define read_mode 0x01
#define write_mode 0x00

#define slave_add 0xD0
#define clear_ext_interrupt 0xF7
#define seconds 0x00
#define minutes 0x40
#define hours 0x17
#define day 0x03
#define date 0x05
#define month 0x11
#define year 0x19
// #define SQWE 0x10
#define SQWE 0x10

sbit SDA = P4^1;
sbit SCL = P4^0;

sbit LCD_rs = P0^0;
sbit LCD_rw = P0^1;
sbit LCD_en = P0^2;

sbit LCD_busy = P2^7;
sbit LED = P1^5;
void LCD_Init();
void LCD_DataWrite(char dat);
void LCD_CmdWrite(char cmd);
void LCD_StringWrite(unsigned char *str);
void LCD_Ready(void);
void sdelay(int delay);

void TWI_init(void);
void Interrupt_init(void);
void start(void);
void Stop(void);
void Ack(void);
void Nack(void);
void display_data(void);
void write_one_time(void);
void read_one_time(void);

unsigned char conf[8] = {seconds, minutes, hours, day, date, month, year, SQWE};
unsigned char mode[2] = {(slave_add | write_mode), (slave_add | read_mode)};
unsigned char Data[7], count = 0, read, ext_int = 0, high_nibble, low_nibble;
char Hour, Minute, Second, Day, Date, Month, Year;
bit Mer, temp;

char MSB_read, LSB_read,flag;
int conf_index = 0, mode_index = 0, Data_index = 0;
int clk, AM, PM;
char check;

void TWI_init(void)
{
	SDA = 1;
	SCL = 1;
	SSCON &= 0x00;
	// SSCON & = 0xC5;
	SSCON = SSCON | bitrate;
	SSCON = SSCON | SSIE_enable;
	SSCON = SSCON & clear_TWI_start_stop_interrupt;
}

void Interrupt_subroutine () interrupt 8
{
	switch(SSCS)
	{
	
		case 0x08:
			SSDAT = mode[mode_index++];
			SSCON &= clear_TWI_stop_interrupt;
			break;
		case 0x10:
			SSDAT = mode[mode_index++];
			SSCON &= clear_TWI_stop_interrupt;
			break;
		case 0x20:
			SSCON = stop_comm;
			break;
		case 0x18:
			SSDAT = 0x00;
			SSCON &= clear_TWI_start_stop_interrupt;
			break;
		case 0x28:
			if (!read)
			{
				if(conf_index<8)
				{
					SSDAT = conf[conf_index++];
					SSCON &= clear_TWI_start_stop_interrupt;
				}
				else
				{
					SSCON = stop_comm;
					flag = 1;
				}
			}
			else
			{
				SSCON = stop_comm;
				flag = 1;
			}
			break;
		case 0X30:
			SSCON = stop_comm;
			break;
		case 0X40:
			SSCON = send_Ack;
			break;
		case 0x48:
			SSCON = stop_comm;
			break;
		case 0x50:
			if(Data_index < 5)
			{
				Data[Data_index++] = SSDAT;
				SSCON = send_Ack;
			}
			else
			{
				Data[Data_index++] = SSDAT;
				SSCON &= send_Nack;
			}
			break;
		case 0X58:
			Data[Data_index++] = SSDAT;
			Data_index = 0;
			SSCON = stop_comm;
			flag = 1;
			break;
	}
}

void Interrupt_init(void)
{
	P3 |= 0x04;
	IEN0 |= 0x84;
	IPL0 |= 0x04;
	IPH0 |= 0x04;
	IEN1 |= 0x02;
	IPL1 = 0x00;
	IPH1 = 0x02;
	TCON |= 0x04;
}

void Ext_interrupt_subroutine(void) interrupt 2
{
	ext_int = 1;
	TCON &= clear_ext_interrupt;
}

void start(void)
{
	SSCON |= start_comm;
}

void LCD_Init()
{
	LCD_CmdWrite(0x38);
	sdelay(100);
	LCD_CmdWrite(0x0E);
	sdelay(100);
	LCD_CmdWrite(0x01);
	sdelay(100);
	LCD_CmdWrite(0x80);
	sdelay(100);
}

void LCD_Ready()
{
	LCD_data = 0xFF;
	LCD_rs = 0;
	LCD_rw = 1;
	LCD_en = 0;
	sdelay(5);
	LCD_en = 1;
	while(LCD_busy == 1)
	{
		LCD_en = 0;
		LCD_en = 1;
	}
	LCD_en = 0;
}

void LCD_CmdWrite(char cmd)
{
	LCD_Ready();
	LCD_data = cmd;
	LCD_rs = 0;
	LCD_rw = 0;
	LCD_en = 1;
	sdelay(1);
	LCD_en = 0;
	sdelay(1);
}

void LCD_DataWrite( char dat)
{
	LCD_Ready();
	LCD_data = dat;
	LCD_rs = 1;
	LCD_rw = 0;
	LCD_en = 1;
	sdelay(1);
	LCD_en = 0;
	sdelay(1);
}

void LCD_StringWrite(unsigned char *str)
{
	int i=0;
	while(str[i] != 0)
	{
		LCD_DataWrite(str[i]);
		i++;
	}
	return;
}

void sdelay(int delay)
{
	char d = 0;
	while(delay > 0)
	{
		for(d = 0; d < 5; d++);
		delay--;
	}
}

void BCD_ASCII(unsigned char value)
{
	char num1,num2;
	num1 = (((value/128)%2)*8 + ((value/64)%2)*4 + ((value/32)%2)*2 + ((value/16)%2)*1) + 48;
	num2 = (((value/8)%2)*8 + ((value/4)%2)*4 + ((value/2)%2)*2 + (value%2)*1) + 48;
	LCD_DataWrite(num1);
	LCD_DataWrite(num2);
}

void Disp_time(void)
{
	LCD_CmdWrite(0x85);
	Hour = Data[2];
	Minute = Data[1];
	Second = Data[0];
	Hour &= 0xBF;
	Mer = ((Data[2]/2)%2);
	if(Mer)
	{
		Hour &= 0x9F;
	}
	PM = (Data[2]/4)%2;
	
	BCD_ASCII(Hour);
	LCD_DataWrite(':');
	BCD_ASCII(Minute);
	LCD_DataWrite(':');
	BCD_ASCII(Second);
	LCD_DataWrite(' ');
	if(PM && Mer)
	{
		LCD_StringWrite("PM");
	}
	else if(Mer)
	{
		LCD_StringWrite("AM");
	}
	else
	{
		LCD_StringWrite("Hr");
	}
}

void Disp_date(void)
{
	LCD_CmdWrite(0xC5);
	Day = Data[3];
	Date = Data[4];
	Month = Data[5];
	Year = Data[6];
	BCD_ASCII(Day);
	LCD_DataWrite(' ');
	BCD_ASCII(Date);
	LCD_DataWrite('/');
	BCD_ASCII(Month);
	LCD_DataWrite('/');
	BCD_ASCII(Year);
}

void display_data(void)
{
	Disp_time();
	Disp_date();
}

void write_one_time()
{
	flag = 0;
	mode_index = 0;
	conf_index = 0;
	read = 0;
	start();
	while(!flag);
}

void read_one_time()
{
	flag = 0;
	mode_index = 0;
	Data_index = 0;
	read = 1;
	start();
	while(!flag);
	flag = 0;
	start();
	while(!flag);
}

void main(void)
{
	P2 = 0x00;
	LCD_Init();
	Interrupt_init();
	TWI_init();

	write_one_time();
	LCD_CmdWrite(0x80);
	LCD_StringWrite("Time ");
	LCD_CmdWrite(0xC0);
	LCD_StringWrite("Date ");

	while(1)
	{
		if(ext_int)
		{
			ext_int = 0;
			read_one_time();
			display_data();
		}
	}
}
