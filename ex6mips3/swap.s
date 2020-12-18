.data
n1: .word 14
n2: .word 27
.text
main:
    la $a0,n1
    la $a1,n2
    jal swap
    li $v0,1
    lw $a0,n1
    syscall
    li $v0,11
    li $a0,' '
    syscall
    li $v0,1
    lw $a0,n2
    syscall
    li $v0,11
    li $a0,'\n'
    syscall
    li $v0,10
    syscall
swap:
    move $fp,$sp
    addiu $sp,$sp,-4

    lw $t0 ,0($a0) # t0= n1
    sw $t0 ,0($sp) # n1 入栈
    lw $t0 ,0($a1) # t0 = n2
    sw $t0 ,0($a0) # *a0 = n2
    lw $t0 ,0($sp) # t0 = n1
    sw $t0 ,0($a1) # *a1 = n2

    addiu $sp,$sp,4
    jr $ra
