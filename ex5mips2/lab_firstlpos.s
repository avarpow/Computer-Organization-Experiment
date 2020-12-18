.text
main:
	lui	$a0,0x8000
	jal	first1pos
	jal	printv0
	lui	$a0,0x0001
	jal	first1pos
	jal	printv0
	li	$a0,1
	jal	first1pos
	jal	printv0
	add	$a0,$0,$0
	jal	first1pos
	jal	printv0
	li	$v0,10
	syscall


first1pos:	# your code goes here
    addi $sp,$sp,-4
    sw $ra ,0($sp)

    lui $t0,0x8000
    beq $a0,$0,zeroend #test if a0 equal 0

    addi $v0,$0,0

    loop:
        and $t3,$t0,$a0
        bnez $t3, end	# if $t3 >=0  endtarget
        addi $v0,$v0,1
        sll $a0,$a0,1
        j loop
    
    
    zeroend:
        addi $v0,$0,-1
    end:
        jr $ra

printv0:
	addi	$sp,$sp,-4
	sw	$ra,0($sp)
	add	$a0,$v0,$0
	li	$v0,1
	syscall
	li	$v0,11
	li	$a0,'\n'
	syscall
	lw	$ra,0($sp)
	addi	$sp,$sp,4
	jr	$ra
