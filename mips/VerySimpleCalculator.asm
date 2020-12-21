.text
main:
	# read an input value from the user
	la $a0, prompt1
	jal PromptInt
	move $t0, $v0
	# print the value back to the user
	jal PrintNewLine
	la $a0, prompt2
	jal PromptInt
	move $t1, $v0
	jal PrintNewLine
	addu $s0, $t1, $t0
	move $a1, $s0
	jal PrintInt
	# call the Exit subprogram to exit
	jal Exit
	.data
	#prompt1: .asciiz "Welcome to the very simple calculator"
	prompt1: .asciiz "Please enter number 1: "
	prompt2: .asciiz "Please enter number 2: "
	
	
	result: .asciiz "The sum of the numbers is "
 .include "utils.asm"
