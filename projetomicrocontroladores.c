#define  DIGIT2  RB4_bit
#define  DIGIT3  RB5_bit
#define  cima    RA3_bit
#define  ok      RA4_bit
#define  baixo   RA5_bit
#define TRUE    1
#define FALSE   0

bit oldstateCima, oldstateBaixo ,oldstateOk;
int Msd,Lsd= 0;
int digital = 1 ; int estado = 1;
char uart_rd; char txt[7]; char st[7]; long int valorAD = 0;

int setpoint = 13;
int Display(int no);


void interrupt(){
     if(TMR0IF_bit){
       if(digital){
          if(estado){
            PORTB = Display((setpoint/10) - ((setpoint%10)/10));
            DIGIT2 = 1;
            DIGIT3 = 0;
            }
          else{
          PORTB = Display(Msd);
          DIGIT2 = 1;
          DIGIT3 = 0;
          }
          
          digital = 0;
       }

      else{
          if(estado){
            PORTB = Display(setpoint%10);
            DIGIT2 = 0;
            DIGIT3 = 1;
            digital = 1;
          }
          else{
          PORTB = Display(Lsd);
          DIGIT2 = 0;
          DIGIT3 = 1;
          digital = 1;
          }

        }
       TMR0IF_bit = 0;
       TMR0 = 0x64;
     }


}

void main()
{
  CMCON = 0x07;                 // Desabilita os comparadores
  ADCON0 = 0x01;                // Desabilita os conversores AD
  ADCON1 = 0x0E;                // Tornar todo ADC digital

  TRISA.RA0 = 0x01;
  TRISA.RA3 = 0x01;
  TRISA.RA4 = 0x01;
  TRISA.RA5 = 0x01;

  
  OPTION_REG =  0x87;
  TMR0 = 0x64;
  INTCON = 0xE0;
  TRISE0_bit = 0x01;
  TRISE1_bit = 0x01;
  TRISE2_bit = 0x01;


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

      if(estado){
      IntToStr(cima, st);

      UART1_Write_Text(st);
      UART1_Write_Text(" Set point");
      UART1_Write(10);               // Realimentação de linha
      UART1_Write(13);               // Quebra de linha
      UART1_Write(13);               // Quebra de linha
      }else{
      IntToStr(valorAD, txt);

      UART1_Write_Text(txt);
      UART1_Write_Text(" PH");
      UART1_Write(10);               // Realimentação de linha
      UART1_Write(13);               // Quebra de linha

      }
      if(!cima){
       oldstateCima = 1;
       delay_ms(100);
      }
      if(oldstateCima && !cima){
      estado = ~estado;
      oldstateCima = 0;
      }
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