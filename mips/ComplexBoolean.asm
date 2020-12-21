.data
	prompt: .asciiz "Enter a number: "
	buzz: .asciiz "Yahoo!"
	
.text 
	.globl main

main: 
	# Ask the user for a number
	
	# Get the number
	# If the number is <10 and > 0 or it is even
	# print "Yahoo"
	
	# if ((x >0 && x<10) || x%2 == 0)
	# print ("Yahoo")
	
	la $a0, prompt			# Set up our prompt
	jal PromptInt
	move $t0, $v0			# so, $t0 is our number
	
	sgt $t1, $t0, $zero		# Set $t1 if number > 0
	li $s0, 10			# Load up our literal
	slt $t2, $t0, $s0		# Set $t2 if number < 10
	rem $t3, $t0, 2			# Get the remainder of our number / 2
	seq $t3, $t2, $zero		# Set $t3 if the remainder is 0
	and $t1, $t1, $t2		# $t1 = ($t1 and $t2)	
	or $t1, $t1, $t3		# 
	beqz $t1, EndIf
		# PRINT Yahoo
		la $a0, buzz
		jal PrintString

EndIf:
	jal Exit	
	.include "utils.asm"
