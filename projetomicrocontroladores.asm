
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

	BTFSS      TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	GOTO       L_interrupt0
	BTFSS      _blink+0, BitPos(_blink+0)
	GOTO       L_interrupt1
	BTFSS      _digital+0, BitPos(_digital+0)
	GOTO       L_interrupt2
	BTFSS      _state+0, BitPos(_state+0)
	GOTO       L_interrupt3
	MOVLW      10
	MOVWF      R4+0
	MOVF       _setpoint+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__interrupt+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _setpoint+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	SUBWF      FLOC__interrupt+0, 0
	MOVWF      FARG_Display_no+0
	CLRF       FARG_Display_no+1
	BTFSS      STATUS+0, 0
	DECF       FARG_Display_no+1, 1
	MOVLW      0
	BTFSC      FLOC__interrupt+0, 7
	MOVLW      255
	ADDWF      FARG_Display_no+1, 1
	MOVLW      1
	BTFSS      R0+0, 7
	MOVLW      0
	ADDWF      FARG_Display_no+1, 1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L_interrupt4
L_interrupt3:
	MOVF       _Msd+0, 0
	MOVWF      FARG_Display_no+0
	MOVF       _Msd+1, 0
	MOVWF      FARG_Display_no+1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
L_interrupt4:
	BCF        _digital+0, BitPos(_digital+0)
	GOTO       L_interrupt5
L_interrupt2:
	BTFSS      _state+0, BitPos(_state+0)
	GOTO       L_interrupt6
	MOVLW      10
	MOVWF      R4+0
	MOVF       _setpoint+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FARG_Display_no+0
	MOVLW      0
	BTFSC      FARG_Display_no+0, 7
	MOVLW      255
	MOVWF      FARG_Display_no+1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
	BSF        _digital+0, BitPos(_digital+0)
	GOTO       L_interrupt7
L_interrupt6:
	MOVF       _Lsd+0, 0
	MOVWF      FARG_Display_no+0
	MOVF       _Lsd+1, 0
	MOVWF      FARG_Display_no+1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
	BSF        _digital+0, BitPos(_digital+0)
L_interrupt7:
L_interrupt5:
	GOTO       L_interrupt8
L_interrupt1:
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
L_interrupt8:
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	MOVLW      99
	MOVWF      TMR1H+0
	MOVLW      192
	MOVWF      TMR1L+0
L_interrupt0:
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt9
	MOVLW      0
	XORWF      _countTimer1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt44
	MOVLW      50
	XORWF      _countTimer1+0, 0
L__interrupt44:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt10
	CLRF       _countTimer1+0
	CLRF       _countTimer1+1
	BTFSS      _blink+0, BitPos(_blink+0)
	GOTO       L_interrupt13
	BTFSS      _state+0, BitPos(_state+0)
	GOTO       L_interrupt13
L__interrupt41:
	CLRF       ?FLOC___interruptT9+0
	GOTO       L_interrupt14
L_interrupt13:
	MOVLW      1
	MOVWF      ?FLOC___interruptT9+0
L_interrupt14:
	BTFSC      ?FLOC___interruptT9+0, 0
	GOTO       L__interrupt45
	BCF        _blink+0, BitPos(_blink+0)
	GOTO       L__interrupt46
L__interrupt45:
	BSF        _blink+0, BitPos(_blink+0)
L__interrupt46:
L_interrupt10:
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	MOVLW      61
	MOVWF      TMR0+0
	INCF       _countTimer1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _countTimer1+1, 1
L_interrupt9:
	BTFSS      TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
	GOTO       L_interrupt15
	MOVLW      0
	XORWF      _countTimer2_v1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt47
	MOVLW      30
	XORWF      _countTimer2_v1+0, 0
L__interrupt47:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt16
	CLRF       _countTimer2_v1+0
	CLRF       _countTimer2_v1+1
	BTFSS      RD0_bit+0, BitPos(RD0_bit+0)
	GOTO       L_interrupt17
	BSF        _state+0, BitPos(_state+0)
	MOVF       _setpoint+0, 0
	XORLW      14
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt18
	MOVLW      14
	MOVWF      ?FLOC___interruptT13+0
	GOTO       L_interrupt19
L_interrupt18:
	INCF       _setpoint+0, 1
	MOVF       _setpoint+0, 0
	MOVWF      ?FLOC___interruptT13+0
L_interrupt19:
	MOVF       ?FLOC___interruptT13+0, 0
	MOVWF      _setpoint+0
L_interrupt17:
	BTFSS      RD2_bit+0, BitPos(RD2_bit+0)
	GOTO       L_interrupt20
	BSF        _state+0, BitPos(_state+0)
	MOVF       _setpoint+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt21
	CLRF       ?FLOC___interruptT16+0
	GOTO       L_interrupt22
L_interrupt21:
	DECF       _setpoint+0, 1
	MOVF       _setpoint+0, 0
	MOVWF      ?FLOC___interruptT16+0
L_interrupt22:
	MOVF       ?FLOC___interruptT16+0, 0
	MOVWF      _setpoint+0
L_interrupt20:
L_interrupt16:
	MOVLW      0
	XORWF      _countTimer2_v2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt48
	MOVLW      70
	XORWF      _countTimer2_v2+0, 0
L__interrupt48:
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt23
	CLRF       _countTimer2_v2+0
	CLRF       _countTimer2_v2+1
	BTFSS      RD1_bit+0, BitPos(RD1_bit+0)
	GOTO       L_interrupt24
	CLRF       FARG_EEPROM_Write_Address+0
	MOVF       _setpoint+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_interrupt25:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt25
	DECFSZ     R12+0, 1
	GOTO       L_interrupt25
	NOP
	NOP
	MOVLW
	XORWF      _state+0, 1
L_interrupt24:
L_interrupt23:
	INCF       _countTimer2_v1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _countTimer2_v1+1, 1
	INCF       _countTimer2_v2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _countTimer2_v2+1, 1
	BCF        TMR2IF_bit+0, BitPos(TMR2IF_bit+0)
L_interrupt15:
L_end_interrupt:
L__interrupt43:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVLW      0
	SUBWF      R0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_main26
	CLRF       ?FLOC___mainT23+0
	GOTO       L_main27
L_main26:
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      ?FLOC___mainT23+0
L_main27:
	MOVF       ?FLOC___mainT23+0, 0
	MOVWF      _setpoint+0
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main28:
	DECFSZ     R13+0, 1
	GOTO       L_main28
	DECFSZ     R12+0, 1
	GOTO       L_main28
	NOP
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	SUBLW      14
	BTFSC      STATUS+0, 0
	GOTO       L_main29
	MOVLW      14
	MOVWF      ?FLOC___mainT25+0
	GOTO       L_main30
L_main29:
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      ?FLOC___mainT25+0
L_main30:
	MOVF       ?FLOC___mainT25+0, 0
	MOVWF      _setpoint+0
	MOVLW      7
	MOVWF      CMCON+0
	MOVLW      1
	MOVWF      ADCON0+0
	MOVLW      5
	MOVWF      ADCON1+0
	BSF        TRISA+0, 0
	MOVLW      7
	MOVWF      TRISD+0
	CLRF       PORTD+0
	MOVLW      1
	MOVWF      T1CON+0
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	MOVLW      99
	MOVWF      TMR1H+0
	MOVLW      192
	MOVWF      TMR1L+0
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
	MOVLW      135
	MOVWF      OPTION_REG+0
	MOVLW      61
	MOVWF      TMR0+0
	MOVLW      224
	MOVWF      INTCON+0
	MOVLW      102
	MOVWF      T2CON+0
	MOVLW      240
	MOVWF      PR2+0
	BSF        TMR2IE_bit+0, BitPos(TMR2IE_bit+0)
	CLRF       TRISB+0
	CLRF       PORTB+0
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
	BCF        RD4_bit+0, BitPos(RD4_bit+0)
	BCF        RD5_bit+0, BitPos(RD5_bit+0)
	BSF        RD6_bit+0, BitPos(RD6_bit+0)
	BSF        RD7_bit+0, BitPos(RD7_bit+0)
L_main31:
	MOVF       _gap+0, 0
	MOVWF      _beforeGap+0
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _PH+0
	MOVF       R0+1, 0
	MOVWF      _PH+1
	MOVLW      14
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _PH+0
	MOVF       R0+1, 0
	MOVWF      _PH+1
	MOVF       R0+0, 0
	SUBWF      _setpoint+0, 0
	MOVWF      R2+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R2+1
	SUBWF      R2+1, 1
	MOVLW      0
	BTFSC      _setpoint+0, 7
	MOVLW      255
	ADDWF      R2+1, 1
	MOVLW      128
	XORWF      R2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main50
	MOVLW      0
	SUBWF      R2+0, 0
L__main50:
	BTFSC      STATUS+0, 0
	GOTO       L_main33
	CLRF       _gap+0
	GOTO       L_main34
L_main33:
	MOVF       _PH+0, 0
	SUBWF      _setpoint+0, 0
	MOVWF      _gap+0
L_main34:
	MOVF       _gap+0, 0
	XORWF      _beforeGap+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main35
	CLRF       _count+0
	CLRF       _count+1
L_main35:
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main36:
	DECFSZ     R13+0, 1
	GOTO       L_main36
	DECFSZ     R12+0, 1
	GOTO       L_main36
	NOP
	MOVF       _gap+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _timeDelayON+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVF       R1+1, 0
	SUBWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main51
	MOVF       R1+0, 0
	SUBWF      _count+0, 0
L__main51:
	BTFSC      STATUS+0, 0
	GOTO       L_main37
	BSF        RD4_bit+0, BitPos(RD4_bit+0)
	BSF        RD5_bit+0, BitPos(RD5_bit+0)
	GOTO       L_main38
L_main37:
	MOVF       _gap+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _timeDelayOFF+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	INCF       FSR, 1
	MOVF       INDF+0, 0
	MOVWF      R1+1
	MOVF       R1+1, 0
	SUBWF      _count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main52
	MOVF       R1+0, 0
	SUBWF      _count+0, 0
L__main52:
	BTFSC      STATUS+0, 0
	GOTO       L_main39
	BCF        RD4_bit+0, BitPos(RD4_bit+0)
	BCF        RD5_bit+0, BitPos(RD5_bit+0)
	GOTO       L_main40
L_main39:
	CLRF       _count+0
	CLRF       _count+1
L_main40:
L_main38:
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _PH+0, 0
	MOVWF      R0+0
	MOVF       _PH+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+2
	MOVF       R0+1, 0
	MOVWF      FLOC__main+3
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _PH+0, 0
	MOVWF      R0+0
	MOVF       _PH+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       FLOC__main+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	SUBWF      FLOC__main+2, 0
	MOVWF      _Msd+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FLOC__main+3, 0
	MOVWF      _Msd+1
	MOVF       FLOC__main+0, 0
	MOVWF      _Lsd+0
	MOVF       FLOC__main+1, 0
	MOVWF      _Lsd+1
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
	GOTO       L_main31
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
