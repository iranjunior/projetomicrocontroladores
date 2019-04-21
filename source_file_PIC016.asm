
_main:

	MOVLW      197
	MOVWF      ADCON0+0
	CLRF       CMCON+0
	CLRF       TRISC+0
	CLRF       TRISB+0
	CLRF       PORTB+0
	BCF        PORTC+0, 7
	BCF        PORTC+0, 6
	CALL       _ADC_Init+0
L_main0:
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _leitura+0
	MOVF       R0+1, 0
	MOVWF      _leitura+1
	MOVLW      14
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      4
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      _ph+0
	MOVF       R0+1, 0
	MOVWF      _ph+1
	MOVF       R0+2, 0
	MOVWF      _ph+2
	MOVF       R0+3, 0
	MOVWF      _ph+3
	CLRF       R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      76
	MOVWF      R4+2
	MOVLW      126
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main4
L__main61:
	CLRF       _Cnt+0
	CLRF       _Cnt+1
L_main4:
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      76
	MOVWF      R4+2
	MOVLW      126
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main7
	MOVLW      102
	MOVWF      R4+0
	MOVLW      102
	MOVWF      R4+1
	MOVLW      102
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main7
L__main60:
	MOVLW      1
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main7:
	MOVLW      102
	MOVWF      R4+0
	MOVLW      102
	MOVWF      R4+1
	MOVLW      102
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
	MOVLW      51
	MOVWF      R4+0
	MOVLW      51
	MOVWF      R4+1
	MOVLW      51
	MOVWF      R4+2
	MOVLW      128
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main10
L__main59:
	MOVLW      2
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main10:
	MOVLW      51
	MOVWF      R4+0
	MOVLW      51
	MOVWF      R4+1
	MOVLW      51
	MOVWF      R4+2
	MOVLW      128
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main13
	MOVLW      51
	MOVWF      R4+0
	MOVLW      51
	MOVWF      R4+1
	MOVLW      115
	MOVWF      R4+2
	MOVLW      128
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main13
L__main58:
	MOVLW      3
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main13:
	MOVLW      51
	MOVWF      R4+0
	MOVLW      51
	MOVWF      R4+1
	MOVLW      115
	MOVWF      R4+2
	MOVLW      128
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main16
	MOVLW      154
	MOVWF      R4+0
	MOVLW      153
	MOVWF      R4+1
	MOVLW      25
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main16
L__main57:
	MOVLW      4
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main16:
	MOVLW      154
	MOVWF      R4+0
	MOVLW      153
	MOVWF      R4+1
	MOVLW      25
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	MOVLW      154
	MOVWF      R4+0
	MOVLW      153
	MOVWF      R4+1
	MOVLW      57
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main19
L__main56:
	MOVLW      5
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main19:
	MOVLW      154
	MOVWF      R4+0
	MOVLW      153
	MOVWF      R4+1
	MOVLW      57
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main22
	MOVLW      154
	MOVWF      R4+0
	MOVLW      153
	MOVWF      R4+1
	MOVLW      89
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main22
L__main55:
	MOVLW      6
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main22:
	MOVLW      154
	MOVWF      R4+0
	MOVLW      153
	MOVWF      R4+1
	MOVLW      89
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main25
	MOVLW      154
	MOVWF      R4+0
	MOVLW      153
	MOVWF      R4+1
	MOVLW      121
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main25
L__main54:
	MOVLW      7
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main25:
	MOVLW      154
	MOVWF      R4+0
	MOVLW      153
	MOVWF      R4+1
	MOVLW      121
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main28
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      12
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main28
L__main53:
	MOVLW      8
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main28:
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      12
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main31
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main31
L__main52:
	MOVLW      9
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main31:
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main34
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      44
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main34
L__main51:
	MOVLW      10
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main34:
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      44
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main37
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      60
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main37
L__main50:
	MOVLW      11
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main37:
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      60
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main40
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      76
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main40
L__main49:
	MOVLW      12
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main40:
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      76
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main43
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      92
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main43
L__main48:
	MOVLW      13
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main43:
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      92
	MOVWF      R4+2
	MOVLW      130
	MOVWF      R4+3
	MOVF       _ph+0, 0
	MOVWF      R0+0
	MOVF       _ph+1, 0
	MOVWF      R0+1
	MOVF       _ph+2, 0
	MOVWF      R0+2
	MOVF       _ph+3, 0
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      1
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main44
	MOVLW      14
	MOVWF      _Cnt+0
	MOVLW      0
	MOVWF      _Cnt+1
L_main44:
	MOVF       _leitura+0, 0
	MOVWF      _Cnt+0
	MOVF       _leitura+1, 0
	MOVWF      _Cnt+1
	MOVLW      2
	MOVWF      R12+0
	MOVLW      41
	MOVWF      R13+0
L_main45:
	DECFSZ     R13+0, 1
	GOTO       L_main45
	DECFSZ     R12+0, 1
	GOTO       L_main45
	NOP
	NOP
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Cnt+0, 0
	MOVWF      R0+0
	MOVF       _Cnt+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FLOC__main+2
	MOVF       R0+1, 0
	MOVWF      FLOC__main+3
	MOVF       FLOC__main+2, 0
	MOVWF      _Msd+0
	MOVF       FLOC__main+3, 0
	MOVWF      _Msd+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+2, 0
	MOVWF      R0+0
	MOVF       FLOC__main+3, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__main+2, 0
	MOVWF      R0+0
	MOVF       FLOC__main+3, 0
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
	SUBWF      FLOC__main+0, 0
	MOVWF      R0+0
	MOVF       R0+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FLOC__main+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _Msd+0
	MOVF       R0+1, 0
	MOVWF      _Msd+1
	MOVF       R0+0, 0
	MOVWF      FARG_Display_no+0
	MOVF       R0+1, 0
	MOVWF      FARG_Display_no+1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	BSF        PORTC+0, 7
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_main46:
	DECFSZ     R13+0, 1
	GOTO       L_main46
	DECFSZ     R12+0, 1
	GOTO       L_main46
	NOP
	BCF        PORTC+0, 7
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _Cnt+0, 0
	MOVWF      R0+0
	MOVF       _Cnt+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _Lsd+0
	MOVF       R0+1, 0
	MOVWF      _Lsd+1
	MOVF       R0+0, 0
	MOVWF      FARG_Display_no+0
	MOVF       R0+1, 0
	MOVWF      FARG_Display_no+1
	CALL       _Display+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
	BSF        PORTC+0, 6
	MOVLW      33
	MOVWF      R12+0
	MOVLW      118
	MOVWF      R13+0
L_main47:
	DECFSZ     R13+0, 1
	GOTO       L_main47
	DECFSZ     R12+0, 1
	GOTO       L_main47
	NOP
	BCF        PORTC+0, 6
	GOTO       L_main0
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
