#line 1 "D:/ENGENHARIA DE CONTROLE E AUTOMAÇÃO/9 º PERIODO/Microcontroladores/projetomicrocontroladores/projetomicrocontroladores.c"
#line 13 "D:/ENGENHARIA DE CONTROLE E AUTOMAÇÃO/9 º PERIODO/Microcontroladores/projetomicrocontroladores/projetomicrocontroladores.c"
bit blink, digital, state;
int Msd, Lsd = 0;
int countTimer1 = 0;
int countTimer2_v1 = 0;
int countTimer2_v2 = 0;

int PH = 0;

unsigned int timeDelayON[] = {
 0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240, 260};

unsigned int timeDelayOFF[] = {
 500, 480, 460, 440, 420, 400, 380, 360, 340, 320, 300, 280, 260, 240};

unsigned int count = 0;




short setpoint, beforeGap, gap = 0;

int Display(int no);

void interrupt()
{

 if (TMR1IF_bit)
 {
 if (blink)
 {
 if (digital)
 {
 if (state)
 {
 PORTB = Display((setpoint / 10) - ((setpoint % 10) / 10));
  RB4_bit  = 1;
  RB5_bit  = 0;
 }
 else
 {
 PORTB = Display(Msd);
  RB4_bit  = 1;
  RB5_bit  = 0;
 }

 digital = 0;
 }

 else
 {
 if (state)
 {
 PORTB = Display(setpoint % 10);
  RB4_bit  = 0;
  RB5_bit  = 1;
 digital = 1;
 }
 else
 {
 PORTB = Display(Lsd);
  RB4_bit  = 0;
  RB5_bit  = 1;
 digital = 1;
 }
 }
 }
 else
 {
  RB4_bit  = 0x01;
  RB5_bit  = 0x01;
 }
 TMR1IF_bit = 0;
 TMR1H = 0x63;
 TMR1L = 0xC0;

 }

 if (TMR0IF_bit)
 {
 if (countTimer1 == 50)
 {
 countTimer1 = 0;

 blink = blink == 1 && state == 1 ? 0 : 1;
 }
 TMR0IF_bit = 0;
 TMR0 = 61;
 countTimer1++;

 }

 if (TMR2IF_bit)
 {
 if (countTimer2_v1 == 30)
 {
 countTimer2_v1 = 0;
 if ( RD0_bit )
 {
 state = 1;
 setpoint = setpoint == 14 ? 14 : ++setpoint;
 }

 if ( RD2_bit )
 {
 state = 1;
 setpoint = setpoint == 0 ? 0 : --setpoint;
 }
 }
 if (countTimer2_v2 == 70)
 {
 countTimer2_v2 = 0;
 if ( RD1_bit )
 {
 EEPROM_Write(0x00, setpoint);
 delay_ms(20);
 state = !state;
 }
 }
 countTimer2_v1++;
 countTimer2_v2++;
 TMR2IF_bit = 0;

 }
}

void main()
{
 setpoint = EEPROM_Read(0x00) < 0 ? 0 : EEPROM_Read(0x00);
 delay_ms(10);
 setpoint = EEPROM_Read(0x00) > 14 ? 14 : EEPROM_Read(0x00);
 CMCON = 0x07;
 ADCON0 = 0x01;
 ADCON1 = 0x05;

 TRISA.RA0 = 0x01;
 TRISD = 0x07;
 PORTD = 0x00;


 T1CON = 0x01;
 TMR1IF_bit = 0;
 TMR1H = 0x63;
 TMR1L = 0xC0;
 TMR1IE_bit = 1;


 OPTION_REG = 0x87;
 TMR0 = 61;
 INTCON = 0xE0;


 T2CON = 0x66;
 PR2 = 240;
 TMR2IE_bit = 1;

 TRISB = 0x00;
 PORTB = 0x00;
  RB4_bit  = 0;
  RB5_bit  = 0;

 RD4_bit = 0;
 RD5_bit = 0;
 RD6_bit = 1;
 RD7_bit = 1;

 while (1)
 {
 beforeGap = gap;
 PH = ADC_Read(0);
 PH = ((PH * 14) / 1023);
 if (setpoint - PH < 0)
 gap = 0;
 else
 gap = setpoint - PH;
 if (gap != beforeGap)
 count = 0;

 delay_ms(10);

 if (count < timeDelayON[gap])
 {
 RD4_bit = 1;
 RD5_bit = 1;
 }
 else if (count < timeDelayOFF[gap])
 {
 RD4_bit = 0;
 RD5_bit = 0;
 }
 else
 {
 count = 0;
 }

 Msd = (PH / 10) - ((PH % 10) / 10);
 Lsd = PH % 10;

 count++;
 }
}
int Display(int no)
{
 int Pattern;
 int SEGMENTO[] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09};
 Pattern = SEGMENTO[no];
 return (Pattern);
}
