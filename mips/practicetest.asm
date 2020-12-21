# Austin Spencer
# Exam 1 code
# Take three integers and add the first two then divide result by the third

.data
	int1: .asciiz "Please enter a number: "
	int2: .asciiz "Please enter another number: "
	int3: .asciiz "Please enter another number: "
	result: .asciiz "Your result is: "


.text

main:

	la $a0, int1
	jal PromptInt
	move $t0, $v0
	
	la $a0, int1
	jal PromptInt
	move $t1, $v0
	
	la $a0, int1
	jal PromptInt
	move $t2, $v0
	
	addu $t3, $t1, $t0
	div $t3, $t3, $t2
	
	la $a0, result
	move $a1, $t3
	Jal PrintInt
	jal Exit
	
	
.data

.include "utils.asm"

	
