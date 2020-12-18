.data 
.align 2
Str: .asciiz "The sum of square  from 1 to 100 is "

.text

main:
    addi $t0,$0,1
    addi $t1,$0,0
loop:
    mult $t0,$t0
    mflo $t2
    add  $t1,$t1,$t2
    addi $t0,$t0,1
    bne $t0,101,loop

    ori $v0, $0, 4				
	la $a0, Str   	 	   
	syscall		

    ori $v0, $0, 1			
	add $a0,$0,$t1   	 	   
	syscall					

exit: 
    ori $v0, $0, 10				#System call code 10 for exit
	syscall					#print the sum
