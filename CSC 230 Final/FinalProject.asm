; Final Project
; Tyler Fikes, Alvi Habib, Austin Spencer
; Door Lock
; CSC230 11-20-19
    
#include "p16F1708.inc"

; CONFIG1
; __config 0x3FE4
 __CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_ON & _FCMEN_ON
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _WRT_OFF & _PPS1WAY_ON & _ZCDDIS_ON & _PLLEN_ON & _STVREN_ON & _BORV_LO & _LPBOR_OFF & _LVP_ON

	 
    udata   ; available only in specific banks
    org 0x00
cblock	0x70
    i
    j
    Ton
    Toff
    COUNT
    W_TEMP		; Temporary W Storage
endc
    goto Begin
;**************INTERRUPT ROUTINE***************
    org 0x04 		;This is where PC points on an interrupt
    
    banksel LATA
    bcf LATA, 1
    banksel INTCON
    bcf INTCON, 1 	;We need to clear this flag to enable
    goto LOOP3
    
    
    

Begin	; code starts here
    banksel OSCCON	; Select bank
    movlw b'01011110'	; 1 Mhz clock
    movwf OSCCON	; Move value from working register into clock
    
    banksel PORTA	; Select the PORTA bank 
    clrf    PORTA	; Clear all our status bits
    
    banksel ANSELA	; ANSELA is a constant
    clrf    ANSELA	; Clear all 8 bits in ANSELA = Digital
    
    banksel TRISA	; Select the TRISA bank
    clrf    TRISA	; Clear all 8 bits in TRISA = Output
    bsf	    TRISA,2	; SET INTERRUPT TO RA2
    
    banksel LATA	; Select the Latch A bank
    clrf    LATA	; Clear all 8 bits on the latch
    
    banksel PORTC	; Select the PORTC bank
    clrf    PORTC	; Clear all our status bits
    
    banksel ANSELC  
    clrf    ANSELC
    
    banksel TRISC	; Select the TRISC bank
    clrf    TRISC	; Clear all 8 bits in TRISC
    
    bsf	    TRISC,1
    bsf	    TRISC,2
    bsf	    TRISC,3
    bsf	    TRISC,4
    bsf	    TRISC,5
    
    bsf INTCON,7 	;GIE ? Global interrupt enable (1=enable)
    bsf INTCON,4 	;INTE - RB0 Interrupt Enable (1=enable)
    bcf INTCON,1 	;INTF - Clear FLag Bit Just In Case
    
    
    
    ;movlw b'0011110'	; Move 0011110 into working register
    ;movwf   TRISC	; Move working register into TRISC 
    
    
    
    
    movlb 0	; Put a zero in Working register so we can clear our counters
    clrf i	; Clear outer loop counter
    clrf j	; Clear inner loop counter
  
    goto START  ; Call the main loop
    
DELAY2 ; Delay 1 second
    decfsz j, F	    ; Decrement and skip next instruction on 0
    goto DELAY2	    ; Delay loop
    decfsz i, F    ; Decrememnt and skip next instruction on 0
    goto DELAY2	    ; Delay loop
    return   

START
    ; -----------------------------------
    ; Main loop to begin lock sequence
    ; RA0 = Red
    ; RA1 = Green
    
    ;bcf INTCON, 0x01	
    
    banksel LATA
    bsf LATA, 0		    ; Turn RA0 on = Red LED
    bcf LATA, 1
    ;banksel PORTC	; Select the PORTC bank
    ;clrf    PORTC	; Clear all our status bits
    
    banksel PORTC	    ; Select bank PORTC
    
    btfsc PORTC, 1	    ; Check if RC1 button is set, skip if not
    goto CORRECT_FIRST	    ; Go to Correct First if RC1 is set
    
    btfsc PORTC, 2	    ; Check if RC2 button is set, skip if not
    goto INCORRECT_FIRST    ; Go to Correct
    
    btfsc PORTC, 3
    goto INCORRECT_FIRST2
    
    btfsc PORTC, 4
    goto INCORRECT_FIRST3
    
    goto START ; keep looping indefinitely


CORRECT_FIRST
    btfss PORTC, 1	    ; Check if RC1 button is set, skip if not
    goto CORRECT_FIRST2	    ; Go to Correct First if RC1 is set
    goto CORRECT_FIRST
    
INCORRECT_FIRST
    btfss PORTC, 2	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_FIRST4  ; Go to Correct First if RC1 is set
    goto INCORRECT_FIRST
    
INCORRECT_FIRST2
    btfss PORTC, 3	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_FIRST4  ; Go to Correct First if RC1 is set
    goto INCORRECT_FIRST2
    
INCORRECT_FIRST3
    btfss PORTC, 4	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_FIRST4  ; Go to Correct First if RC1 is set
    goto INCORRECT_FIRST3




    
CORRECT_FIRST2
    banksel PORTC
    ;clrf    PORTC	; Clear all our status bits
    ;bcf LATA, 0
    
    btfsc PORTC, 1
    goto INCORRECT_SECOND
    
    btfsc PORTC, 2
    goto CORRECT_SECOND
    
    btfsc PORTC, 3
    goto INCORRECT_SECOND2
    
    btfsc PORTC, 4
    goto INCORRECT_SECOND3
    
    goto CORRECT_FIRST2





    
CORRECT_SECOND
    btfss PORTC, 2	    ; Check if RC1 button is set, skip if not
    goto CORRECT_SECOND2	    ; Go to Correct First if RC1 is set
    goto CORRECT_SECOND

INCORRECT_SECOND
    btfss PORTC, 1	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_SECOND4  ; Go to Correct First if RC1 is set
    goto INCORRECT_SECOND   

INCORRECT_SECOND2
    btfss PORTC, 3	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_SECOND4  ; Go to Correct First if RC1 is set
    goto INCORRECT_SECOND2
    
INCORRECT_SECOND3
    btfss PORTC, 4	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_SECOND4  ; Go to Correct First if RC1 is set
    goto INCORRECT_SECOND3






    
CORRECT_SECOND2
    banksel PORTC
    ;clrf    PORTC	; Clear all our status bits
    ;bsf LATA, 1
    btfsc PORTC, 1
    goto INCORRECT_THIRD
    
    btfsc PORTC, 2
    goto INCORRECT_THIRD2
    
    btfsc PORTC, 3
    goto CORRECT_THIRD
    
    btfsc PORTC, 4
    goto INCORRECT_THIRD3
    
    goto CORRECT_SECOND2



    
CORRECT_THIRD
    btfss PORTC, 3	    ; Check if RC1 button is set, skip if not
    goto CORRECT_THIRD2	    ; Go to Correct First if RC1 is set
    goto CORRECT_THIRD

INCORRECT_THIRD
    btfss PORTC, 1	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_THIRD4  ; Go to Correct First if RC1 is set
    goto INCORRECT_THIRD   

INCORRECT_THIRD2
    btfss PORTC, 2	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_THIRD4  ; Go to Correct First if RC1 is set
    goto INCORRECT_THIRD2   
    
INCORRECT_THIRD3
    btfss PORTC, 4	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_THIRD4  ; Go to Correct First if RC1 is set
    goto INCORRECT_THIRD3  






CORRECT_THIRD2
    banksel PORTC
    clrf    PORTC	; Clear all our status bits
    ;bsf LATA, 0
    ;bsf LATA, 1
    btfsc PORTC, 1
    goto WRONG_ENTRY
    
    btfsc PORTC, 2
    goto WRONG_ENTRY
    
    btfsc PORTC, 3
    goto WRONG_ENTRY
    
    btfsc PORTC, 4
    goto CORRECT_UNLOCK
    
    goto CORRECT_THIRD2

    
INCORRECT_FIRST4
    banksel PORTC
    ;clrf    PORTC	; Clear all our status bits
    
    btfsc PORTC, 1
    goto INCORRECT2_1
    
    btfsc PORTC, 2
    goto INCORRECT2_2
    
    btfsc PORTC, 3
    goto INCORRECT2_3
    
    btfsc PORTC, 4
    goto INCORRECT2_4
    
    goto INCORRECT_FIRST4
    



INCORRECT2_1
    btfss PORTC, 1	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_SECOND4	    ; Go to Correct First if RC1 is set
    goto INCORRECT2_1

INCORRECT2_2
    btfss PORTC, 2	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_SECOND4	    ; Go to Correct First if RC1 is set
    goto INCORRECT2_2

INCORRECT2_3
    btfss PORTC, 3	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_SECOND4	    ; Go to Correct First if RC1 is set
    goto INCORRECT2_3

INCORRECT2_4
    btfss PORTC, 4	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_SECOND4	    ; Go to Correct First if RC1 is set
    goto INCORRECT2_4





   

    

INCORRECT_SECOND4
    banksel PORTC
    ;clrf    PORTC	; Clear all our status bits
    
    btfsc PORTC, 1
    goto INCORRECT3_1
    
    btfsc PORTC, 2
    goto INCORRECT3_2
    
    btfsc PORTC, 3
    goto INCORRECT3_3
    
    btfsc PORTC, 4
    goto INCORRECT3_4
    
    goto INCORRECT_SECOND4





INCORRECT3_1
    btfss PORTC, 1	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_THIRD4	    ; Go to Correct First if RC1 is set
    goto INCORRECT3_1

INCORRECT3_2
    btfss PORTC, 2	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_THIRD4	    ; Go to Correct First if RC1 is set
    goto INCORRECT3_2

INCORRECT3_3
    btfss PORTC, 3	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_THIRD4	    ; Go to Correct First if RC1 is set
    goto INCORRECT3_3

INCORRECT3_4
    btfss PORTC, 4	    ; Check if RC1 button is set, skip if not
    goto INCORRECT_THIRD4	    ; Go to Correct First if RC1 is set
    goto INCORRECT3_4


    






INCORRECT_THIRD4
    banksel PORTC
    ;clrf    PORTC	; Clear all our status bits
    
    btfsc PORTC, 1
    goto WRONG_ENTRY
    
    btfsc PORTC, 2
    goto WRONG_ENTRY
    
    btfsc PORTC, 3
    goto WRONG_ENTRY
    
    btfsc PORTC, 4
    goto WRONG_ENTRY
    
    goto INCORRECT_THIRD4
    

    
    
    
WRONG_ENTRY
    banksel LATA
    bcf LATA, 0	    ; Turn RA0 off = Red LED
    call DELAY2	    ; CALL DELAY
    bsf LATA, 0	    ; Turn RA0 on = Red LED
    call DELAY2	    ; CALL DELAY
    
    banksel LATA
    bcf LATA, 0	    ; Turn RA0 off = Red LED
    call DELAY2	    ; CALL DELAY
    bsf LATA, 0	    ; Turn RA0 on = Red LED
    call DELAY2	    ; CALL DELAY
    
    banksel LATA
    bcf LATA, 0	    ; Turn RA0 off = Red LED
    call DELAY2	    ; CALL DELAY
    bsf LATA, 0	    ; Turn RA0 on = Red LED
    call DELAY2	    ; CALL DELAY
    bcf LATA, 0	    ; Turn RA0 off = Red LED
    
    goto START



    
CORRECT_UNLOCK
    movlw   .162	; move 162 into working register
    movwf   Ton		; set ON_Count to 163
    
    movlw   1		; move 1 into working register
    movwf   Toff	; set OFF_Count to 1
    bcf LATA, 1
    goto LOOP
    
    ;call DELAY2
    ;btfsc PORTC, 5  ; Check if relock button pressed
    ;goto START
    ;incf COUNT
    ;movlw 0x20
    ;subwf COUNT,0
    ;btfss STATUS,0
    goto TEST
    
    
TEST
    
    ;incf COUNT
    ;movlw 0x20
    ;subwf COUNT,0
    bsf LATA, 1
    banksel PORTA
    btfsc PORTA, 2  ; Check if relock button pressed
    goto LOOP3
    ;btfss STATUS,0
    goto TEST
    ;goto START
    
    
    
    
    
    goto TEST
    



LOOP			; Turns bright red light to dim with PWM
   
    movf  Ton,0		; move Ton to working register
    movwf  i	        ; move value in working register (Ton) to i
    banksel LATA
    bsf	    LATA, 0	; Set RA0 High (LED)
    call DELAY
    
    movf  Toff,0	; move Toff to working register
    movwf  i	        ; move value in working register (Toff) to i
    banksel LATA
    bcf	    LATA, 0	; Clear RA0 (LED)
    call DELAY
    
    movf  Ton,0		; move Ton to working register
    movwf  i	        ; move value in working register (Ton) to i
    banksel LATA
    bsf	    LATA, 0	; Set RA0 High (LED)
    call DELAY
    
    movf  Toff,0	; move Toff to working register
    movwf  i	        ; move value in working register (Toff) to i
    banksel LATA
    bcf	    LATA, 0	; Clear RA0 (LED)
    call DELAY
    
    movf  Ton,0		; move Ton to working register
    movwf  i	        ; move value in working register (Ton) to i
    banksel LATA
    bsf	    LATA, 0	; Set RA0 High (LED)
    call DELAY
    
    movf  Toff,0	; move Toff to working register
    movwf  i	        ; move value in working register (Toff) to i
    banksel LATA
    bcf	    LATA, 0	; Clear RA0 (LED)
    call DELAY
    
    movf  Ton,0		; move Ton to working register
    movwf  i	        ; move value in working register (Ton) to i
    banksel LATA
    bsf	    LATA, 0	; Set RA0 High (LED)
    call DELAY
    
    movf  Toff,0	; move Toff to working register
    movwf  i	        ; move value in working register (Toff) to i
    banksel LATA
    bcf	    LATA, 0	; Clear RA0 (LED)
    call DELAY
    
    incf	Toff,1	; Increment Toff
    decfsz 	Ton, 1 	; Decrement Ton and skip next instruction on 0
    goto LOOP
    
    movlw   .162	; move 162 into working register
    movwf   Toff	; set ON_Count to 162
    movlw   1		; move 1 into working register
    movwf   Ton		; set OFF_Count to 1
    goto LOOP2
; Turn On LED
; i = On_Count
; call DELAY
; i = Off_Count
; call DELAY    
; increment Off_Count
; decrement On_Count
; goto LOOP
    
; off state
LOOP2			; Goes from dim lit green to bright green with PWM
   movf  Ton,0		; move Ton to working register
    movwf  i	        ; move value in working register (Ton) to i
    banksel LATA
    bsf	    LATA, 1	; Set RA0 High (LED)
    call DELAY
    
    movf  Toff,0	; move Toff to working register
    movwf  i	        ; move value in working register (Toff) to i
    banksel LATA
    bcf	    LATA, 1	; Clear RA0 (LED)
    call DELAY
    
    movf  Ton,0		; move Ton to working register
    movwf  i	        ; move value in working register (Ton) to i
    banksel LATA
    bsf	    LATA, 1	; Set RA0 High (LED)
    call DELAY
    
    movf  Toff,0	; move Toff to working register
    movwf  i	        ; move value in working register (Toff) to i
    banksel LATA
    bcf	    LATA, 1	; Clear RA0(LED)
    call DELAY
    
    movf  Ton,0		; move Ton to working register
    movwf  i	        ; move value in working register (Ton) to i
    banksel LATA
    bsf	    LATA, 1	; Set RA0 High (LED)
    call DELAY
    
    movf  Toff,0	; move Toff to working register
    movwf  i	        ; move value in working register (Toff) to i
    banksel LATA
    bcf	    LATA, 1	; Clear RA0 (LED)
    call DELAY
    
    movf  Ton,0		; move Ton to working register
    movwf  i	        ; move value in working register (Ton) to i
    banksel LATA
    bsf	    LATA, 1	; Set RA0 High (LED)
    call DELAY
    
    movf  Toff,0	; move Toff to working register
    movwf  i	        ; move value in working register (Toff) to i
    banksel LATA
    bcf	    LATA, 1	; Clear RA0 (LED)
    call DELAY 
    
    incf	Ton,1	; Increment Ton
    decfsz 	Toff, 1 ; Decrement Toff and skip next instruction on 0
    goto LOOP2

    movlw   .162	; move 162 into working register
    movwf   Ton		; set ON_Count to 162
    movlw   1		; move 1 into working register
    movwf   Toff	; set OFF_Count to 1
    goto TEST   
    
LOOP3			; Turns bright red light to dim with PWM
    banksel LATA
    bcf	    LATA,1
    movf  Ton,0		; move Ton to working register
    movwf  i	        ; move value in working register (Ton) to i
    banksel LATA
    bsf	    LATA, 0	; Set RA0 High (LED)
    call DELAY
    
    movf  Toff,0	; move Toff to working register
    movwf  i	        ; move value in working register (Toff) to i
    banksel LATA
    bcf	    LATA, 0	; Clear RA0 (LED)
    call DELAY
    
    movf  Ton,0		; move Ton to working register
    movwf  i	        ; move value in working register (Ton) to i
    banksel LATA
    bsf	    LATA, 0	; Set RA0 High (LED)
    call DELAY
    
    movf  Toff,0	; move Toff to working register
    movwf  i	        ; move value in working register (Toff) to i
    banksel LATA
    bcf	    LATA, 0	; Clear RA0 (LED)
    call DELAY
    
    movf  Ton,0		; move Ton to working register
    movwf  i	        ; move value in working register (Ton) to i
    banksel LATA
    bsf	    LATA, 0	; Set RA0 High (LED)
    call DELAY
    
    movf  Toff,0	; move Toff to working register
    movwf  i	        ; move value in working register (Toff) to i
    banksel LATA
    bcf	    LATA, 0	; Clear RA0 (LED)
    call DELAY
    
    movf  Ton,0		; move Ton to working register
    movwf  i	        ; move value in working register (Ton) to i
    banksel LATA
    bsf	    LATA, 0	; Set RA0 High (LED)
    call DELAY
    
    movf  Toff,0	; move Toff to working register
    movwf  i	        ; move value in working register (Toff) to i
    banksel LATA
    bcf	    LATA, 0	; Clear RA0 (LED)
    call DELAY
    
    incf	Toff,1	; Increment Toff
    decfsz 	Ton, 1 	; Decrement Ton and skip next instruction on 0
    goto LOOP3
    
    movlw   .162	; move 162 into working register
    movwf   Toff	; set ON_Count to 162
    movlw   1		; move 1 into working register
    movwf   Ton		; set OFF_Count to 1
    goto    START
; Turn On LED
; i = On_Count
; call DELAY
; i = Off_Count
; call DELAY    
; increment Off_Count
; decrement On_Count
; goto LOOP
    
; off state

DELAY
    decfsz 	i, 1 	; Decrement and skip next instruction on 0
    goto 	DELAY 	; Delay loop
    return
     
OFF   
    banksel LATA
    bcf	    LATA, 0	; Clear RA0 (LED)
    goto OFF
    
    end		; 


