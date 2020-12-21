# Austin Spencer
# Fun With Switch
# Sets letter grade given percent grade


#declare our data
.data
	prompt1: .asciiz "Enter the grade percent: "
	Result: .asciiz "Your letter grade is: "
	agrade: .asciiz "A"
	bgrade: .asciiz "B"
	cgrade: .asciiz "C"
	dgrade: .asciiz "D"
	fgrade: .asciiz "F"


# get number from user
.text
main:
	la $a0, prompt1
	jal PromptInt
	move $t0, $v0
# Do integer division
	div  $t0, $t0, 10
	
# Start our switch
# switch
#case10:
#case9:
	
	seq $t1, $t0, 10 	# test for 9 or 10
	seq $t2, $t0, 9		# is it a 9
	or $t1, $t1, $t2	# if 9 or 10, then $t1 is set
	beqz $t1, case8 
	#put your logic here
	
	la $s0, agrade		# Load A grade into s0
	
	j endSwitch		# jump to endSwitch
case8:
	
	seq $t1, $t0, 8		# see if 80 percent
	beqz $t1, case7		
	
	la $s0, bgrade		# load B grade into s0
	
	j endSwitch		# jumpt to endSwitch
	
case7:
	seq $t1, $t0, 7		# test for 70 percent
	beqz $t1, case6
	
	la $s0, cgrade		# jump to endSwitch
	
	j endSwitch
case6:
	seq $t1, $t0, 6		# see if 60 percent
	beqz $t1, default	
	
	la $s0, dgrade		# jump to endSwitch
	
	j endSwitch
default:	# Else will print f grade
	la $s0, fgrade
	
	j endSwitch		# jump to endswitch
endSwitch:
	jal PrintNewLine	# print new line 
	la $a0, Result		# load result into address
	jal PrintString		# print string result
	move $a0, $s0		# move the grade letter from s0 to a0
	jal PrintString		# print the letter grade
	jal Exit		# exit cleanly

.include "utils.asm"