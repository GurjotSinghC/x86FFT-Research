
	.data
fp:	.struct	-36
loc:	.word	0
s7:	.word	0
s6:	.word	0
s5:	.word	0
s4:	.word	0
s3:	.word	0
s2:	.word	0
s1:	.word	0
s0:	.word	0
fp:	.word	0
ra:	.word	0
a0:	.word	0
a1:	.word	0
a2:	.word	0
a3:	.word	0
a4:	.word	0
	.data
	.code
# example of function preamble and postamble for a stack frame 
# note that the stacksize calculations use the topmost thing you're going to 
# push on the stack. (this supposes the use of a0-a3 and s0-s4)
myfunc:	addi	$sp,$sp,fp.s4-fp.a4
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

98:	lw	$ra,fp.ra($fp)
	lw	$s0,fp.s0($fp)
	lw	$s1,fp.s1($fp)
	lw	$s2,fp.s2($fp)
	lw	$s3,fp.s3($fp)
	lw	$s4,fp.s4($fp)
	lw	$fp,fp.fp($fp)
	add	$sp,$sp,fp.a4-fp.s4
	jr	$ra


