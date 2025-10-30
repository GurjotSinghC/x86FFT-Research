complex: 	.struct
real:		.double	0.0
imaginary:	.double	0.0

# powerofTwo:	.double	2 cant remember what this is for
	.code
complex.add:
# complex:v0 complex::add(complex*arg1:a0,complex*arg2:a1)

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
	l.d	$f12,complex.real($a0)
	l.d	$f14,complex.imaginary($a0)
	l.d	$f16,complex.real($a1)
	l.d	$f18,complex.imaginary($a1)
	add.d	$f0,$f12,$f16
	add.d	$f2,$f14,$f18
	s.d	$f0,complex.real($v0)
	s.d	$f2,complex.imaginary($v0)

	li	$a0,'\n
	syscall	$print_char


	mov.d	$f12,$f0
	syscall	$print_double
	li	$a0,' 
	syscall	$print_char	
	mov.d	$f12,$f2	
98:	lw	$ra,fp.ra($fp)	# restore registers from stack
	lw	$s0,fp.s0($fp)
	lw	$s1,fp.s1($fp)
	lw	$s2,fp.s2($fp)
	lw	$s3,fp.s3($fp)
	lw	$s4,fp.s4($fp)
	lw	$fp,fp.fp($fp)
	add	$sp,$sp,fp.a4-fp.s4
	jr	$ra


complex.mul:
#complex:v0 complex::mul(complex * arg1:$a0,complex*arg2:a1)
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


	l.d	$f12,complex.real($a0)
	l.d	$f14,complex.imaginary($a0)
	l.d	$f16,complex.real($a1)
	l.d	$f18,complex.imaginary($a1)

	#imaginary times imagery 
	mul.d	$f0,$f12,$f16 			#real and real
	mul.d	$f2,$f14,$f18 		       	#imagine and maignary
	sub.d	$f0,$f0,$f2 			#i*i is -1
	
	mul.d	$f2,$f14,$f16
	mul.d	$f4,$f12,$f18
	add.d	$f2,$f2,$f4
	li	$a0,'\n
	syscall	$print_char
	la	$a0,realprint
	syscall	$print_string
	s.d	$f0,complex.real($v0)
	mov.d	$f12,$f0
	syscall	$print_double
	li	$a0,' 
	syscall	$print_char
	s.d	$f2,complex.imaginary($v0)
	la	$a0,imagprint
	syscall	$print_string
	mov.d	$f12,$f2
	syscall	$print_double
98:	lw	$ra,fp.ra($fp)	# restore registers from stack
	lw	$s0,fp.s0($fp)
	lw	$s1,fp.s1($fp)
	lw	$s2,fp.s2($fp)
	lw	$s3,fp.s3($fp)
	lw	$s4,fp.s4($fp)
	lw	$fp,fp.fp($fp)
	add	$sp,$sp,fp.a4-fp.s4
	jr	$ra


complex.sub:
# complex:v0 complex::sub(complex*arg1:a0,complex*arg2:a1)

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
	l.d	$f12,complex.real($a0)
	l.d	$f14,complex.imaginary($a0)

	l.d	$f16,complex.real($a1)
	l.d	$f18,complex.imaginary($a1)
	sub.d	$f0,$f12,$f16
	sub.d	$f2,$f14,$f18
	s.d	$f0,complex.real($v0)
	s.d	$f2,complex.imaginary($v0)
98:	lw	$ra,fp.ra($fp)	# restore registers from stack
	lw	$s0,fp.s0($fp)
	lw	$s1,fp.s1($fp)
	lw	$s2,fp.s2($fp)
	lw	$s3,fp.s3($fp)
	lw	$s4,fp.s4($fp)
	lw	$fp,fp.fp($fp)
	add	$sp,$sp,fp.a4-fp.s4
	jr	$ra

complex.div:
#complex:v0 complex::div(complex*arg1:a0,complex*arg2:a1)
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
	l.d	$f12,complex.real($a0)
	l.d	$f14,complex.imaginary($a0)
	l.d	$f16,complex.real($a1)
	l.d	$f18,complex.imaginary($a1)
	mul.d	$f0,$f12,$f16 	# a*c
	mul.d	$f2,$f14,$f18 	# b*d
	add.d	$f0,$f0,$f2 	# ac + bd
	mul.d	$f2,$f14,$f16	# bc
	mul.d	$f4,$f12,$f18	# ad
	sub.d	$f2,$f2,$f4	# bc-ad
	mul.d	$f4,$f16,$f16	#c²
	mul.d	$f8,$f18,$f18	#d²
	add.d	$f4,$f4,$f8	#c²+d²
	div.d	$f0,$f0,$f4	# whole real term
	div.d	$f2,$f2,$f4	# whole imaginary term
	s.d	$f0,complex.real($v0)
	s.d	$f2,complex.imaginary($v0)
98:	lw	$ra,fp.ra($fp)	# restore registers from stack
	lw	$s0,fp.s0($fp)
	lw	$s1,fp.s1($fp)
	lw	$s2,fp.s2($fp)
	lw	$s3,fp.s3($fp)
	lw	$s4,fp.s4($fp)
	lw	$fp,fp.fp($fp)
	add	$sp,$sp,fp.a4-fp.s4
	jr	$ra