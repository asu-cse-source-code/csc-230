# print(Enter a number, -1 to exit)
# int $t0 = scanf();
# while ($t0 != -1) {
#	print("Results: " + $t0);
#	print("Enter a number, -1 to exit");
#	$t0 = scanf();
# }


# Challeng. Modify the above to do this
# do {
# print("Enter a number, -1 to exit")
# 	int $t0 = scanf()
# 	if ($t0 != -1)
# 		print("Results " + $t0);
# while ($t0 != -1)

# @author Austin Spencer
# class: CSC 230


.data
	prompt: .asciiz "\nEnter a number, -1 to exit: "
	output: .asciiz "\nYou entered: "
	
.text 
	.globl main

main: 
	
				
	start_loop:
		la $a0, prompt			# Set up our prompt
		jal PromptInt			# print the prompt
		move $s0, $v0			# moves answer from prompt
		sne $t1, $s0, -1		# Sets $t1 to 1 if entered number is -1
		la $a0, output			# now set up prompt output
		move $a1, $s0			# print the output
		jal PrintInt			# print the number entered
		move $s0, $v0			
		beqz $t1, EndIf			# if $t1 is -1 which was set earlier end
		b start_loop			# restart the loop
		
	
	
EndIf:
	jal Exit	
	.include "utils.asm"
