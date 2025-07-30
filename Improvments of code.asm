	.globl	main	
	.data


_O_RDONLY: 	= 0x0000
_O_TEXT: 	= 0x4000



realprint:	.asciiz	"This is the Real component "
imagprint:	.asciiz	"imaginary component  "
firstphit:	.asciiz	"We Set the First PhIT  "
firstph2:	.asciiz	"This is the real and imagine of phit^2:  "

compadd:	.asciiz	"Result of a complex addition  "
compsub:	.asciiz "Result of a complex subtraction  "
tandt:		.asciiz	"x[b] = t * T = "
filename:	.asciiz	"Data.txt"


Data:		.double	1,0,2,0,3,0,4,0,5,0,6,0,7,0,8,0







		.data
file:		.struct	
readhead:	.word	0
	.data
file.name:	.asciiz	"Data.txt"

	.align	4

	.code
file.readfile:	

	
	li	$a0,2000
	
	syscall	$malloc
# 	MIPS  P8700 Multiprocessing System (MPS) cost
	sw	$v0,Datapointer
	la	$t0,Datapointer

	mov	$a0,$s0	#file handle as first argument
	la	$a1,Datapointer
	li	$a2,1024 #number of bytes to be read

	syscall	$read

	mov	$a0,$s0
	

	mov	$t2,$v0	#this is the nunumber of bytes read 
# 	add	$t2,$t0,$t2	#this is teh last address of the buffer
	syscall	$close
	#Facts up to this pointer
	# ($t0) is the buffer address
	# ($t2) is the last address of the buffer
	# ($t3) is the number of bytes read
	# ($s0) holds the file handle
	# ($t8) is my for loop counter

	li	$t7,'\n
	li	$t4,0
	li	$t6,'\n
	li	$t8,0
1:	
#  	beq	$t8,$t2,2f
	lb	$t5,($t0)	
	
	bne	$t5,$t6,iterate	
nullwrite:
	sb	$0,($t0)
	addi	$t0,2
	addi	$t8,1
	j	2f		
iterate:
	addi	$t8,1
	addi	$t0,1
	j	1b

	
2:
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

complex: 	.struct
real:		.double	0.0
imaginary:	.double	0.0
powerofTwo:	.double	2	



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

	la	$a0,compadd
	syscall	$print_string

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







				# // (Your fft, ifft, mul_poly, sdp, int_sdp functions go here,
				# // copied exactly from your provided code)
				# 
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
	sw	$a3,fp.a3($fp)




				# void fft(CArray &x,unsigned int m)
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


	# ($t1) is n
	# ($t2) is n


				#     while (k > 1)
				#     {
top:	

	blez	$t1,whileend
	#         n = k;
	mov	$t2,$t1
	#         k >>= 1;
	srl	$t1,$t1,1
#         phiT = phiT * phiT;
	
	la	$v0,phiT  #output stored here
	la	$a0,phiT
	la	$a1,phiT
	
	addi	$sp,-4
	sw	$ra,($sp)

	jal	complex.mul

# 	s.d	$v0,phiT	# this si the result of phit * phit
	
	lw	$ra,($sp)
	addi	$sp,4

	li	$a0,'\n
	syscall	$print_char
	la	$a0,firstph2
	syscall	$print_string
	l.d	$f12,phiT
	syscall	$print_double
	la	$a0,phiT
	addi	$a0,8
	l.d	$f12,($a0)
	syscall	$print_double
# 	li	$a0,'V
# 	syscall	$print_char
# 	l.d	$f12,phiT
# 	syscall	$print_double
# 	li	$a0,'E
# 	syscall	$print_char
# 	li	$a0,phiT
# 	addi	$a0,8
# 	l.d	$f12,($a0)
# 	
# 	syscall	$print_double



	#did this in data section#         T = 1.0L;
	li	$t9,0 #l =0				
tloop:				#         for (unsigned int l = 0; l < k; l++)
	
	bgt	$t9,$t1,tloopend
	
	
				#         {floop
				#             for (unsigned int a = l; a < N; a += n)

	mov	$t8,$t9	#a = l
sloop:	bgt	$t8,$t0,sloopend
	beq	$t8,$t0,sloopend

				#             {sloop
				#                 unsigned int b = a + k;
	add	$t3,$t8,$t1
				#                 Complex t = x[a] - x[b];
	la	$t7,Data #array
# 	mov	$s0,$t8
	li	$s1,16
	mul	$s0,$t8,$s1
# 	mflo	$s0

	add	$a0,$t7,$s0 #x[a]
	
# 	mov	$s0,$t3	#b

	mul	$s0,$t3,$s1	# multily b by 16

# 	mflo	$s0
	add	$a1,$t7,$s0

	addi	$sp,-4
	sw	$ra,($sp)

	la	$v0,t	#need to know the address of the output
	
	jal	complex.sub #cahnged from mul
	
	lw	$ra,($sp)
	addi	$sp,4
	la	$s3,t
	l.d	$f12,t
	la	$a0,compsub
	syscall	$print_string
	syscall	$print_double


# 	sw	$v0,t	# this holds complex t
				#                 x[a] += x[b];
	mov	$s0,$t8	#t8 is a
	li	$s1,16
	mul	$s0,$s0,$s1 #byte index a
# 	mflo	$s0

	add	$a0,$t7,$s0 #x[a]
	mov	$v0,$a0	#fixes


	#loading xb

	mov	$s0,$t3	#b
	mul	$s0,$s0,$s1	# multily b by 16
# 	mflo	$s0 forgot how mul works
	add	$a1,$t7,$s0
	addi	$sp,-4
	sw	$ra,($sp)
	jal	complex.add
	lw	$ra,($sp)
	addi	$sp,4
	

				#                 x[b] = t * T;
	mov	$s0,$t3	#b
	mul	$s0,$s0,$s1	# multily b by 16
# 	mflo	$s0	# corrected indice
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

# 
# 	li	$a0,'S
# 	syscall	$print_char
# 	l.d	$f12,T
# 	syscall	$print_double


	j	tloop			#         }floop

tloopend:
	j	top

#end of while lop

				#     }while
whileend:
				#     // Decimate
				#     //    unsigned int m = (unsigned int)log2(N);

			
				#     
	li	$t8,0 #a=0
				#{
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

#     	andi    $t9,$t3,0xffff0000    # Extract upper 16 bits of b
#     	srl     $t9,$t9,16            # Shift upper 16 bits to lower 16 bits
#     	andi    $s0,$t3,0x0000ffff    # Extract lower 16 bits of b
#     	sll     $s0,$s0,16            # Shift lower 16 bits to upper 16 bits
#     	or      $t3,$t9,$s0           # Combine the shifted halves into b ($t3)

	lw	$v1,m
	neg	$v1,$v1
	addi	$s1,$v1,32


	srl	$t3,$t9,$s1

	addi	$t8,1


# bga:				#         if (b > a)
				#         {
	blt	$t3,$t8,2f

	
1:				#             //            Complex t = x[a];
# 	la	$t7,Data
	li	$s7,16
	mul	$s4,$s7,$t8
# 	mflo	$s7
	add	$s4,$t7,$s4

	l.d	$f0,($s4)
	s.d	$f0,t
	l.d	$f2,t
				#             //            x[a] = x[b];

	li	$s7,16
# 	add	$s7,$s7,$t3 #S7 IS A PROPER INDEX
	
	

	mul	$s7,$s7,$t3
# 	mflo	$s7
	add	$s5,$t7,$s7	#s5 is x[b]


	l.d	$f0,($s5)
	s.d	$f0,($s4)
	
# 	s.d	$s5,($s4)
# 	s.d	$f0,

	mov.d	$f12,$f0

	syscall	$print_double

				#             //            x[b] = t;
	l.d	$f0,t
	s.d	$f0,($s5)
	
	
swap:				#             swap(x[a],x[b]);
	#loading x[b]
	li	$s7,16
	mul	$s7,$s7,$t3
	
	add	$s4,$t7,$s7	#s4 is x[b]

	#loading x[a]
	li	$s7,16
	mul	$s7,$s7,$t8
	add	$s5,$t7,$s7	#s5 is x[a]
	
	#loading x[a] and x[b] into the fpu 
	l.d	$f2,($s4)
	l.d	$f0,($s5)

	#reversing the storage loactions from fpu
	s.d	$f0,($s4)		#completes swap
	s.d	$f2,($s5)

				#         }
2:
	

	j	Decimate	

FinishDecimate:	
		#     }
				#     //// Normalize (This section make it not working correctly)
				#     Complex f = 1.0 / N;
				#     for (unsigned int i = 0; i < N; i++)
				#         x[i] *= f;
				# }
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

#s0 contains file handle, a1 contains buffer, a2 length to be read





#get a phasor input 
# gtive it a magniatude and angle convert that to complex 

#write those routines to complex from phasor and than form phasor to complex

# two routines one is polar ot rectangular
# other is rectangular to polar 
#polar being the phasor can also call it phasor 

#get the source of the pynum FFT

	.code

main:

# 	la	$s0,file1
# 	add	$a0,$s0,file.filename
	

	la	$a0,file.name
	addi	$a1,_O_RDONLY
# 	li	$a2,0

	mov	$s0,$v0
	
	
# 	syscall	$open
# 	jal	file.readfile








# 	jal	readfile
	#thing I need to do reading command 























	

	jal	complex.Cooley_Tukey_FFT
# 	
	li	$a0,'\n
	syscall	$print_char

	li	$a0,'\n
	syscall	$print_char

	li	$a0,'\n
	syscall	$print_char

	li	$v0,0
	li	$t0,8
	la	$a0,Data

1:
	beq	$v0,$t0,end
	l.d	$f12,($a0)
	syscall	$print_double
	mov	$t2,$a0
	li	$a0,'\n
	syscall	$print_char
	mov	$a0,$t2
	addi	$a0,16
	addi	$v0,1
	j	1b

end:












#                             ASCII Table                                       
#    0 1 2 3 4 5 6 7 8 9 a b c d e f     0 1 2 3 4 5 6 7 8 9 a b c d e f        
#   ╔═╤═╤═╤═╤═╤═╤═╤═╤═╤═╤═╤═╤═╤═╤═╤═╗   ╔═╤═╤═╤═╤═╤═╤═╤═╤═╤═╤═╤═╤═╤═╤═╤═╗       
#  0║ │☺│☻│♥│♦│♣│♠│ control codes │☼║  8║Ç│ü│é│â│ä│à│å│ç│ê│ë│è│ï│î│ì│Ä│Å║       
#   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢       
#  1║►│◄│↕│‼│¶│§│▬│↨│↑│↓│→│←│∟│↔│▲│▼║  9║É│æ│Æ│ô│ö│ò│û│ù│ÿ│Ö│Ü│¢│£│¥│₧│ƒ║       
#   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢       
#  2║ │!│"│#│$│%│&│'│(│)│*│+│,│-│.│/║  a║á│í│ó│ú│ñ│Ñ│ª│º│¿│⌐│¬│½│¼│¡│«│»║       
#   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢       
#  3║0│1│2│3│4│5│6│7│8│9│:│;│<│=│>│?║  b║░│▒│▓│││┤│╡│╢│╖│╕│╣│║│╗│╝│╜│╛│┐║       
#   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢       
#  4║@│A│B│C│D│E│F│G│H│I│J│K│L│M│N│O║  c║└│┴│┬│├│─│┼│╞│╟│╚│╔│╩│╦│╠│═│╬│╧║       
#   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢       
#  5║P│Q│R│S│T│U│V│W│X│Y│Z│[│\│]│^│_║  d║╨│╤│╥│╙│╘│╒│╓│╫│╪│┘│┌│█│▄│▌│▐│▀║       
#   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢       
#  6║`│a│b│c│d│e│f│g│h│i│j│k│l│m│n│o║  e║α│β│Γ│π│Σ│σ│μ│τ│Φ│Θ│Ω│δ│∞│φ│ε│∩║       
#   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢   ╟─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─┼─╢       
#  7║p│q│r│s│t│u│v│w│x│y│z│{│|│}│~│⌂║  f║≡│±│≥│≤│⌠│⌡│÷│≈│°│∙│·│√│ⁿ│²│■│ ║       
#   ╚═╧═╧═╧═╧═╧═╧═╧═╧═╧═╧═╧═╧═╧═╧═╧═╝   ╚═╧═╧═╧═╧═╧═╧═╧═╧═╧═╧═╧═╧═╧═╧═╧═╝       
# 07 Bell       \a      0B Up Line      \v      FF Forward space     \255       
# 08 Backspace  \b      0C Clear Screen \f                                      
# 09 Tab        \t      0D Return       \r                                      
# 0A New Line   \n      0E Down Line    \14                                     
# Do not attempt to include characters less than 0x20 in source code.           
# You may paste this entire screen into source for reference, omitting 0x1a.    