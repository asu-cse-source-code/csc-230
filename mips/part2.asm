# Title: Quiz Part2
# Desc: takes data and performs arithmetic to it
# Name: Austin Spencer

.data		# Variables
var1: 	.word	0x2A
var2: 	.ascii	"0x3A"
var3: 	.ascii  "0x02"

.text		# Logic i.e. our code

	.globl main
main:
	lw $t0, var1		# pseudocode that loads the value var2 word into $t0
	la $s0, var2		# pseudocode that loads the value var2 addresses into $s1
	la $s1, var3		# Loads address that var3 holds into $s1
	addu $t1, $t0, $s0	# add uninitialized var1 + var2
	subu $t2, $t1, $t0	# subtract the sum of var1 + var2 by var1
	move $a0, $t2		# move result into address 0
	jal PrintInt		# print result
	jal Exit		# Exit cleanly
		
	
	
	
	
.text
PrintInt:
	# Print string. The string address is already in $a0
	li $v0, 4
	syscall
	# Print integer. The integer value is in $a1, and must
	# be first moved to $a0.
	#move $a0, $a1
	li $v0, 1
	syscall
	#return
	jr $ra
Exit:
	li $v0, 10
	syscall
	
	
	
	
