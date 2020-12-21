

.text
 .globl main
main:
	li $a0, 8		# I want room for 8 integers
	li $a1, 4		# Each integer takes 4 bytes
	jal AllocateArray
	
	move $s0, $v0, 		# Save the address of my new array
	
	li $t0, 1
	sw $t0, 0($s0)		# Load a 1 into the first location of my array
	li $t0, 2
	sw $t0, 4($s0)		# Put a 2 into the second location
	
	# Lets allocate a second array
	
	li $a0, 8		# I want room for 8 integers
	li $a1, 4		# Each integer takes 4 bytes
	jal AllocateArray
	
	move $s0, $v0, 		# Save the address of my new array
	
	li $t0, 99
	sw $t0, 0($s0)		# Load a 1 into the first location of my array
	li $t0, 98
	sw $t0, 4($s0)		# Put a 2 into the second location
	
	jal Exit
	
	


# Subprogram: AllocateArray
# Purpose:To allocate an array of $a0 items, 
#               each of size $a1.
# Author:Charles Kann
# Input:$a0 - the number of items in the array
#$a1 - the size of each item
# Output:$v0 - Address of the array allo


AllocateArray:
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  
  mul $a0, $a0, $a1
  li $v0, 9
  syscall
  
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
  
  
.include "utils.asm"