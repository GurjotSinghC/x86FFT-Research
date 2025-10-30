#format a string into double into and outputinto a file

#Please NOTE this will clear the screen
Complex2String:	#	void Double_To_String (double Input:f12,f14, char * Buffer:a3)
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

	li	$a0,'\f
	syscall	$print_char

	syscall	$print_double
	mfc1	$a0,$f15
	bltz	$a0,2f
	addi	$a0,$0,'+
	syscall	$print_char
2:	mov.d	$f12,$f14
	syscall	$print_double
	
	li	$a0,'j
	syscall	$print_char

	mov	$a0,$0
	mov	$a1,$0		
3:	syscall	$xy
	
	addi	$a0,$a0,1
	sb	$v0,($a3)
	addi	$a3,$a3,1
	bne	$v0,' ,3b
	li	$t0,'\n
	sb	$t0,-1($a3)
	mov	$v0,$a0
98:	lw	$ra,fp.ra($fp)	# restore registers from stack
	lw	$s0,fp.s0($fp)
	lw	$s1,fp.s1($fp)
	lw	$s2,fp.s2($fp)
	lw	$s3,fp.s3($fp)
	lw	$s4,fp.s4($fp)
	lw	$fp,fp.fp($fp)
	add	$sp,$sp,fp.a4-fp.s4
	jr	$ra

	.data
console:	.struct	0xa0000010
flags:	.byte	0
mask:	.byte	0
	.half	0
char:	.byte	0
col:	.byte	0
row:	.byte	0
con:	.byte	0
