#{
#int r = prompt("Enter the radius of a circle: ");
#int y = prompt("Enter a value for y: ");
#int z = (2(x + y) – 4y)/10;
#int r = (2(x + y) – 4y)%10;
#print(“The quotient is: “ + z);
#print(“The remainder is: “ + r);
#}
# Author: Austin Spencer
# Date: 09/16/19
# Program that takes two inputs and then goes through a series of math equations to find quotient and it's remainder
.text
.globl main

main:
	# Get input value
	addi $v0, $zero, 4 		# Write Prompt
	la $a0, prompt
	syscall
	addi $v0, $zero, 5 		# Retrieve input
	syscall
	move $s0, $v0
	
	addi $v0, $zero, 4 		# Write Prompt
	la $a0, prompt2
	syscall
	addi $v0, $zero, 5 		# Retrieve input
	syscall
	move $s1, $v0
	
	# Check if odd or even
	addi $t0, $zero, 2 		# Store 2 in $t0
	addu $t1, $s0, $s1		# add x + y
	mult $t1, $t0 			# multiply sum of x+y by 2
	mfhi $s2 			# Save remainder in $s2
	addi $t2, $zero, 4		# Store 4 in $t2
	mult $t2, $s1			# Multiply 4 * y
	mfhi $s3
	sub $t4, $s2, $s3		# Subtract the two quotients
	addi $t5, $zero, 10
	div $t4, $t5
	mfhi $s4
	
	
	
	
	# Print output
	addi $v0, $zero, 4 		# Print result string
	la $a0, result1
	syscall
	addi $v0, $zero, 1 		# Print result
	move $a0, $s5
	syscall
	
	jal PrintNewLine
	
	addi $v0, $zero, 4 		# Print result string
	la $a0, result2
	syscall
	addi $v0, $zero, 1 		# Print result
	move $a0, $s4
	syscall
	
	#Exit program
	addi $v0, $zero, 10
	syscall
	
.data

	prompt: .asciiz "Enter the radius of a circle: "
	prompt2: .asciiz "Enter a value for y: "
	result1: .asciiz "The quotient is: "
	result2: .asciiz "The remainder is: "
	.include "utils.asm"
	
