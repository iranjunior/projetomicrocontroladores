#define DIGIT2 RB4_bit
#define DIGIT3 RB5_bit
#define cima RD0_bit
#define ok RD1_bit
#define baixo RD2_bit
#define TRUE 1
#define FALSE 0
#define address 0x00
// criacao de variaveis de estado
// blink, guarda se o display está ligado ou apagado, na hora de mostrar o setpoint
// digital, guarda qual o display a ser ligado no momento, se é o da dezena ou o da unidade
// state, guarda se é para exibir a leitura do sensor ou o valor guardado no setpoint
bit blink, digital, state;
int Msd, Lsd = 0;         //guarda os valores das dezenas (Msd), e os valores das unidades (Lsd)
int countTimer1 = 0;      //conta quantos overflows do timer 1 já houveram para ligar/desligar os displays
int countTimer2_v1 = 0;   //conta quantos overflows do timer 2 já houveram para verificar se o botão de cima/baixo foi pressionado
int countTimer2_v2 = 0;   //conta quantos overflows do timer 2 já houveram para verificar se o botão de ok foi pressionado

int PH = 0;               // guarda o valor lido na entrada analogica          
//tempo de motor ligado
unsigned int timeDelayON[] = {
    0, 20, 40, 60, 80, 100, 120, 140, 160, 180, 200, 220, 240, 260};
//tempo de motor desligado
unsigned int timeDelayOFF[] = {
    500, 480, 460, 440, 420, 400, 380, 360, 340, 320, 300, 280, 260, 240};
//counta o tempo do programa
unsigned int count = 0;
//ciração de variaveis usadas no programa
//setpoint, guarda o valor setado como setpoint
// beforeGap, guarda o ultimo valor de gap entre o setpoint e o ph lido na entrada analogica
// gap, guarda a diferença entre o valor lido e o valor setado 
short setpoint, beforeGap, gap = 0;

int Display(int no);   // declaração da função responsavel por exibir os numeros no display

void interrupt()      //funcção chamada sempre que houver uma interrupção de qualquer natureza que seja
{

  if (TMR1IF_bit)     //verifica se houve um overflow no timer 1
  {
    if (blink)        //se o blink for 1, significa que o display de 7 segmentos deve ser ligado
    {
      if (digital)    //se o digital for 1, significa que o valor a ser exibido no momento é o da deza
      {
        if (state)    //se o state for 1, o valor a ser mostrado no display é do setpoint
        {
          PORTB = Display((setpoint / 10) - ((setpoint % 10) / 10)); 
          DIGIT2 = 1;  
          DIGIT3 = 0;
        }
        else
        {
          PORTB = Display(Msd);
          DIGIT2 = 1;
          DIGIT3 = 0;
        }

        digital = 0;
      }

      else
      {
        if (state)
        {
          PORTB = Display(setpoint % 10);
          DIGIT2 = 0;
          DIGIT3 = 1;
          digital = 1;
        }
        else
        {
          PORTB = Display(Lsd);
          DIGIT2 = 0;
          DIGIT3 = 1;
          digital = 1;
        }
      }
    }
    else
    {
      DIGIT2 = 0x01;
      DIGIT3 = 0x01;
    }
    TMR1IF_bit = 0;
    TMR1H = 0x63;
    TMR1L = 0xC0;
    //Enter your code here
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
    //Enter your code here
  }

  if (TMR2IF_bit)
  {
    if (countTimer2_v1 == 30)
    {
      countTimer2_v1 = 0;
      if (cima)
      {
        state = 1;
        setpoint = setpoint == 14 ? 14 : ++setpoint;
      }

      if (baixo)
      {
        state = 1;
        setpoint = setpoint == 0 ? 0 : --setpoint;
      }
    }
    if (countTimer2_v2 == 70)
    {
      countTimer2_v2 = 0;
      if (ok)
      {
        EEPROM_Write(0x00, setpoint);
        delay_ms(20);
        state = !state;
      }
    }
    countTimer2_v1++;
    countTimer2_v2++;
    TMR2IF_bit = 0;
    //Enter your code here
  }
}

void main()
{
  setpoint = EEPROM_Read(0x00) < 0 ? 0 : EEPROM_Read(0x00);
  delay_ms(10);
  setpoint = EEPROM_Read(0x00) > 14 ? 14 : EEPROM_Read(0x00);
  CMCON = 0x07;  // Desabilita os comparadores
  ADCON0 = 0x01; // Desabilita os conversores AD
  ADCON1 = 0x05; // Tornar todo ADC digital

  TRISA.RA0 = 0x01;
  TRISD = 0x07;
  PORTD = 0x00;

  //configura��o do timer 1,  ele � o responsavel pela multiplexa��o
  T1CON = 0x01;
  TMR1IF_bit = 0;
  TMR1H = 0x63;
  TMR1L = 0xC0;
  TMR1IE_bit = 1;

  //configura��o do timer 0,  ele � o responsavel por piscar indicando o setpoint
  OPTION_REG = 0x87;
  TMR0 = 61;
  INTCON = 0xE0;

  //configura��o do timer 2, ele � reponsavel por checar se os bot�es foram pressionados
  T2CON = 0x66;
  PR2 = 240;
  TMR2IE_bit = 1;

  TRISB = 0x00; //PORTB configurado como sa�das
  PORTB = 0x00;
  DIGIT2 = 0; //Desabilita Digito1
  DIGIT3 = 0; //Desabilita Digito2

  RD4_bit = 0;
  RD5_bit = 0;
  RD6_bit = 1;
  RD7_bit = 1;

  while (1)
  { // Endless loop
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

    Msd = (PH / 10) - ((PH % 10) / 10); // "5"
    Lsd = PH % 10;                           //digito menos significativo ou unidade

    count++;
  } //end while
} //end main
int Display(int no)
{
  int Pattern;
  int SEGMENTO[] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09};
  Pattern = SEGMENTO[no]; //para retornar o Pattern
  return (Pattern);
}