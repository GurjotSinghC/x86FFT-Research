				# // (Your fft, ifft, mul_poly, sdp, int_sdp functions go here,
				# // copied exactly from your provided code) 
				# // Cooley-Tukey FFT (in-place, breadth-first, decimation-in-frequency)
				# // Better optimized but less intuitive
				# // !!! Warning : in some cases this code make result different from not optimased version above (need to fix bug)
				# // The bug is now fixed @2017/05/30

	.data
decimationtable:	.word	0xaaaaaaaa
			.word	0x55555555
			.word	0xcccccccc
			.word	0x33333333
			.word	0xf0f0f0f0
			.word	0x0f0f0f0f
			.word	0xff00ff00
			.word	0xff00ff00
			.word	0x00ff00ff



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
	lw	$t2,N
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




#s7 is the this pointer
complex.Cooley_Tukey_FFT:	

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
	sw	$a3,fp.a3($fp)				# void fft(CArray &x,unsigned int m)
				# {
				#     // DFT
#     unsigned int N = x.size(), k = N, n;
	lw	$t0,N		# N = size
	mov	$t1,$t0		# k = N
	li	$t2,0		#n = 0	
				# double thetaT = PI / N; // division done in Long double output into double
 	l.d	$f0,PI
 	l.d	$f2,Nfloat	
 	div.d	$f4,$f0,$f2
 	s.d	$f4,ThetaT
 				#Complex phiT = Complex(cos(thetaT), -sin(thetaT)), T;	
 	#f4 has thetaT	
 	cos.d	$f6,$f4
 	sin.d	$f8,$f4
 	neg.d	$f8,$f8
 	s.d	$f6,phiT
 	la	$t9,phiT
 	s.d	$f8,8($t9)	#basically storing to the double next phiT in memory



	lw	$t8,m
												# 
												# 	la	$s3,PHI
												# 	la	$s5,phiT
												# 	li	$s4,16
												# 	mul	$t8,$s4,$t8	#this gives correct indice for number of
												# 	
												# 	add	$s3,$s3,$t8	#corret start
												# 
												# 	l.d	$f0,complex.real($s3)
												# 	s.d	$f0,complex.real($s5)
												# 	
												# 	s.d	$f0,complex.imaginary($s5)
	


	li	$a0,'\n
	syscall	$print_char
	li	$a0,'\n
	syscall	$print_char
	la	$a0,firstphit
	syscall	$print_string	
	l.d	$f12,phiT
	syscall	$print_double
	l.d	$f12,8($t9)
	syscall	$print_double
	#t9 is now phiT address




				#     while (k > 1)
				#     {
	li	$t6,1
top:	bgt	$t6,$t1,whileend
			#      n = k;
	mov	$t2,$t1
			#      k >>= 1;
	srl	$t1,$t1,1
			#      phiT = phiT * phiT;
	la	$v0,phiT  		#output stored here
	la	$a0,phiT
	la	$a1,phiT

	addi	$sp,-4	#this does jal to multiply Phit*phit
	sw	$ra,($sp)
	jal	complex.mul
	lw	$ra,($sp)
	addi	$sp,4

	li	$a0,'\n	#this is the debug string to view the first phit calc
	syscall	$print_char
	la	$a0,firstph2
	syscall	$print_string

	l.d	$f12,phiT	#prints real value of phit
	syscall	$print_double


	li	$a0,' 
	syscall	$print_char
	li	$a0,' 
	syscall	$print_char

	la	$a0,phiT	#prints the imaginary v alue of phit
	addi	$a0,8
	l.d	$f12,($a0)
	syscall	$print_double

	li	$a3,1
	mtc1	$a3,$f0
	cvt.d.w	$f0,$f0
	la	$a3,T
	s.d	$f0,complex.real($a3)
	
	mtc1	$0,$f0
	mtc1	$0,$f1
	cvt.d.w	$f0,$f0
	s.d	$f0,complex.imaginary($a3)

	li	$t9,0 #l =0				
tloop:				#         for (unsigned int l = 0; l < k; l++)
	
	bge	$t9,$t1,tloopend	
				#         {floop
				#             for (unsigned int a = l; a < N; a += n)
	mov	$t8,$t9	#a = l
sloop:	bge	$t8,$t0,sloopend
				#             
				# unsigned int b = a + k;
	add	$t3,$t8,$t1	# Complex t = x[a] - x[b];
	la	$t7,Data #array

	li	$s1,16
	mul	$s0,$t8,$s1

	add	$a0,$t7,$s0 #x[a]	

	mul	$s0,$t3,$s1	# multily b by 16

	add	$a1,$t7,$s0
	addi	$sp,-4
	sw	$ra,($sp)
	la	$v0,t	#need to know the address of the output	
	jal	complex.sub #cahnged from mul	
	lw	$ra,($sp)
	addi	$sp,4


	li	$a0,'\n		#this is t printing
	syscall	$print_char
	la	$a0,compsub
	syscall	$print_string
	l.d	$f12,t
	syscall	$print_double

				#                 x[a] += x[b];
	mov	$s0,$t8	#t8 is a
	li	$s1,16
	mul	$s0,$s0,$s1 #byte index a
	add	$a0,$t7,$s0 #x[a]
	mov	$v0,$a0	#fixes
	mov	$s0,$t3	#b
	mul	$s0,$s0,$s1	# multily b by 16
	add	$a1,$t7,$s0
	addi	$sp,-4
	sw	$ra,($sp)
	jal	complex.add
	lw	$ra,($sp)
	addi	$sp,4		

	li	$a0,'\n
	syscall	$print_char
	
	la	$a0,compadd
	syscall	$print_string
# 
	l.d	$f12,complex.real($v0)
 	syscall	$print_double


			#                 x[b] = t * T;
	mov	$s0,$t3	#b
	mul	$s0,$s0,$s1	# multily b by 16
	add	$v0,$s0,$t7
	addi	$sp,-4
	sw	$ra,($sp)
	la	$a0,t
	la	$a1,T
	jal	complex.mul
	lw	$ra,($sp)
	addi	$sp,4
	la	$a0,tandt
	syscall	$print_string
	l.d	$f12,($v0)
	syscall	$print_double
	add	$t8,$t8,$t2 #a+=n
	j	sloop
sloopend:	#             }sloop
						#             T *= phiT;
	la	$a0,T
	la	$a1,phiT
	la	$v0,T
	addi	$sp,-4
	sw	$ra,($sp)
	jal	complex.mul
	lw	$ra,($sp)
	addi	$sp,4
	addi	$t9,1

	j	tloop			#         }floop

tloopend:
	j	top

#end of while lop

				#     }while
whileend:
	la	$s6,decimationtable

				#     // Decimate
				#     //    unsigned int m = (unsigned int)log2(N);
			#     
	li	$t8,0 #a=0				#{
	lw	$s7,N
	li	$a0,'V
	syscall	$print_char
	l.d	$f12,phiT
	syscall	$print_double
Decimate:
bga:
	la	$s6,decimationtable
	bge	$t8,$s7,FinishDecimate	#     for (unsigned int a = 0; a < N; a++)
				#         unsigned int b = a;
	mov	$t3,$t8
				#         // Reverse bits
				#         b = (((b & 0xaaaaaaaa) >> 1) | ((b & 0x55555555) << 1));
	lw	$s3,0($s6)

	and	$t9,$t3,$s3
	srl	$t9,$t9,1

	lw	$s3,4($s6)
	and	$s2,$t3,$s3
	sll	$s2,$s2,1
	or	$t3,$t9,$s2
				#         b = (((b & 0xcccccccc) >> 2) | ((b & 0x33333333) << 2));
	lw	$s3,8($s6)
	and	$t9,$t3,$s3
	srl	$t9,$t9,2
	lw	$s3,12($s6)

	and	$s2,$t3,$s3
	sll	$s2,$s2,2
	or	$t3,$t9,$s2
				#         b = (((b & 0xf0f0f0f0) >> 4) | ((b & 0x0f0f0f0f) << 4));

	lw	$s3,16($s6)
	and	$t9,$t3,$s3
	srl	$t9,$t9,4
	lw	$s3,20($s6)
	and	$s2,$t3,$s3
	sll	$s2,$s2,4
	or	$t3,$t9,$s2
				#         b = (((b & 0xff00ff00) >> 8) | ((b & 0x00ff00ff) << 8));
	lw	$s3,24($s6)
	and	$t9,$t3,$s3
	srl	$t9,$t9,8
	lw	$s3,28($s6)
	and	$s2,$t3,$s3
	sll	$s2,$s2,8
	or	$t3,$t9,$s2
				#         b = ((b >> 16) | (b << 16)) >> (32 - m);
	srl	$t9,$t3,16
	sll	$s0,$t3,16
	
	or	$t9,$t9,$s0

	lw	$v1,m
	neg	$v1,$v1
	addi	$s1,$v1,32
	srl	$t3,$t9,$s1
	addi	$t8,1
# bga:				#         if (b > a)
				#         {
	blt	$t8,$t3,2f
1:				#             //            Complex t = x[a];
	li	$s7,16
	mul	$s4,$s7,$t8
	add	$s4,$t7,$s4
	l.d	$f0,($s4)
	s.d	$f0,t
	l.d	$f2,t
			#             //            x[a] = x[b];
	li	$s7,16
	mul	$s7,$s7,$t3
	add	$s5,$t7,$s7	#s5 is x[b]
	l.d	$f0,($s5)
	s.d	$f0,($s4)	

	mov.d	$f12,$f0
	syscall	$print_double				#             //            x[b] = t;
	l.d	$f0,t
	s.d	$f0,($s5)	
	jal	printalldata


				#         }
2:
	j	Decimate	
FinishDecimate:	
		#     }
			

97:	

	la	$t7,Data
	
	l.d	$f0,complex.real($t7)
	l.d	$f2,complex.imaginary($t7)
	l.d	$f4,16($t7)
	l.d	$f6,24($t7)

	s.d	$f4,($t7)
	s.d	$f6,8($t7)
	
	s.d	$f0,16($t7)
	s.d	$f2,24($t7)


	l.d	$f14,Rounding_Factor	#LOAD THE ROUDNIGN FACTOR


	li	$t0,32
	li	$t1,0
	la	$t2,Data
	addi	$t2,-8
	l.d	$f2,NormalizationRange
	li	$s1,0
	mtc1	$s1,$f0
	cvt.d.w	$f0,$f0
	li	$t1,8
Normalize:	
	bltz	$t0,END   
	
	add	$t2,$t2,$t1
	
	l.d	$f12,($t2)
	abs.d	$f12,$f12
	addi	$t0,-1


	mul.d	$f12,$f14,$f12
	round.d	$f12,$f12
	floor.d	$f12,$f12	
	div.d	$f12,$f12,$f14
	s.d	$f12,($t2)

	c.le.d	$f12,$f2

	bc1t	zeroutvalue

	j	Normalize
	
zeroutvalue:


	s.d	$f0,($t2)
	l.d	$f12,($t2)
	syscall	$print_double

	j	Normalize






END:
	  jal	printalldata











	
	

98:	

	lw	$ra,fp.ra($fp)	# restore registers from stack
	lw	$s0,fp.s0($fp)
	lw	$s1,fp.s1($fp)
	lw	$s2,fp.s2($fp)
	lw	$s3,fp.s3($fp)
	lw	$s4,fp.s4($fp)
	lw	$fp,fp.fp($fp)
	add	$sp,$sp,fp.a4-fp.s4
	jr	$ra