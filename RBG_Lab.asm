; RGB Part 1
; Tyler Fikes, Alvi Habib, Austin Spencer
; CSC230 11-20-19
    
#include "p16F1708.inc"

; CONFIG1
; __config 0x3FE4
 __CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_ON & _FCMEN_ON
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _WRT_OFF & _PPS1WAY_ON & _ZCDDIS_ON & _PLLEN_ON & _STVREN_ON & _BORV_LO & _LPBOR_OFF & _LVP_ON

	 
    udata   ; available only in specific banks
i   res 1   ; outer loop counter
j   res 1   ; inner loop counter
   
    org 0x00
   
    goto Start

Start	; code starts here
    banksel OSCCON	; Select bank
    movlw b'01011110'	; 1 Mhz clock
    movwf OSCCON	; Move value from working register into clock
    
    banksel PORTA	; Select the PORTA bank 
    clrf    PORTA	; Clear all our status bits
    
    banksel ANSELA	; ANSELA is a constant
    clrf    ANSELA	; Clear all 8 bits in ANSELA = Digital
    
    banksel TRISA	; Select the TRISA bank
    clrf    TRISA	; Clear all 8 bits in TRISA = Output
    
    banksel LATA	; Select the Latch A bank
    clrf    LATA	; Clear all 8 bits on the latch
    
    movlb 0	; Put a zero in Working register so we can clear our counters
    clrf i	; Clear outer loop counter
    clrf j	; Clear inner loop counter
  
    goto LOOP   ; Call the main loop
    
DELAY ; Delay 1 second
    decfsz j, F	    ; Decrement and skip next instruction on 0
    goto DELAY	    ; Delay loop
    decfsz i, F    ; Decrememnt and skip next instruction on 0
    goto DELAY	    ; Delay loop
    return   
    
LOOP
    ; -----------------------------------
    ; Main loop to blink sequence.
    ; RA0 = Red
    ; RA1 = Green
    ; RA2 = Blue
  
    banksel LATA
    bsf LATA, 0	    ; Turn RA0 on = Red LED
    call DELAY	    ; Delay
    banksel LATA
    bcf LATA, 0	    ; Turn RA0 off
    
    banksel LATA
    bsf LATA, 1	    ; Turn RA1 on = Green LED
    call DELAY	    ; Delay
    banksel LATA
    bcf LATA, 1	    ; Turn RA1 off
    
    banksel LATA
    bsf LATA, 2	    ; Turn RA2 on = Blue LED
    call DELAY	    ; Delay
    banksel LATA
    bcf LATA, 2	    ; Turn RA2 off
    
    banksel LATA
    bsf LATA, 0	    ; Turn RA0 on = Red LED
    bsf LATA, 1	    ; Turn RA1 on = Green LED
    call DELAY	    ; Delay
    banksel LATA
    bcf LATA, 0	    ; Turn RA0 off
    bcf LATA, 1	    ; Turn RA1 off
    
    banksel LATA
    bsf LATA, 0	    ; Turn RA0 on = Red LED
    bsf LATA, 2	    ; Turn RA2 on = Blue LED
    call DELAY	    ; Delay
    banksel LATA
    bcf LATA, 0	    ; Turn RA0 off
    bcf LATA, 2	    ; Turn RA2 off
    
    banksel LATA
    bsf LATA, 1	    ; Turn RA1 on = Green LED
    bsf LATA, 2	    ; Turn RA2 on = Blue LED
    call DELAY	    ; Delay
    banksel LATA
    bcf LATA, 1	    ; Turn RA1 off
    bcf LATA, 2	    ; Turn RA2 off
    
    banksel LATA
    bsf LATA, 0	    ; Turn RA0 on = Red LED
    bsf LATA, 1	    ; Turn RA1 on = Green LED
    bsf LATA, 2	    ; Turn RA2 on = Blue LED
    call DELAY	    ; Delay
    banksel LATA
    bcf LATA, 0	    ; Turn RA0 off
    bcf LATA, 1	    ; Turn RA1 off
    bcf LATA, 2	    ; Turn RA2 off

    
    goto LOOP ; keep looping indefinitely
    
    end