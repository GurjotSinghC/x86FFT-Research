	.globl	main	
	.data

	####################################################################
	############Author: Gurjot Singh, Supervisor Dr. Roger Doering PHD##
	############---------------------------------------------------#####
	#{Works completed By Dr Doering: complex operators add divide multiply#
	#
	















_O_RDONLY: 	= 0x0000
_O_TEXT: 	= 0x4000

	#Debug Strings I use this to prefix values I need to view in console
realprint:	.asciiz	"This is the Real component "
imagprint:	.asciiz	"imaginary component  "
firstphit:	.asciiz	"We Set the First PhIT  "
firstph2:	.asciiz	"This is the real and imagine of phit^2:  "
compadd:	.asciiz	"Result of a complex addition  "
compsub:	.asciiz "Result of a complex subtraction  "
tandt:		.asciiz	"x[b] = t * T = "
Data:		.double	1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0
complex: 	.struct
real:		.double	0.0
imaginary:	.double	0.0
# powerofTwo:	.double	2 cant

#  remember what this is for
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

		.data
file:		.struct	
readhead:	.word	0
	.data
file.name:	.asciiz	"Data.txt"
	.align	4
	.code
file.readfile:	

	




	jr	$ra

# have to loook at magnitude of it first off sign is completley indpdent
# the have to mulitply it by powers of two  if the number is bigger than 


	.data

comparisontable:	.double	1.0e-100,1.0e-10,1.0e-1,1.0,10.0,1.0e10,1.0e100



	.code
#value to to convert in $a0
#
file.writefile_one_double:	
# 	l.d	$f2,comparisontable
	
# 	exponent in base 10 actual base of our floating point system
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

	#start it off by checking for zero
	la	$t0,comparisontable #
	addi	$t0,double*3 # get the first value of 1 to compare	
	l.d	$f2,($t0)	#load the first comparison table value
	l.d	$f0,($a0)	#first value input
	c.lt.d	$f2,$f0
	bc1t	greater_than_one

less_than_one:
	la	$t0,comparisontable	#get the lowest value
	l.d	$f2,($t0)		#gets 10^-100	
	li	$t2,100
	mtc1	$t2,$f8		#load 100 inot f4 this is our running exponent addition
	cvt.w.d	$f8,$f8	
	c.lt.d	$f0,$f2
	bc1t	left_to_right1
commence_division:
1:	div.d	$f12,$f0,$f2	# divides input by 10^100	
	add.d	$f4,$f4,$f8	#add running total of exponent
	c.lt.d	$f2,$f0
	bc1f	1b
left_to_right1:
	addi	$t0,8	#gets to the 10^10
	li	$t2,10
	mtc1	$t2,$f8
	cvt.w.d	$f8,$f8
	c.lt.d	$f0,$f2
# 	bc1t	left_to_right2
greater_than_one:
	li	$t2,100
	mtc1	$t2,$f8		#load 100 inot f4 this is our running exponent addition
	cvt.w.d	$f8,$f8
	addi	$t0,$t0,double*3	#this loads 10^100
	l.d	$f2,($t0)
	c.lt.d	$f2,$f0
	bc1f	next
1:	div.d	$f12,$f0,$f2	# divides input by 10^100	
	add.d	$f4,$f4,$f8	#add running total of exponent
	c.lt.d	$f2,$f0
	bc1f	1b
next:
	addi	$t0,$t0,-double	#go down on to 10^10
	li	$t2,10
	mtc1	$t2,$f8
	cvt.d.w	$f8,$f8
	l.d	$f2,($t0)
	c.lt.d	$f2,$f0
	bc1f	next2
1:	add.d	$f4,$f4,$f8
	div.d	$f12,$f0,$f2		
	c.lt.d	$f2,$f0
	bc1f	1b
next2:
	addi	$t0,$t0,-double	#go down on to 10^1
	li	$t2,1
	mtc1	$t2,$f8
	cvt.d.w	$f8,$f8
	l.d	$f2,($t0)
	c.lt.d	$f2,$f0
	bc1t	next3
1:	add.d	$f4,$f4,$f8
	div.d	$f12,$f0,$f2		
	c.le.d	$f2,$f0
	bc1f	1b
next3:	
	addi	$t0,$t0,-double
	l.d	$f2,($t0)	
	c.lt.d	$f2,$f0
	bc1t	endingsequence
endingsequence:
	floor.d	$f10,$f0
	cvt.w.d	$f6,$f10
	mfc1	$a0,$f6
	cvt.d.w	$f6,$f6
	addi	$a0,'0
	sb	$a0,($a1)	#assuming A1 is my buffer
	li	$t4,'.
	sb	$t4,2($a1)	#output the decimal point
	
	li	$t9,10
	mtc1	$t9,$f14
	cvt.w.d	$f14,$f14
	li	$t6,16
	li	$t7,-1
1:	sub.d	$f12,$f0,$f10
	mul.d	$f12,$f12,$f14
	addi	$t6,-1
	bne	$t6,$t7,1b
	#look at f8 if its 0 ignore it 
	#if its not zero than you output an e output the sign of f8 
	#take the abosulate value and convert 
	#possibly thrtee digit number 	
 	#check fi tits zero
	# 100*first digit divided by 10 after 10s you got one digit left
	
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
PI:	.double	3.1415926535897931
# use atan 1 compe up with pi 
T:	.double	1
	.double	0
Nfloat:	.double	8
N:	.word	8
ThetaT:	.double	0
phiT:	.double	0
	.double	0
Datapointer:	.word	0
t:	.double	0,0
m:	.word	3
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
a5:	.word	0
a6:	.word	0
a7:	.word	0


	
	.code
				# // (Your fft, ifft, mul_poly, sdp, int_sdp functions go here,
				# // copied exactly from your provided code) 
				# // Cooley-Tukey FFT (in-place, breadth-first, decimation-in-frequency)
				# // Better optimized but less intuitive
				# // !!! Warning : in some cases this code make result different from not optimased version above (need to fix bug)
				# // The bug is now fixed @2017/05/30

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
				#     double thetaT = PI / N; // division done in Long double output into double
	l.d	$f0,PI
	l.d	$f2,Nfloat	
	div.d	$f4,$f0,$f2
	s.d	$f4,ThetaT
				#     Complex phiT = Complex(cos(thetaT), -sin(thetaT)), T;	
	#f4 has thetaT	
	cos.d	$f6,$f4
	sin.d	$f8,$f4
	neg.d	$f8,$f8
	s.d	$f6,phiT
	la	$t9,phiT
	s.d	$f8,8($t9)	#basically storing to the double next phiT in memory
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
	bge	$t8,$s7,FinishDecimate	#     for (unsigned int a = 0; a < N; a++)
				#         unsigned int b = a;
	mov	$t3,$t8
				#         // Reverse bits
				#         b = (((b & 0xaaaaaaaa) >> 1) | ((b & 0x55555555) << 1));
	andi	$t9,$t3,0xaaaaaaaa
	srl	$t9,$t9,1
	andi	$s2,$t3,0x55555555
	sll	$s2,$s2,1
	or	$t3,$t9,$s2
				#         b = (((b & 0xcccccccc) >> 2) | ((b & 0x33333333) << 2));
	andi	$t9,$t3,0xcccccccc
	srl	$t9,$t9,2
	andi	$s2,$t3,0x33333333
	sll	$s2,$s2,2
	or	$t3,$t9,$s2
				#         b = (((b & 0xf0f0f0f0) >> 4) | ((b & 0x0f0f0f0f) << 4));
	andi	$t9,$t3,0xf0f0f0f0
	srl	$t9,$t9,4
	andi	$s2,$t3,0x0f0f0f0f
	sll	$s2,$s2,4
	or	$t3,$t9,$s2
				#         b = (((b & 0xff00ff00) >> 8) | ((b & 0x00ff00ff) << 8));
	andi	$t9,$t3,0xff00ff00
	srl	$t9,$t9,8
	andi	$s2,$t3,0x00ff00ff
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

				#         }
2:
	j	Decimate	
FinishDecimate:	
		#     }
				
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

complestruct:	.space	complex
file1:		.space	file	



	.code

main:

	jal	complex.Cooley_Tukey_FFT


end:










