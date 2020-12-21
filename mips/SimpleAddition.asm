# Title. SimpleAdditionProgram
#   int main() {
#   int x,
#       y,
#       z;
#   printf("Enter an Integer");
#   x = scanf();
#   printf("Enter another int");
#   y = scanf();
#   z = x + y;
#   printf("Your answer is " + z);
#}

	
# You need all your prompts and x, y and z!!!

# Author: Austin Spencer
# Date: 09/16/19
# program that takes input of 2 integers and then outputs the addition of the 2
# Class: CSC 230


.text
main: 
	la $a0, promptx			# promptx entered into argument 0
	jal PromptInt			
	move $t0, $v0			# move the entered int into register t0
	jal PrintNewLine		# prints a new line for good formatting
	#onto prompty with int 2
	la $a0, prompty			# promp entered into argument 0
	jal PromptInt			
	move $t1, $v0			# move the 2nd entered int into register t1
	jal PrintNewLine
	la $a0, resultz			# load result into argument 0
	addu $s0, $t1, $t0		# add first int with second int into a new string 0
	move $a1, $s0			# move the sum into argument 1
	jal PrintInt			# print the resulting int
	# call the Exit subprogram to exit
	jal Exit
	
	
	
	
	.data
	promptx: .asciiz "Enter an Integer: "
	prompty: .asciiz "Enter another int: "
	
	resultz: .asciiz "Your answer is: "
	
	.include "utils.asm"
	
.text

	
	
	
	
	