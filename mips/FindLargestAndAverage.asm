# Find Largest and Average
#  A program that asks for 3 numbers and then
# calls a subroutine that find the largest and average

.data
  prompt1: .asciiz "Enter number1: "		# First number prompt
  prompt2: .asciiz "Enter number2: "		# Second number prompt
  prompt3: .asciiz "Enter number3: "		# Third number prompt
  result: .asciiz "Largest: "			# Largest number result prompt
  resultaV: .asciiz "Average: "			# Average of the numbers result prompt
.text 
  .globl main
main:
  # ask and get num1
  la $a0, prompt1				# Load prompt
  jal PromptInt					# Prompt user to enter an int
  move $s0, $v0					# move the number entered into our s register
  
  # ask and get num2
  la $a0, prompt2				# Load prompt
  jal PromptInt					# Prompt user to enter an int
  move $s1, $v0					# move the number entered into our s register
  
  
  la $a0, prompt3				# Load prompt
  jal PromptInt					# Prompt user to enter an int
  move $s2, $v0					# move the number entered into our s register
  

  
  # call getAverageAndLargest
  # Set up our parameters
  # Move the user's numbers into a registers
  move $a0, $s0
  move $a1, $s1
  move $a2, $s2
  jal getAverageAndLargest			# Jump to getAverageAndLargest
  
  la $a0, result
  move $a1, $v0					# Move result of function call to $a0
  jal PrintInt					# Print the largest number
  
  jal PrintNewLine				# Print a new line for formatting
  
  la $a0, resultaV
  move $a1, $v1					# Move result of function call to $a0
  jal PrintInt					# Print the average of the numbers
  
  # Exit
  jal Exit					# Exit cleanly
  
# subroutine getAverageAndLargest
# returns largest in $v0, and average in $v1
  
.text
getAverageAndLargest:
  # prolog (save anything needed to be saved)
  sub $sp, $sp, 16
  sw $a1, 0($sp)
  sw $s0, 4($sp)
  sw $s1, 8($sp)
  sw $ra, 12($sp)
  
  # $v0 = getLargest($a0, $a1)
  
  jal getLargest				# Jump and Link to getLargest
  jal getAverage				# Jump and Link to getAverage
  
  # epilog
  lw $ra, 12($sp)
  lw $s1, 8($sp)
  lw $s0, 4($sp)
  add $sp, $sp, 16
  
  jr $ra					# Keep the return address
  
 # getLargest is passed two numbers and returns the largest 
.text

getAverage:
  addu $t0, $a0, $a1				# Add the first 2 numbers and put result in t0 register
  addu $t0, $t0, $a2				# Add the first 2 numbers plus third number and put result in t0 register
  divu $v1, $t0, 3				# Div total sum of the numbers by 3 to get average and put result
  						# into the $v1 register
  
  
 
getLargest:
  move $v0, $a0					# Move $a0 into $v0
  sgt $t0, $a1, $a0				# If a1 > a0, set our flag
  
  beqz $t0, largest2				# branch to largest2 if a1 is less than a0
    move $v0, $a1				# Move $a1 into $v1 since it is the largest so far
    sgt $t1, $a2, $a1				# If a2 > a1, set our flag
    
    beqz $t1, endIf				# branch to largest2 if a1 is less than a0
      move $v0, $a2				# move $a2 into $v0 since it is the largest


largest2: 
  sgt $t2, $a2, $a0				# If a2 > a0, set our flag
  beqz $t2, endIf				# branch to endIf if a2 is less than a0
    move $v0, $a2				# move $a2 into $v0 since it is the largest


endIf:
  jr $ra					# Keeping the return address
  
 
 
  .include "utils.asm"
