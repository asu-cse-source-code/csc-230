# Program Multiples
# Austin Spencer
# Program that prints out the first 10 multiples of a given number
# and the sum of those multiples


# Output 1:
#	Please enter an integer value: -5
#	Invalid Input: -5
#	-- program is finished running --
#
# Output 2:
#	Please enter an integer value: 3
#	3 6 9 12 15 18 21 24 27 30 
#	Total: 165
#	-- program is finished running -
#
# Output 3:
#	Please enter an integer value: 10
#	10 20 30 40 50 60 70 80 90 100 
#	Total: 550
#	-- program is finished running --
#
.text
	.globl main
main: 
	#num1
	la $a0, num1
	jal PromptInt				# Print prompt for integer 1
	
	move $t0, $v0				# Move integer entered into terminal 0
	
	li $s3, 1				# load first counter as 1				
	
	li $t5, 1				# Load second counter as 1
	
	
	
	sgt $t3, $t2, $t0			# set $t3 equal to 1 if the operation result is equal to 1
	
	beqz $t3, loop				# if $t3 = 0 then branch to loop, if not branch to invalidLoop
	
		b invalidLoop
	
	loop:
		li $s2, 11			# Load the stopper at 11
		slt $t3, $s3, $s2		# Set t3 equal to 1 if s3 < s2
		beqz $t3, total			# Branch to total if t3 is 0 else continue code below


			mulu $t1, $t0, $s3	# multiply the number times the counter
			li $v0, 1	
  			move $a0, $t1		# Move result of multiplication into a0 to print the value
  			syscall			# Syscall to print the value
  		
  			add $s3, $s3, 1		# Add 1 to our counter
  			la $a0, blank		# Load blank prompt into a0
  			li $v0, 4	
  			syscall			# Print the blank prompt
  			b loop			# branch to beginning of loop
		
	
	
	
	
	total:
		
		add $t4, $t4, $t1		# add t4 to t1 and put result in t4
		li $s2, 10			# set stopper to 10 since first addition already happened
		slt $t3, $t5, $s2		# set t3 to 1 if t5 < s2
		beqz $t3, end_if		# if t3 is 0 branch to end_if
			mulu $t1, $t0, $t5	# multiply number by counter and put result in t1
			add $t5, $t5, 1		# increment the counter by 1
			b total			# branch back to the total loop
		
		
		
	
	invalidLoop: 
			
		la $a0, invalid			# Load invalid prompt into a0
		move $a1, $t0			# Load the number entered into a1
		jal PrintInt			# Print prompt along with the number
		jal Exit			# Exit cleanly
	
	
	
	
	end_if:
		jal PrintNewLine		# Print new line for aesthetics
		la $a0, sum			# load the sum prompt into a0
		move $a1, $t4			# move the total integer result into a1
		jal PrintInt			# Print the prompt along with the result
		
		jal Exit			# exit cleanly
	
	
	

	
	
	
	
	
	
.data
num1: .asciiz "Please enter an integer value: "	
sum: .asciiz "Total: "
invalid: .asciiz "Invalid Input: "
blank: .asciiz " "

.include "utils.asm"


