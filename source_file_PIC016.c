
#define DIGIT2 PORTC.RC7
#define DIGIT3 PORTC.RC6


int leitura  = 0;
float ph = 0;
int Msd,Lsd,Cnt = 0;


int Display(int no);
void changeCount(int valor);

void main() //inicio programa principal
{
    ADCON0 =  0xC9;
    CMCON = 0x00;
    
    TRISC  = 0x00;
    TRISB  = 0x00;//PORTB configurado como saídas
    PORTB  = 0x00;
    DIGIT2 = 0; //Desabilita Digito1
    DIGIT3 = 0; //Desabilita Digito2
    adc_init();

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



    
    delay_us(180);


 Msd = (Cnt%100);   //53   , 5,3 , 3  ,   0,3
 Msd = (Msd/10) - ((Msd%10)/10); // "5"

 PORTB=Display(Msd);               //Envia para PORTB
 DIGIT2=1;                         //habilita digito 2(dezena)
 delay_ms(5);                      //aguarda 5 milisegundos
 DIGIT2=0;                         //desabilita digito 2(dezena)
                                   //"3"
 Lsd=Cnt%10;                       //digito menos significativo ou unidade

 PORTB=Display(Lsd);               //Envia para PORTB
 DIGIT3=1;                         //habilita digito 3(unidade)
 delay_ms(5);                      //aguarda 5 milisegundos
 DIGIT3=0;                         //desabilita digito 3(unidade)
} // end while
} //end void main


//esta função acha o bit pattern(matrix de bits) para ser enviado
//para o PORTB e mostrar um número no display de 7 segmentos.O número
//é passado como um argumento para a função.
int Display(int no)
{
int Pattern;
int SEGMENTO[] = {0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09};
Pattern=SEGMENTO[no]; //para retornar o Pattern
return(Pattern);
} //end função