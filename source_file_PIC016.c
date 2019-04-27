
#define DIGIT2 PORTC.RC7
#define DIGIT3 PORTC.RC6


int leitura  = 0;
float ph = 0;
int Msd,Lsd,Cnt = 0;
int digital = 1 ;

int Display(int no);
void interrupt();

void main() //inicio programa principal
{
    ADCON0 =  0xC9;
    CMCON = 0x00;
    
    OPTION_REG =  0x80;
    T1CON = 0xFF;
    TMR0 = 0x00;
    GIE_bit = 0x01;
    PEIE_bit = 0x01;
    TMR0IE_bit = 0x01;
    
    //ADIE_bit = 0x01;
    
    TRISC  = 0x00;
    TRISB  = 0x00;//PORTB configurado como sa�das
    PORTB  = 0x00;
    DIGIT2 = 0; //Desabilita Digito1
    DIGIT3 = 0; //Desabilita Digito2
    //adc_init();

while(1) //loop infinito
{
              leitura = ADC_Read(1);
              ph = ((leitura * 14) / 1023) ;
              
              if (ph >= 0 && ph < 0.8)
              Cnt = 0;

              if(ph  >=0.8 && ph < 1.8)
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
          Msd = (Msd/10) - ((Msd%10)/10); // "5"
          Lsd=Cnt%10;                     //digito menos significativo ou unidade

          delay_us(180);
    } // end while
} //end void main


//esta fun��o acha o bit pattern(matrix de bits) para ser enviado
//para o PORTB e mostrar um n�mero no display de 7 segmentos.O n�mero
//� passado como um argumento para a fun��o.
    int Display(int no){
        int Pattern;
        int SEGMENTO[] = {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09};
        Pattern = SEGMENTO[no]; //para retornar o Pattern
        return(Pattern);
    }

    void interrupt(){
     if(T0IF_bit){

        if(digital) {

          PORTB=Display(Msd);               //Envia para PORTB
          //PORTB = 0x07;
          DIGIT2=1;                         //habilita digito 2(dezena)
          DIGIT2=0;                         //desabilita digito 2(dezena)
                                            //"3"
          digital = 0;
        }
         else{

           PORTB=Display(Lsd);               //Envia para PORTB
           //PORTB = 0x03;
           DIGIT3=1;                         //habilita digito 3(unidade)
           DIGIT3=0;                         //desabilita digito 3(unidade)
           digital = 1;
         }

     }
}

//end fun��o