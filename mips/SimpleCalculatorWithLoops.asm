# Program SimpleCalculatorWithLoops
# Austin Spencer
# Program that takes two integers from user and then either adds,
# subtract, multiply or divide the integers
# Then loop 


.text
	.globl main
main: 
	
	
	
	la $a0, operation	
	
	jal PromptInt					# Print prompt for what to do with the integers
	
	move $t2, $v0					# move the result into terminal 2
	
	li $v0, 5					# load immediate 5 into v0
		
	seq $t3, $t2, $v0				# set $t3 equal to 1 if the operation result is equal to 5
			
	beqz $t3, numSet				# if $t3 = 0 then branch to numSet, if not then run code below
	
		b end_if
	
	numSet:
	
		#num1
		la $a0, num1
		jal PromptInt				# Print prompt for integer 1
	
		move $t0, $v0				# Move integer entered into terminal 0
	
		#num2
		jal PrintNewLine			# Print new line
	
		la $a0, num2
	
		jal PromptInt				# Print prompt for integer 2
	
		move $t1, $v0				# Move integer 2 entered into terminal 1
		#get operation
		jal PrintNewLine			# Print new line
	
		#Begin if statements to see which operation chosen(1=Addition, 2=Subtraction, 3=Multiplication, 4=Divison, 5=Exit)
	
	
		li $v0, 1				# load immediate 1 into v0
		seq $t3, $t2, $v0			# set $t3 equal to 1 if the operation result is equal to 1
		beqz $t3, subraction 			# if $t3 = 0 then branch to subtraction, if not then run code below
		
	
		# Addition Operation
	
		addu $s0, $t1, $t0			# add the integers and put result in s0	
		
		b continue_if				# branch to continue_if
			
	
		subraction:
		
			li $v0, 2			# load immediate 2 into v0
		
			seq $t3, $t2, $v0		# set $t3 equal to 1 if the operation result is equal to 2
		
			beqz $t3, multiplication	# if $t3 = 0 then branch to multiplication, if not then run code below
		
			subu $s0, $t0, $t1		# subtract the first integer by the second integer and put result into s0
		
			b continue_if			# branch to continue_if
		
		multiplication:
		
			li $v0, 3			# load immediate 3 into v0
		
			seq $t3, $t2, $v0		# set $t3 equal to 1 if the operation result is equal to 3
		
			beqz $t3, division		# if $t3 = 0 then branch to division, if not then run code below
		
			mulu $s0, $t0, $t1		# multiply the integers then put result into s0
		
			b continue_if			# branch to continue_if
		
		division:
			li $v0, 4			# load immediate 3 into v0
		
			seq $t3, $t2, $v0		# set $t3 equal to 1 if the operation result is equal to 3
		
			beqz $t3, end_if		# if $t3 = 0 then branch to division, if not then run code below
			
		
			divu $s0, $t0, $t1		# Divide the first integer by the second integer and store result into s0
		
			rem $s1, $t0, $t1		# Divide the first integer by the second integer and store remainder into s1
			
			b continue_if			# branch to end_if
			
		remainder:
			
			li $v0, 4			# load immediate 3 into v0
		
			seq $t3, $t2, $v0		# set $t3 equal to 1 if the operation result is equal to 3
		
			beqz $t3, main		# if $t3 = 0 then branch to division, if not then run code below
		
			
		
			la $a0, remain			# load remain into address a0
		
			move $a1, $s1			# move the remainder into a1
		
			jal PrintInt			# print the remain prompt and resulting int
		
			jal PrintNewLine		# print new line
			
			jal PrintNewLine		# Print new line
		
			b main				# branch to end_if
		
	
	
	
		continue_if:
			jal PrintNewLine		# Print new line
			la $a0, result			# load result prompt into address 0
			move $a1, $s0			# move the result from s0 into address 1
			jal PrintInt			# Print the prompt along with the result
			jal PrintNewLine		# Print new line
			jal PrintNewLine		# Print new line
			b remainder
	
	
		end_if:
			jal PrintNewLine		# Print new line
			la $a0, finished		# load finished prompt into address 0
			move $a1, $s0			# move the result from s0 into address 1
			jal PrintString			# Print the prompt along with the result
			jal Exit			# exit cleanly

	
	
	
	
	
	
.data
num1: .asciiz "Please enter the first integer number: "	
num2: .asciiz "Please enter the second integer number: "
remain: .asciiz "Your remainder is: "

operation: .asciiz "Select the Operation (1=Addition, 2=Subtraction, 3=Multiplication, 4=Divison, 5=Exit): "
	

result: .asciiz "Your result is: "

finished: .asciiz "Bye Bye"

.include "utils.asm"


