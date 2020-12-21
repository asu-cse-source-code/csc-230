# Program SimpleCalculator
# Austin Spencer
# Program that takes two integers from user and then either adds,
# subtract, multiply or divide the integers


.text
	.globl main
main: 
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
	
	la $a0, operation	
	
	jal PromptInt				# Print prompt for what to do with the integers
	
	move $t2, $v0				# move the result into terminal 2
	
	#Begin if statements to see which operation chosen(1=Addition, 2=Subtraction, 3=Multiplication, 4=Divison)
	
	li $v0, 1				# load immediate 1 into v0
	
	seq $t3, $t2, $v0			# set $t3 equal to 1 if the operation result is equal to 1
	
	beqz $t3, subraction 			# if $t3 = 0 then branch to subtraction, if not then run code below
	
	
	addu $s0, $t1, $t0			# add the integers and put result in s0
	
	b end_if				# branch to end_if
	
	subraction:
		
		li $v0, 2			# load immediate 2 into v0
		
		seq $t3, $t2, $v0		# set $t3 equal to 1 if the operation result is equal to 2
		
		beqz $t3, multiplication	# if $t3 = 0 then branch to multiplication, if not then run code below
		
		subu $s0, $t0, $t1		# subtract the first integer by the second integer and put result into s0
		
		b end_if			# branch to end_if
	multiplication:
		
		li $v0, 3			# load immediate 3 into v0
		
		seq $t3, $t2, $v0		# set $t3 equal to 1 if the operation result is equal to 3
		
		beqz $t3, division		# if $t3 = 0 then branch to division, if not then run code below
		
		mulu $s0, $t0, $t1		# multiply the integers then put result into s0
		
		b end_if			# branch to end_if
	division:
		# no test needed since this is last option, if the program made it here then divide is only option left
		
		divu $s0, $t0, $t1		# Divide the first integer by the second integer and store result into s0
		
		rem $s1, $t0, $t1		# Divide the first integer by the second integer and store remainder into s1
		
		jal PrintNewLine		# Print new line
		
		la $a0, remain			# load remain into address a0
		
		move $a1, $s1			# move the remainder into a1
		
		jal PrintInt			# print the remain prompt and resulting int
		
		jal PrintNewLine		# print new line
		
		b end_if			# branch to end_if
	
	end_if:
		jal PrintNewLine		# Print new line
		la $a0, result			# load result prompt into address 0
		move $a1, $s0			# move the result from s0 into address 1
		jal PrintInt			# Print the prompt along with the result
		jal Exit			# exit cleanly
	
	
	

	
	
	
	
	
	
.data
num1: .asciiz "Please enter the first integer number: "	
num2: .asciiz "Please enter the second integer number: "
remain: .asciiz "Your remainder is: "

operation: .asciiz "Select the Operation (1=Addition, 2=Subtraction, 3=Multiplication, 4=Divison): "
	

result: .asciiz "Your result is: "

.include "utils.asm"


