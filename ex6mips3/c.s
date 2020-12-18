.data
K: .space 4
Y: .word 56
Z: .space 200

.text
main:
    la $t0,K     
    lw $t0,0($t0)    #t0 = K
    la $t1,Z         #t1为数组首地址
    la $t2,Y
    lw $t2,0($t2)    #t2 = Y
    addi $t3,$0,0    #t3 =0  用于循环变量
    addi $t5,$0,50   #t4 = 50 用于判断循环结束
    loop:
        addi $t4,$t3,0    #t4=t3
        sra  $t4,$t4,2    #t4=t4/4
        addi $t4,$t4,210  #t4=t4+210
        sll  $t4,$t4,4    #t4=t4*16
        sub  $t4,$t2,$t4 #t4=56-t2
        sw $t4,0($t1)    #计算结果储存回内存
        addi $t1,$t1,4   #数组指针t1++
        addi $t3,$t3,1   #循环临时变量+1
        beq  $t3,$t5,end #判断是否跳出循环
        j loop
    end:
        addi $v0,$0,10   #结束程序
        syscall

        