#line 1 "D:/ENGENHARIA DE CONTROLE E AUTOMAÇÃO/9 º PERIODO/Microcontroladores/projetomicrocontroladores/projetomicrocontroladores.c"






int Msd,Lsd,Cnt = 0;
int digital = 1 ;

char uart_rd;
char txt[7];
char st[7];
long int valorAD = 0;
int estado = 1;

int setpoint = 13;
int Display(int no);


void interrupt(){
 if(TMR0IF_bit){


 if(digital){
 if(estado){
 PORTB = Display((setpoint/10) - ((setpoint%10)/10));
  RB4_bit  = 1;
  RB5_bit  = 0;
 digital = 0;
 estado = 0;
 }
 else{
 PORTB = Display(Msd);
  RB4_bit  = 1;
  RB5_bit  = 0;
 digital = 0;
 estado = 0;
 }
 }
 else{
 if(estado){
 PORTB = Display(setpoint%10);
  RB4_bit  = 0;
  RB5_bit  = 1;
 digital = 1;
 estado = 0;
 }
 else{
 PORTB = Display(Lsd);
  RB4_bit  = 0;
  RB5_bit  = 1;
 digital = 1;
 estado = 0;
 }
 }
 TMR0IF_bit = 0;
 TMR0 = 0x64;
 }

 if (TMR1IF_bit){
 if( RE0_bit ){
 estado = estado == 1 ? 0 : 1;
 }
 if( RE2_bit ){
 }
 if( RE1_bit ){
 }

 TMR1IF_bit = 0;
 TMR1H = 0x0B;
 TMR1L = 0xDC;

 }

}

void main()
{
 CMCON = 0x07;
 ADCON0 = 0x01;
 ADCON1 = 0x0E;

 TRISA.RA0 = 0x01;

 T1CON = 0x31;
 TMR1IF_bit = 0;
 TMR1H = 0x0B;
 TMR1L = 0xDC;
 TMR1IE_bit = 1;

 OPTION_REG = 0x87;
 T1CON = 0x09;
 TMR0 = 0x64;
 INTCON = 0xE0;
 TRISE = 0xFF;
 TRISB = 0x00;
 PORTB = 0x00;
  RB4_bit  = 0;
  RB5_bit  = 0;

 UART1_Init(9600);
 Delay_ms(100);

 UART1_Write_Text("Start");
 UART1_Write(10);
 UART1_Write(13);

 while (1)
 {
 valorAD = ADC_Read(0);
 valorAD = ((valorAD * 14) / 1023) ;

 IntToStr(valorAD, txt);

 UART1_Write_Text(txt);
 UART1_Write_Text(" PH");
 UART1_Write(10);
 UART1_Write(13);

 IntToStr(setpoint, st);
 UART1_Write_Text(st);
 UART1_Write_Text(" Set point");
 UART1_Write(10);
 UART1_Write(13);
 UART1_Write(13);


 delay_ms(100);
 Msd = (valorAD/10) - ((valorAD%10)/10);
 Lsd = valorAD%10;


 }
}
 int Display(int no){
 int Pattern;
 int SEGMENTO[] = {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09};
 Pattern = SEGMENTO[no];
 return(Pattern);
 }
