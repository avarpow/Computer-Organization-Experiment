.data
foo:  
	.word 1,2,3,4,5
    
.text
main:
    la $t0,foo

    lw $t1,0($t0)
    addiu $t1,$t1,2
    sw $t1,0($t0)

    lw $t1,4($t0)
    addiu $t1,$t1,2
    sw $t1,4($t0)

    lw $t1,8($t0)
    addiu $t1,$t1,2
    sw $t1,8($t0)

    lw $t1,12($t0)
    addiu $t1,$t1,2
    sw $t1,12($t0)

    lw $t1,16($t0)
    addiu $t1,$t1,2
    sw $t1,16($t0)
    
exit: ori $v0, $0, 10				#System call code 10 for exit
	syscall					#print the sum