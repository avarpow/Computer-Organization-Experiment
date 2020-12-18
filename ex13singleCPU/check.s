addiu  $1,$0,8
ori  $2,$0,2
add  $3,$2,$1
sub  $5,$3,$2
and  $4,$5,$2
or  $8,$4,$2
a:
sll  $8,$8,1
bne $8,$1,a
slti  $6,$2,4
slti  $7,$6,0
b:
addiu $7,$7,8
beq $7,$1,b
sw  $2,4($1)
lw  $9,4($1)
addiu  $10,$0,-2
c:
addiu  $10,$10,1
bltz $10,c
andi  $11,$2,2
j  d
or  $8,$4,$2
d:
nop
lui $10,10
mult $11,$6
mflo $12
mfhi $12
div $11,$6
f:
jal e
e:
bltzal $12 f
blez $12 f
sllv $13,$12,$6
addi $14,$0,132
jr $14
nop
A:
sra $12,$12,1
bgtz $12,A
addi $15,$0,-1
bgez $15,A
sb $15,0($s1)
sh $15,2($s1)
lb $16,0($s1)
lh $16,2($s1)
slt $16,$15,$0
sltiu $16,$15,-5
sltu $16,$15,$0
addi $8,$0,8
srl $8,$8,1
srlv $8,$8,$16
bgezal $8,g
g:
syscall

