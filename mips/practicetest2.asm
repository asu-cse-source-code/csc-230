# Austin Spencer
# Test 1 code
# Take 4 integers and add them all up
#

.data

x1: .word 3
x2: .word 4
x3: .word 4
x4: .word 5


.text

main:
	lw $t0, x1
	lw $t1, x2
	lw $t2, x3
	lw $t3, x4
	
	addu $t4, $t1, $t0
	
	add $t4, $t4, $t2
	
	add $t4, $t4, $t3
	
	move $a0, $t4
	
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall