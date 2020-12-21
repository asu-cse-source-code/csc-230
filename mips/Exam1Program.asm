# Part2 Programming
# Austin Spencer
# CSC 230
# This program takes a number of pennies entered by user and converts to find least number of pennies
# needed if you add nickels instead

.data

pennies: .asciiz "Enter the number of pennies: "	# Create prompt to ask how many pennies
result: .asciiz "I've converted your "			# Create prompt for printing the amount of pennies
result2: .asciiz " pennies into: Nickels: "		# Create prompt for printing the nickels to eliminate pennies
result3: .asciiz " Pennies: "				# Create prompt for final amount of pennies
nick: .word 5						# Create word used to find number of nickels
.text

main: 
	la $a0, pennies					# Load prompt into a0
	jal PromptInt					# Print prompt on screen
	move $t0, $v0					# move pennies entered into terminal 0
		
	lw $t5, nick					# load word into terminal 5
	divu $t1, $t0, $t5				# div pennies by 5
	remu $t2, $t0, $t5				# find remainder when dividing pennies by 5
	
	la $a0, result					# Load first result prompt
	move $a1, $t0					# move number of pennies entered into argument 1
	jal PrintInt					# print first prompt with number of pennies
		
	la $a0, result2					# Load second result prompt
	move $a1, $t1					# move number of nickels into argument 1
	jal PrintInt 					# print second prompt with number of nickels
	
	la $a0, result3					# Load final result prompt
	move $a1, $t2					# move number of final pennies needed into argument 1
	jal PrintInt 					# print third prompt with number of pennies needed at the end
	
	jal Exit					# Exit cleanly
	
	
	
	
	
	
.data
.include "utils.asm"					
	