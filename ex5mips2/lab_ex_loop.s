.data
foo:  
	.word 1,2,3,4,5

.text
main:
	la $t0,foo
	addi $t2,$0,0
loop:
    lw $t1,0($t0)
    addiu $t1,$t1,2
    sw $t1,0($t0)

    addi $t0,$t0,4
    addi $t2,$t2,1
    bne $t2,5,loop
    
exit: ori $v0, $0, 10				#System call code 10 for exit
	syscall					#print the sum