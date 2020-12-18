.text
main:
    addi $a0,$0,10
    jal sum_numbers
    add $a0,$0,$v1 #结果储存在v1中
    addi $v0,$0,1  
    syscall       #输出
    addi $v0,$0,10
    syscall  #结束程序

sum_numbers:
    addi $sp,$sp,-8
    sw $ra,4($sp)
    sw $a0,0($sp)
    beq $a0,$0,zero
    j nonezero
    zero:
        addi $v1,$0,0 #判断参数是0
        j end
    nonezero:
        subi $a0,$a0,1
        jal sum_numbers #调用sum_numbers(a0-1)
        add $v1,$v1,$a0
        addi $v1,$v1,1 #v1 += (a0-1)+1;
        j end
    end:
        lw $ra,4($sp) 
        lw $a0,0($sp) #恢复现场
        addi $sp,$sp,8
        jr $ra
