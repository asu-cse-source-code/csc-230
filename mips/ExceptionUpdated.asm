## Program to show overflow
	
	.text 			# text section
	.globl main		

main:		
	la $t0, value		# load address 'value' into $t0
	lw $t1, 0($t0)		# load maxint into $t1
	lw $t2, 0($t0)		# load maxint into $t2
	
	add $t3, $t1, $t2	# overflow exception on addition - 
				# see registers EPC and Cause
				# read text appendix Sec. A.7 for more information
	
				# replace add by addu - then no exception -
				# but "result" in $t3 is wrong - it is
				# obtained by throwing away the carry-out
				# from the most significant bit
	
	sub $t4, $0, $0     # this statement will not execute because of the exception
	
	li $v0, 4           # how do I get back here!!!
	la $a0, goodPanda
	syscall
							
   	li $v0, 10
   	syscall
      
.data			# data section
	value:	.word 0x7fffffff        # place maxint in memory
	goodPanda: .asciiz "Back to the main routine before quiting"
# Trap handler in the standard MIPS32 kernel text segment

   .ktext 0x80000180
   	# print the badPanda String
   	li $v0, 4
   	la $a0, badPanda
   	syscall
   	
   	# Go back to line 22!!!!!!!!!!!!!!!!!!!
 	mfc0 $k0,$14   # Coprocessor 0 register $14 has address of trapping instruction
	addi $k0,$k0,4 # Add 4 to point to next instruction
	mtc0 $k0,$14   # Store new address back into $14
	eret           # Error return; set PC to value in $14   	
   .kdata
	badPanda: .asciiz "Catching excepting gracefully"
