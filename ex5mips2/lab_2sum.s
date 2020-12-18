.data 
str1:	.asciiz	"Enter 2 numbers:"  
str2:	.asciiz	"The sum is "
.text 
main:
    ori $v0, $0, 4				#System call code 4 for printing a string
	la $a0, str1   	 	    #address of Str1 is in $a0
	syscall					#print the string
    ori $v0, $0, 5				#System call code 5 for read integer�?$v0 contains integer read
    syscall
	add	$t0, $v0, $zero    #

    ori $v0, $0, 5				#System call code 5 for read integer�?$v0 contains integer read
    syscall
	add	$t1, $v0, $zero    #

    ori $v0, $0, 4				#System call code 4 for printing a string
	la $a0, str2   	 	    #address of Str2 is in $a0
	syscall					#print the string
    ori $v0, $0, 1				#System call code 4 for print integer�?$a0 = integer to print
	add $a0,$t0,$t1         #calculate the sum
	syscall					#print the sum

exit: ori $v0, $0, 10				#System call code 10 for exit
	syscall					#print the sum
