#define  DIGIT2  RB4_bit
#define  DIGIT3  RB5_bit
#define  cima    RE0_bit
#define  ok      RE1_bit
#define  baixo   RE2_bit

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
          DIGIT2 = 1;
          DIGIT3 = 0;
          digital = 0;
       }
        else{
          PORTB = Display(Lsd);
          DIGIT2 = 0;
          DIGIT3 = 1;
          digital = 1;
        }
       TMR0IF_bit = 0;
       TMR0 = 0x64;
     }

  if (TMR1IF_bit){
    if(cima){
      PORTB = 0x00;
    }
    if(baixo){
    }
    if(ok){
    }
    
    TMR1IF_bit = 0;
    TMR1H	 = 0x0B;
    TMR1L	 = 0xDC;
    //Enter your code here
  }

}

void main() 
{
  CMCON = 0x07;                 // Desabilita os comparadores
  ADCON0 = 0x01;                // Desabilita os conversores AD
  ADCON1 = 0x0E;                // Tornar todo ADC digital
  
  TRISA.RA0 = 0x01;
  
  T1CON	 = 0x31;
  TMR1IF_bit	 = 0;
  TMR1H	 = 0x0B;
  TMR1L	 = 0xDC;
  TMR1IE_bit	 = 1;

  OPTION_REG =  0x87;
  T1CON = 0x09;
  TMR0 = 0x64;
  INTCON = 0xE0;
  TRISE = 0xFF;
  TRISB  = 0x00;//PORTB configurado como saídas
  PORTB  = 0x00;
  DIGIT2 = 0; //Desabilita Digito1
  DIGIT3 = 0; //Desabilita Digito2

  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize

  UART1_Write_Text("Start");     // Escreve o texto Start
  UART1_Write(10);               // Realimentação de linha
  UART1_Write(13);               // Quebra de linha

  while (1) 
  {                               // Endless loop
      valorAD = ADC_Read(0);
      valorAD = ((valorAD * 14) / 1023) ;

      IntToStr(valorAD, txt);

      UART1_Write_Text(txt);
      UART1_Write_Text(" PH");
      UART1_Write(10);               // Realimentação de linha
      UART1_Write(13);               // Quebra de linha
      delay_ms(100);
         Msd = (valorAD/10) - ((valorAD%10)/10); // "5"
         Lsd = valorAD%10;                     //digito menos significativo ou unidade


  } //end while
} //end main
 int Display(int no){
        int Pattern;
        int SEGMENTO[] = {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09};
        Pattern = SEGMENTO[no]; //para retornar o Pattern
        return(Pattern);


}