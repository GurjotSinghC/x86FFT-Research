	.code
printalldata:
	addi	$sp,$sp,fp.s4-fp.a4	# standard stack frame
	sw	$fp,fp.fp-fp.s4($sp)
	add	$fp,$sp,fp.fp-fp.s4
	sw	$ra,fp.ra($fp)
	sw	$s0,fp.s0($fp)
	sw	$s1,fp.s1($fp)
	sw	$s2,fp.s2($fp)
	sw	$s3,fp.s3($fp)
	sw	$s4,fp.s4($fp)
	sw	$a0,fp.a0($fp)
	sw	$a1,fp.a1($fp)
	sw	$a2,fp.a2($fp)
	sw	$a3,fp.a3($fp)


	li	$a0,'\n
	syscall	$print_char
	li	$a0,'\n
	syscall	$print_char
	la	$a0,ButterFlyDebug
	syscall	$print_string


	lw	$t0,Data
	lw	$t2,N
	li	$s1,2
	mul	$t2,$t2,$s1



1:	beqz	$t2,98f	
	l.d	$f12,complex.real($t0)
	syscall	$print_double	
	

	la	$a0,SPACE
	syscall	$print_string
	l.d	$f12,complex.imaginary($t0)
	syscall	$print_double
	
	li	$a0,'\n
	syscall	$print_char

	addi	$t2,-2
	addi	$t0,16
	j	1b	
	
98:	lw	$ra,fp.ra($fp)	# restore registers from stacks
	lw	$s0,fp.s0($fp)
	lw	$s1,fp.s1($fp)
	lw	$s2,fp.s2($fp)
	lw	$s3,fp.s3($fp)
	lw	$s4,fp.s4($fp)
	lw	$fp,fp.fp($fp)
	add	$sp,$sp,fp.a4-fp.s4
	jr	$ra