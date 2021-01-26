#include <hidef.h>        /* common defines and macros */
#include "derivative.h"   /* derivative-specific definitions */

long count    = 0;
long xDesired = 2*7404;
long xMax     = 2*7404;
long xOld     = 0;
int newDuty   = 0;

int Kp        = 100;
int Kd        = 1000;
long int Ki   = 8000000;

long errorSum = 0;
long errorOld = 0;

void initPIT(void);
void PWM_for_Motor(void);
void PWM_init(void);

int En_Read   = 0x0000;
int L_DATA    = 0x00;
int U_DATA    = 0x00;

void main(void){
  initPIT();
  PWM_init();
  PWM_for_Motor();

  DDRA = 0xFF;
  DDRB = 0x00;
  
  EnableInterrupts;
  
  for(;;){
    _FEED_COP();
  }
}

void initPIT(void){
  PITMUX         = 0x00;
  PITCFLMT_PITE  = 1;
  PITCE_PCE0     = 1;
  PITMTLD0       = 0b11111111;
  PITLD0         = 7;
  PITINTE_PINTE0 = 1;
}

void interrupt 66 testCode(void){
  PITTF_PTF0 = 1;

  // PORTA_PA2=0;
  // PORTA_PA3=0;
  PORTA     = 0x00;                   // Enable = 0, Select Pin = 0 {SEL = PA2, OE = PA3}
  U_DATA    = PORTB;

  // PORTA_PA2 = 1;
  // PORTA_PA3 = 0;
  PORTA     = 0x04;                   // Enable = 0, Select Pin = 1 {SEL = PA2, OE = PA3}
  L_DATA    = PORTB;
  
  En_Read   = (U_DATA << 8)|L_DATA;   // Combining lower byte and Upper Byte into a 16-bit binary number
  PORTA     = 0x08;                   // Inhibit Logic reset Enable Pin = 1, Select Pin = X
  count++;
  
  if (newDuty < 0){
    PORTA_PA0 = 1;      // IN B to PA0
    PORTA_PA1 = 0;      // IN A to PA1
    newDuty   = newDuty*(-1);
  }
  else{
    PORTA_PA0 = 0;
    PORTA_PA1 = 1;
  }
  PWMDTY5     = newDuty;
  xOld        = En_Read;
  if (count % 2500 == 0){
    xDesired  = xMax - xDesired;
  }
}

// PWM for motor and decoder clock
void PWM_for_Motor(){
  PWMCLK_PCLK5 = 0;
  PWME_PWME5   = 1;
  PWMPOL_PPOL5 = 1;
  PWMPRCLK     = 0x01;
  // PWMDTY5   = 0x80;
  PWMPER5      = 0xFF;
}

// PWM for decoder clock
void PWM_init(){
  PWMCLK_PCLK0 = 0;
  PWME_PWME0   = 1;
  PWMPOL_PPOL0 = 1;
  PWMPRCLK     = 0x00;
  PWMDTY0      = 0x04;
  PWMPER0      = 0x08;
}