# Program: mlSyntaxVariablesIO.asm
#  Author: **********
#    Date: mm/dd/yy
# Purpose: Practice printing data types
#-----------------------------------------------------------------
# Create assembler for the following C program:
# #include <iostream>
# #include <string>
# using namespace std;
#
#   void main()
#   {
#       string myname = "Your Name";
#       int age = 23;
#       float gpa = 3.5;
#       double pi = 3.1415926535897;
#       char gender = 'F';
#       bool hasProgrammed = 1; //true
#
#       cout << "Name:\t\t" << myname << endl;
#       cout << "Age:\t\t" << age << endl;
#       cout << "GPA:\t\t" << gpa << endl;
#       cout << "PI:\t\t" << pi << endl;
#       cout << "Gender:\t\t" << gender << endl;
#       cout << "Has Programmed:\t" << hasProgrammed << endl;
#   }
# OUTPUT:
#   Name:       My Name
#   Age:        23
#   GPA:        3.5
#   PI:     3.1415926535897
#   Gender:     F
#   Has Programmed: 1

.data
    .eqv    SYS_PRINT_WORD   1  #word, byte, character
    .eqv    SYS_PRINT_FLOAT  2  #float  
    .eqv    SYS_PRINT_DOUBLE 3  #double
    .eqv    SYS_PRINT_TEXT   4  #text (zero terminated)
    .eqv    SYS_EXIT    10  #terminate
    name: .asciiz "Name: "
    age: .asciiz "Age: "
    GPA: .asciiz "GPA: "
    PI: .asciiz "PI: "
    Gender: .asciiz "Gender: "
    history: .asciiz "Has programmed: "
    
    
    name2: .asciiz "Austin Spencer"
    age2: .word 22
    GPA2: .float 3.5
    pi2: .double 3.141592535897
    gender2: .asciiz "M"
    history2: .byte 1 #1 is true for boolean expressions
    
    	
    
    

.text
.globl  main
main:
# PRINT myname
	la $a0, name		# Load name into argument 0
	li $v0, SYS_PRINT_TEXT		
	syscall			# Print name 
	la $a0, name2
	li, $v0, SYS_PRINT_TEXT
	syscall
	jal PrintNewLine	# Print new line
	

# PRINT age
	la $a0, age		# Load age into argument 0
	li $v0, SYS_PRINT_TEXT
	syscall			# Print age
	lw $a0, age2
	li $v0, SYS_PRINT_WORD
	syscall
	jal PrintNewLine	# Print new line

# PRINT gpa	
	la $a0, GPA		# Load GPA into argument 0
	li $v0, SYS_PRINT_TEXT
	syscall			# Print GPA
	lwc1 $f12, GPA2
	li $v0, SYS_PRINT_FLOAT
	syscall
	jal PrintNewLine	# Print new line

# PRINT pi
	la $a0, PI		# Load PI into argument 0
	li $v0, SYS_PRINT_TEXT
	syscall			# Print PI
	ldc1 $f12, pi2
	li $v0, SYS_PRINT_DOUBLE
	syscall
	jal PrintNewLine	# Print new line
	
# PRINT gender
	la $a0, Gender		# Load Gender into argument 0
	li $v0, SYS_PRINT_TEXT
	syscall			# Print Gender
	la $a0, gender2
	li $v0, SYS_PRINT_TEXT
	syscall
	jal PrintNewLine	# Print new line
	
# PRINT hasProgrammed
	
	la $a0, history		# Load hasProgrammed into argument 0
	li $v0, SYS_PRINT_TEXT
	syscall			# Print history
	lb $a0, history2
	li $v0, SYS_PRINT_WORD
	syscall
	jal PrintNewLine	# Print new line
		
#------------------------
# terminate program.

	
    	li      $v0, SYS_EXIT   # call code for terminate
    	syscall                 # system call
    	.include "utils.asm"
#.end main
