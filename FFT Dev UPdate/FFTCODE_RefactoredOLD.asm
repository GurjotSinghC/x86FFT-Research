	.globl	main	
	.include	"Datamembers.asm"
	.data

pointer:	.double	0
_O_RDWR: 	= 0x0000
_O_TEXT: 	= 0x4000
	

	

		.data
file:		.struct	
readhead:	.word	0
	.data
file.name:	.asciiz	"Data.txt"
	.align	8

	.code
	.include	"StackOFFsets.asm"
	.include	"complex_operations.asm"
	.include	"oldgarbage.asm"
	.include	"FFT_ALGO.asm"
	.include	"ComplexToString.asm"
#files with macro instructions
#we have a macro builder invoking it in user code has never been permitted its a job she shoudl tackel
#
	.data

	.code
file.readfile:	
	
	la	$a0,file.name
	addi	$a1,_O_RDWR|_O_TEXT
	syscall	$open
	mov	$a0,$v0
	la	$a1,m
	li	$a2,1
	syscall	$read
	
	mov	$a0,$a1
	syscall	$string2double
	cvt.w.d	$f0,$f0
	mfc1	$t0,$f0
	sw	$t0,m

	lw	$a0,m
	syscall	$print_int

	lw	$t0,m
	li	$t1,2
1:	bltz	$t0,99f
	mul	$t1,$t1,$t1
	j	1b
	
99:	sw	$t1,N
	mtc1	$t1,$f0
	cvt.d.w	$f0,$f0
	s.d	$f0,Nfloat




	jr	$ra


# have to loook at magnitude of it first off sign is completley indpdent
# the have to mulitply it by powers of two  if the number is bigger than 
file.writeData:
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


	li	$a0,32
	syscall	$malloc
	mov	$a3,$v0
	li	$t1,N
	la	$t0,Data
1:	bnez	$t1,end	

	l.d	$f12,complex.real($t0)
	l.d	$f14,complex.imaginary($t0)
	jal	Complex2String
	mov	$t2,$v0	#this is the number of bytes converted


	la	$a0,file.name
	addi	$a1,_O_RDWR|_O_TEXT
	syscall	$open
	mov	$a0,$v0	#file handle
	mov	$a1,$a3
	mov	$a2,$v0
	syscall	$write



	
	
	# also create write data with phasor notaiton 

end:


98:	lw	$ra,fp.ra($fp)	# restore registers from stack
	lw	$s0,fp.s0($fp)
	lw	$s1,fp.s1($fp)
	lw	$s2,fp.s2($fp)
	lw	$s3,fp.s3($fp)
	lw	$s4,fp.s4($fp)
	lw	$fp,fp.fp($fp)
	add	$sp,$sp,fp.a4-fp.s4
	jr	$ra
	jr	$ra
	

	.data

comparisontable:	.double	1.0e-100,1.0e-10,1.0e-1,1.0,10.0,1.0e10,1.0e100



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
	la	$t0,Data
	li	$t2,16
1:	beqz	$t2,98f	
	l.d	$f12,($t0)
	syscall	$print_double	
	addi	$t0,16
	li	$a0,' 
	syscall	$print_char
	li	$a0,' 
	syscall	$print_char	
	addi	$t2,-1
	j	1b	
98:	lw	$ra,fp.ra($fp)	# restore registers from stack
	lw	$s0,fp.s0($fp)
	lw	$s1,fp.s1($fp)
	lw	$s2,fp.s2($fp)
	lw	$s3,fp.s3($fp)
	lw	$s4,fp.s4($fp)
	lw	$fp,fp.fp($fp)
	add	$sp,$sp,fp.a4-fp.s4
	jr	$ra




	.code

main:
	jal	file.readfile
	jal	complex.Cooley_Tukey_FFT	
	jal	file.writeData

	jr	$ra