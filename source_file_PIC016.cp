#line 1 "D:/ENGENHARIA DE CONTROLE E AUTOMAÇÃO/9 º PERIODO/Microcontroladores/source_file_PIC016.c"





int leitura = 0;
float ph = 0;
int Msd,Lsd,Cnt = 0;
int digital = 1 ;

int Display(int no);
void interrupt();

void main()
{
 ADCON0 = 0xC5;
 CMCON = 0x00;

 OPTION_REG = 0x80;
 T1CON = 0xFF;
 TMR0 = 0x00;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 T0IE_bit = 0x01;

 ADIE_bit = 0x01;

 TRISC = 0x00;
 TRISB = 0x00;
 PORTB = 0x00;
  PORTC.RC7  = 0;
  PORTC.RC6  = 0;
 adc_init();

while(1)
{
 if (ph >= 0 && ph < 0.8)
 Cnt = 0;

 if(ph >=0.8 && ph < 1.8)
 Cnt = 1;

 if(ph >= 1.8 && ph < 2.8)
 Cnt = 2;


 if(ph >=2.8 && ph < 3.8)
 Cnt = 3;


 if(ph >= 3.8 && ph < 4.8)
 Cnt = 4;


 if(ph >= 4.8 && ph < 5.8)
 Cnt = 5;


 if(ph >= 5.8 && ph < 6.8)
 Cnt = 6;


 if(ph >= 6.8 && ph < 7.8)
 Cnt = 7;

 if(ph >= 7.8 && ph < 8.8)
 Cnt = 8;


 if(ph >= 8.8 && ph < 9.8)
 Cnt = 9;


 if(ph >= 9.8 && ph < 10.8)
 Cnt = 10;


 if(ph >= 10.8 && ph < 11.8)
 Cnt = 11;


 if(ph >= 11.8 && ph < 12.8)
 Cnt = 12;


 if(ph >= 12.8 && ph < 13.5)
 Cnt = 13;

 if(ph >= 13.5)
 Cnt = 14;

 Msd = (Cnt%100);
 Msd = (Msd/10) - ((Msd%10)/10);
 Lsd=Cnt%10;

 delay_us(180);
 }
}





 int Display(int no){
 int Pattern;
 int SEGMENTO[] = {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09};
 Pattern = SEGMENTO[no];
 return(Pattern);
 }

 void interrupt(){
 if(ADIF_bit){
 leitura = ADC_Read(1);
 ph = ((leitura * 14) / 1023) ;

 }

 if(T0IF_bit){

 if(digital) {

 PORTB=Display(Msd);

  PORTC.RC7 =1;
  PORTC.RC7 =0;

 digital = 0;
 }
 else{

 PORTB=Display(Lsd);

  PORTC.RC6 =1;
  PORTC.RC6 =0;
 digital = 1;
 }

 }
}
