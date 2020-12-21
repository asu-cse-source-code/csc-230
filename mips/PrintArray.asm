
  	li $a0, 10		# I want room for 8 integers
	li $a1, 4		# Each integer takes 4 bytes
	jal AllocateArray
	
	move $s0, $v0, 		# Save the address of my new array
	
	li $t0, 1
	sw $t0, 0($s0)		# Load a 1 into the first location of my array
	li $t0, 2
	sw $t0, 4($s0)		# Put a 2 into the second location
	li $t0, 3
	sw $t0, 8($s0)		
	li $t0, 4
	sw $t0, 12($s0)	
	li $t0, 5
	sw $t0, 16($s0)		
	li $t0, 6
	sw $t0, 20($s0)	
	li $t0, 7
	sw $t0, 24($s0)		
	li $t0, 8
	sw $t0, 28($s0)	
	li $t0, 9
	sw $t0, 32($s0)		
	li $t0, 10
	sw $t0, 36($s0)	
	
	
	
	li $a1, 10
	move $a0, $s0
	
	jal PrintArray
	
	jal Exit	
	

AllocateArray:
  addi $sp, $sp, -4
  sw $ra, 0($sp)
  
  mul $a0, $a0, $a1
  li $v0, 9
  syscall
  
  lw $ra, 0($sp)
  addi $sp, $sp, 4
  jr $ra
  
  

PrintArray: 
  # Set up for loop
  # You need an i
  # You need length for the test (i < length)
  
  # put array into a register
  # add 4 every time to get the value
  
  # Prolog. Save State
  addi $sp, $sp, -12			# Subtract 12 from sp
  sw $ra, 0($sp)			# Store address
  sw $a0, 4($sp)			# Store array at 4($sp)
  sw $a1, 8($sp)			# Store size at 8($sp)
  
  
  #Logic
  	
  li $s3, 0				# Set counter to 0
  
  lw $a0, 4($sp)			# Load the Array
  lw $a1, 8($sp)			# Load the size
  	
  move $s0, $a0				# Move array to s0
  move $s1, $a1				# Move size to s1
  
  startLoop:
  	
  	slt $t1, $s3, $s1		# Set flag for t1 if s3 is less than s1 (counter < size)
  	beqz $t1, EndLoop		# If t1 is 1 (s3 < s1) then continue, else branch to EndLoop
  		lw $s5, 0($s0)		# Load the first value in array into s5
  		li $v0, 1
  		move $a0, $s5		# Move s5 into a0 to print the value
  		syscall			# Syscall to print the value
  		add $s0, $s0, 4		# Add 4 to s0 to get to next value
  		add $s3, $s3, 1		# Add 1 to our counter
  		la $a0, blank		# Load blank prompt into a0
  		li $v0, 4	
  		syscall			# Print the blank prompt
  		b startLoop		# branch to startLoop
  
 
    
   
   
  
  EndLoop:
  	# Epilog. We have to restore state
  	lw $ra, 0($sp)			# Load back $ra address
  	addi $sp, $sp, 12		# Add 12 to $sp
  
  	jr $ra				# Return original address
.data
	blank: .asciiz " " 		# Helps format output
  
  
  
  
.include "utils.asm"
