#line 1 "C:/Users/IranJunior/Downloads/PIC021_files_WR/PIC021_files_WR/source_file_PIC021/pic020_v002.c"



int Msd,Lsd,Cnt = 0;
int digital = 1 ;

char uart_rd;
char txt[7];
long int valorAD = 0;

int Display(int no);


void interrupt(){
 if(TMR0IF_bit){


 if(digital){
 PORTB = Display(Msd);
  RB4_bit  = 1;
  RB5_bit  = 0;
 digital = 0;
 }
 else{
 PORTB = Display(Lsd);
  RB4_bit  = 0;
  RB5_bit  = 1;
 digital = 1;
 }
 TMR0IF_bit = 0;
 TMR0 = 0x00;
 }
}

void main()
{
 CMCON = 0x07;
 ADCON0 = 0x01;
 ADCON1 = 0x0E;

 TRISA.RA0 = 0x01;


 OPTION_REG = 0x80;
 T1CON = 0x09;
 TMR0 = 0x00;
 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 TMR0IE_bit = 0x01;

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
