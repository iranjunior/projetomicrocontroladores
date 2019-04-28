
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt0
	MOVF       _digital+0, 0
	IORWF      _digital+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt1
	MOVF       _estado+0, 0
	IORWF      _estado+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt2
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _setpoint+0, 0
	MOVWF      R0+0
	MOVF       _setpoint+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__interrupt+0
	MOVF       R0+1, 0
	MOVWF      FLOC__interrupt+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _setpoint+0, 0
	MOVWF      R0+0
	MOVF       _setpoint+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	SUBWF      FLOC__interrupt+0, 0
	MOVWF      FARG_Display_no+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FLOC__interrupt+1, 0
	MOVWF      FARG_Display_no+1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L_interrupt3
L_interrupt2:
	MOVF       _Msd+0, 0
	MOVWF      FARG_Display_no+0
	MOVF       _Msd+1, 0
	MOVWF      FARG_Display_no+1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
L_interrupt3:
	CLRF       _digital+0
	CLRF       _digital+1
	GOTO       L_interrupt4
L_interrupt1:
	MOVF       _estado+0, 0
	IORWF      _estado+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_interrupt5
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _setpoint+0, 0
	MOVWF      R0+0
	MOVF       _setpoint+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_Display_no+0
	MOVF       R0+1, 0
	MOVWF      FARG_Display_no+1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
	MOVLW      1
	MOVWF      _digital+0
	MOVLW      0
	MOVWF      _digital+1
	GOTO       L_interrupt6
L_interrupt5:
	MOVF       _Lsd+0, 0
	MOVWF      FARG_Display_no+0
	MOVF       _Lsd+1, 0
	MOVWF      FARG_Display_no+1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
	MOVLW      1
	MOVWF      _digital+0
	MOVLW      0
	MOVWF      _digital+1
L_interrupt6:
L_interrupt4:
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	MOVLW      100
	MOVWF      TMR0+0
L_interrupt0:
L_end_interrupt:
L__interrupt19:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

	MOVLW      7
	MOVWF      CMCON+0
	MOVLW      1
	MOVWF      ADCON0+0
	MOVLW      14
	MOVWF      ADCON1+0
	BSF        TRISA+0, 0
	BSF        TRISA+0, 3
	BSF        TRISA+0, 4
	BSF        TRISA+0, 5
	MOVLW      135
	MOVWF      OPTION_REG+0
	MOVLW      100
	MOVWF      TMR0+0
	MOVLW      224
	MOVWF      INTCON+0
	BSF        TRISE0_bit+0, BitPos(TRISE0_bit+0)
	BSF        TRISE1_bit+0, BitPos(TRISE1_bit+0)
	BSF        TRISE2_bit+0, BitPos(TRISE2_bit+0)
	CLRF       TRISB+0
	CLRF       PORTB+0
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
	NOP
	MOVLW      ?lstr1_projetomicrocontroladores+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
L_main8:
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _valorAD+0
	MOVF       R0+1, 0
	MOVWF      _valorAD+1
	CLRF       _valorAD+2
	CLRF       _valorAD+3
	MOVF       _valorAD+0, 0
	MOVWF      R0+0
	MOVF       _valorAD+1, 0
	MOVWF      R0+1
	MOVF       _valorAD+2, 0
	MOVWF      R0+2
	MOVF       _valorAD+3, 0
	MOVWF      R0+3
	MOVLW      14
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      _valorAD+0
	MOVF       R0+1, 0
	MOVWF      _valorAD+1
	MOVF       R0+2, 0
	MOVWF      _valorAD+2
	MOVF       R0+3, 0
	MOVWF      _valorAD+3
	MOVF       _estado+0, 0
	IORWF      _estado+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVLW      0
	BTFSC      RA3_bit+0, BitPos(RA3_bit+0)
	MOVLW      1
	MOVWF      FARG_IntToStr_input+0
	CLRF       FARG_IntToStr_input+1
	MOVLW      _st+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
	MOVLW      _st+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
	MOVLW      ?lstr2_projetomicrocontroladores+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
	GOTO       L_main11
L_main10:
	MOVF       _valorAD+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _valorAD+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _txt+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
	MOVLW      _txt+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
	MOVLW      ?lstr3_projetomicrocontroladores+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
L_main11:
	BTFSC      RA3_bit+0, BitPos(RA3_bit+0)
	GOTO       L_main12
	BSF        _oldstateCima+0, BitPos(_oldstateCima+0)
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	DECFSZ     R11+0, 1
	GOTO       L_main13
	NOP
	NOP
L_main12:
	BTFSS      _oldstateCima+0, BitPos(_oldstateCima+0)
	GOTO       L_main16
	BTFSC      RA3_bit+0, BitPos(RA3_bit+0)
	GOTO       L_main16
L__main17:
	COMF       _estado+0, 1
	COMF       _estado+1, 1
	BCF        _oldstateCima+0, BitPos(_oldstateCima+0)
L_main16:
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _valorAD+0, 0
	MOVWF      R0+0
	MOVF       _valorAD+1, 0
	MOVWF      R0+1
	MOVF       _valorAD+2, 0
	MOVWF      R0+2
	MOVF       _valorAD+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+4
	MOVF       R0+1, 0
	MOVWF      FLOC__main+5
	MOVF       R0+2, 0
	MOVWF      FLOC__main+6
	MOVF       R0+3, 0
	MOVWF      FLOC__main+7
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _valorAD+0, 0
	MOVWF      R0+0
	MOVF       _valorAD+1, 0
	MOVWF      R0+1
	MOVF       _valorAD+2, 0
	MOVWF      R0+2
	MOVF       _valorAD+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVF       R0+2, 0
	MOVWF      FLOC__main+2
	MOVF       R0+3, 0
	MOVWF      FLOC__main+3
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       FLOC__main+2, 0
	MOVWF      R0+2
	MOVF       FLOC__main+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_S+0
	MOVF       R0+0, 0
	SUBWF      FLOC__main+4, 0
	MOVWF      _Msd+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FLOC__main+5, 0
	MOVWF      _Msd+1
	MOVF       FLOC__main+0, 0
	MOVWF      _Lsd+0
	MOVF       FLOC__main+1, 0
	MOVWF      _Lsd+1
	GOTO       L_main8
L_end_main:
	GOTO       $+0
; end of _main

_Display:

	CLRF       Display_SEGMENTO_L0+0
	CLRF       Display_SEGMENTO_L0+1
	MOVLW      1
	MOVWF      Display_SEGMENTO_L0+2
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+3
	MOVLW      2
	MOVWF      Display_SEGMENTO_L0+4
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+5
	MOVLW      3
	MOVWF      Display_SEGMENTO_L0+6
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+7
	MOVLW      4
	MOVWF      Display_SEGMENTO_L0+8
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+9
	MOVLW      5
	MOVWF      Display_SEGMENTO_L0+10
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+11
	MOVLW      6
	MOVWF      Display_SEGMENTO_L0+12
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+13
	MOVLW      7
	MOVWF      Display_SEGMENTO_L0+14
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+15
	MOVLW      8
	MOVWF      Display_SEGMENTO_L0+16
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+17
	MOVLW      9
	MOVWF      Display_SEGMENTO_L0+18
	MOVLW      0
	MOVWF      Display_SEGMENTO_L0+19
	MOVF       FARG_Display_no+0, 0
	MOVWF      R0+0
	MOVF       FARG_Display_no+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      Display_SEGMENTO_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R0+1
L_end_Display:
	RETURN
; end of _Display
