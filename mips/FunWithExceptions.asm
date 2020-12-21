
.data
  prompt1: .asciiz "Enter a number, but really enter a: "
  prompt2: .asciiz "Thanks for playing"
  
.text
  .globl main
main: 
  la $a0, prompt1
  jal PromptInt
  
  la $a0, prompt2
  jal PromptInt
  jal Exit
  



.kdata
  insult: .asciiz "Learn how to type dumb@ss"
  
.ktext 0x80000180
   la $a0, insult
   li $v0, 4
   syscall
   
   li $v0, 10
   syscall
   
   
   

.include "utils.asm" 
  
  
  
