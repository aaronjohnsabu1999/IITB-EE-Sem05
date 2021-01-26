unsigned int moving_avg(unsigned int);
enum{f_no_samples = 8};

unsigned int moving_avg(unsigned int sample)
{
	static int cap=f_no_samples+1;
	static  int f_data[f_no_samples+1];
	static signed int f_index=0;
	static signed int f_avg=0;
	
	f_data[f_index++] = sample;
	f_index %= cap;
	f_avg += (sample - f_data[f_index]);
	
	return ((unsigned int) (f_avg/f_no_samples) & 0x0fff);
}
