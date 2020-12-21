# Explore Subroutines and how they work
.data

 prompt1: .asciiz "Main Method1"
 prompt2: .asciiz "Main Method2"

.text

 .globl main
main:
  la $a0, prompt1
  jal PrintString
  jal Sub1
  la $a0, prompt2
  jal PrintString
  jal Exit

# Subroutine 1 called by main
.data
 prompt3: .asciiz "Sub1 Method1"
 prompt4: .asciiz "Sub1 Method2"

.text
Sub1: 
  # Prolog. Save State
  sub $sp, $sp, 4		# Subtract 4 from $sp (Since stack grows down)
  sw $ra, 0($sp)		# Store the $ra address
  
  
  # Logic
  la $a0, prompt3
  jal PrintString
  jal Sub2
  la $a0, prompt4
  jal PrintString
  
  # Epilog. We have to restore state
  lw $ra, 0($sp)		# Load back $ra address
  add $sp, $sp, 4		# Add 4 to $sp
  
  jr $ra
  



# Subroutine 2 called by sub1
.data
 prompt5: .asciiz "Sub2 Method1"
 prompt6: .asciiz "Sub2 Method2"
.text
Sub2:
  # Prolog. Save State
  sub $sp, $sp, 4		# Subtract 4 from $sp (Since stack grows down)
  sw $ra, 0($sp)		# Store the $ra address
  la $a0, prompt5
  jal PrintString
  
  # Epilog. We have to restore state
  lw $ra, 0($sp)		# Load back $ra address
  add $sp, $sp, 4		# Add 4 to $sp
  
  jr $ra


   .include "utils.asm"