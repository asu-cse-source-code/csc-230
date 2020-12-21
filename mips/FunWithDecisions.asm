.text	
# if (num > 0 )
# print "positive number"
# else if(num<0)
# print "negative number"
# else
# print "zero"
# endif
.text
lw 	$t0, num
sgt	$t1, $t0, $zero 		# $t1 is the boolean(num > 0)


beqz	$t1, else_if			# note: the code block is entered if
	# {
	# print ("Number is positive")
	la $a0, PositiveNumber
	jal PrintString
	# }
	b end_if			# Jump to the end_if
else_if:				# Else if Section
	# {
	# print ("Number is negative")
	slt	$t1, $t0, $zero		# $ $t1 is the boolean (num<0)
	beqz	$t1, else		# Not: code block is entered if
	la $a0, NegativeNumber
	jal PrintString
	# }
	b end_if
else:
	# {
	# print ("Number is zero")
	la $a0, ZeroNumber
	jal PrintString
	# }
	

end_if:
jal Exit
.data
num: .word 0
PositiveNumber: .asciiz "Number is positive"
NegativeNumber: .asciiz "Number is negative"
ZeroNumber:	.asciiz "Zero"
.include "utils.asm"
