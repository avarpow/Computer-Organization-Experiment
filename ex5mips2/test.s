.data
.global main
.text
main:
    li $v0,5
    syscall
    move 	$a0, $v0		# $a0 = v01
    li $v0,1
    syscall