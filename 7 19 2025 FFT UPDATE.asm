	.globl	main	
	.data

realprint:	.asciiz	"This is the Real component"
PI:	.double	3.141592653589793238642
T:	.double	1
	.double	0
Nfloat:	.double	8
N:	.word	8
ThetaT:	.double	0
phiT:	.double	0
	.double	0

Data:	.double	1,0,2,0,4,0,1,0,1,0,1,0,1,0,1,0
t:	.double	0
m:	.word	3

complex: 	.struct
real:		.double	0.0
imaginary:	.double	0.0
powerofTwo:	.double	2	
	
	.code
complex.add:
# complex:v0 complex::add(complex*arg1:a0,complex*arg2:a1)
	l.d	$f12,complex.real($a0)
	l.d	$f14,complex.imaginary($a0)
	l.d	$f16,complex.real($a1)
	l.d	$f18,complex.imaginary($a1)
	add.d	$f0,$f12,$f16
	add.d	$f2,$f14,$f18
	s.d	$f0,complex.real($v0)
	s.d	$f2,complex.imaginary($v0)
	jr	$ra

complex.mul:
#complex:v0 complex::mul(complex * arg1:$a0,complex*arg2:a1)
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
	la	$a0,realprint
	syscall	$print_string
	s.d	$f0,complex.real($v0)
	mov	$a0,$v0
	syscall	$print_double
	li	$a0,'\n
	syscall	$print_char
	s.d	$f2,complex.imaginary($v0)

	jr	$ra

complex.sub:
# complex:v0 complex::sub(complex*arg1:a0,complex*arg2:a1)
	l.d	$f12,complex.real($a0)
	l.d	$f14,complex.imaginary($a0)

	l.d	$f16,complex.real($a1)
	l.d	$f18,complex.imaginary($a1)
	sub.d	$f0,$f12,$f16
	sub.d	$f2,$f14,$f18
	s.d	$f0,complex.real($v0)
	s.d	$f2,complex.imaginary($v0)
	jr	$ra

complex.div:
#complex:v0 complex::div(complex*arg1:a0,complex*arg2:a1)

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

	mul.d	$f4,$f16,$f16	#cý
	mul.d	$f8,$f18,$f18	#dý

	add.d	$f4,$f4,$f8	#cý+dý

	div.d	$f0,$f0,$f4	# whole real term

	div.d	$f2,$f2,$f4	# whole imaginary term

	s.d	$f0,complex.real($v0)
	s.d	$f2,complex.imaginary($v0)

	jr	$ra







				# // (Your fft, ifft, mul_poly, sdp, int_sdp functions go here,
				# // copied exactly from your provided code)
				# 
				# // Cooley-Tukey FFT (in-place, breadth-first, decimation-in-frequency)
				# // Better optimized but less intuitive
				# // !!! Warning : in some cases this code make result different from not optimased version above (need to fix bug)
				# // The bug is now fixed @2017/05/30

#s7 is the this pointer
complex.Cooley_Tukey_FFT:		# void fft(CArray &x,unsigned int m)
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

	#t9 is now phiT address
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


	#did this in data section#         T = 1.0L;
	li	$t9,0 #l =0				
tloop:				#         for (unsigned int l = 0; l < k; l++)
	
	bgt	$t9,$t1,tloopend
	
	
				#         {floop
				#             for (unsigned int a = l; a < N; a += n)

	mov	$t8,$t9	#a = l
sloop:	bgt	$t8,$t0,sloopend

				#             {sloop
				#                 unsigned int b = a + k;
	add	$t3,$t8,$t1
				#                 Complex t = x[a] - x[b];
	la	$t7,Data #array
	mov	$s0,$t8
	li	$s1,16
	mul	$s0,$s0,$s1
	mflo	$s0

	add	$a0,$t7,$s0 #x[a]
	
	mov	$s0,$t3	#b

	mul	$s0,$s0,$s1	# multily b by 16

	mflo	$s0
	add	$a1,$t7,$s0

	addi	$sp,-4
	sw	$ra,($sp)

	la	$v0,t	#need to know the address of the output
	
	jal	complex.sub #cahnged from mul
	
	lw	$ra,($sp)
	addi	$sp,4


# 	sw	$v0,t	# this holds complex t
				#                 x[a] += x[b];
	mov	$s0,$t8	#t8 is a
	li	$s1,16
	mul	$s0,$s0,$s1 #byte index a
# 	mflo	$s0

	add	$a0,$t7,$s0 #x[a]


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


	j	top

tloopend:#end of while lop

				#     }while
whileend:
				#     // Decimate
				#     //    unsigned int m = (unsigned int)log2(N);

			
				#     
	li	$t8,0 #a=0
				#{
	lw	$s7,N
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

	lw	$s1,m
	neg	$s1,$s1
	addi	$s1,$s1,32


	srl	$t3,$t9,$s1

	addi	$t8,1


# bga:				#         if (b > a)
				#         {
	blt	$t3,$t8,2f

	
1:				#             //            Complex t = x[a];
	la	$t7,Data
	li	$s7,16
	mul	$s4,$s7,$t8
# 	mflo	$s7
	add	$s4,$t7,$s7

	
	s.d	$s4,t
				#             //            x[a] = x[b];

	li	$s7,16
# 	add	$s7,$s7,$t3 #S7 IS A PROPER INDEX
	
	

	mul	$s7,$s7,$t3
# 	mflo	$s7
	add	$s5,$t7,$s7	#s5 is x[b]

	

	l.d	$f0,($s5)

	s.d	$s5,($s4)

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
	jr	$ra




	.data

complestruct:	.space	complex



val1:	.double	1,0
val2:	.double	2,0	
val3:	.double	4,0	
val4:	.double	2,0	




#get a phasor input 
# gtive it a magniatude and angle convert that to complex 

#write those routines to complex from phasor and than form phasor to complex

# two routines one is polar ot rectangular
# other is rectangular to polar 
#polar being the phasor can also call it phasor 

#get the source of the pynum FFT

	.code

main:

	la	$a0,val1
	

	jal	complex.Cooley_Tukey_FFT
	
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
#   ÉÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍ»   ÉÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍÑÍ»       
#  0º ³³³³³³³ control codes ³º  8º€³³‚³ƒ³„³…³†³‡³ˆ³‰³Š³‹³Œ³³Ž³º       
#   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶       
#  1º³³³³³³³³³³³³³³³º  9º³‘³’³“³”³•³–³—³˜³™³š³›³œ³³ž³Ÿº       
#   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶       
#  2º ³!³"³#³$³%³&³'³(³)³*³+³,³-³.³/º  aº ³¡³¢³£³¤³¥³¦³§³¨³©³ª³«³¬³­³®³¯º       
#   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶       
#  3º0³1³2³3³4³5³6³7³8³9³:³;³<³=³>³?º  bº°³±³²³³³´³µ³¶³·³¸³¹³º³»³¼³½³¾³¿º       
#   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶       
#  4º@³A³B³C³D³E³F³G³H³I³J³K³L³M³N³Oº  cºÀ³Á³Â³Ã³Ä³Å³Æ³Ç³È³É³Ê³Ë³Ì³Í³Î³Ïº       
#   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶       
#  5ºP³Q³R³S³T³U³V³W³X³Y³Z³[³\³]³^³_º  dºÐ³Ñ³Ò³Ó³Ô³Õ³Ö³×³Ø³Ù³Ú³Û³Ü³Ý³Þ³ßº       
#   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶       
#  6º`³a³b³c³d³e³f³g³h³i³j³k³l³m³n³oº  eºà³á³â³ã³ä³å³æ³ç³è³é³ê³ë³ì³í³î³ïº       
#   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶   ÇÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄÅÄ¶       
#  7ºp³q³r³s³t³u³v³w³x³y³z³{³|³}³~³º  fºð³ñ³ò³ó³ô³õ³ö³÷³ø³ù³ú³û³ü³ý³þ³ º       
#   ÈÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍ¼   ÈÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍÏÍ¼       
# 07 Bell       \a      0B Up Line      \v      FF Forward space     \255       
# 08 Backspace  \b      0C Clear Screen \f                                      
# 09 Tab        \t      0D Return       \r                                      
# 0A New Line   \n      0E Down Line    \14                                     
# Do not attempt to include characters less than 0x20 in source code.           
# You may paste this entire screen into source for reference, omitting 0x1a.     

# chantge whole thread use uncidoe buffer isntead of ascii 
# and have to trnslate the ascii thats is sent to into unicode at the point of the
# syscall















# # push complex array on the stack before entering this fucniton assumihng
# 
# #each complex is 128 bit number [ 8 bytes Real] [8 bytes imaginary]
# # void Cooley_Tueky_FFT ( Complex * array :a1 ,  )
# Cooley_Tukey_FFT:
# 		
# 
# 	li	$t0,32 		# N = size
# 	li	$t1,32		# k = N
# 	li	$t2,0		#n = 0
# 
# 
# 	l.d	$f4,PI
# 	l.d	$f6,32
# 
# 	div.d	$f4,$f4,$f6	# thetaT = PI/ N
# 
# 	cos.d	$f9,$f4
# 	neg.d	$f4,$f4	
# 	sin.d	$f8,$f4	     	#complex  sin complex theta T
# 
# 	# f9 has complex (cos(theat t) and f8 has the imaginary component minus
# 
# 
# 	s.d	$f9,complex.real($a0)
# 	s.d	$f8,complex.imaginary($a0)
# 
# 1:	
# 	
# 	mov	$t2,$t1	   # n = k 
# 	srl	$t1,$t1,1  #  k >>=1
# 	mov	$a1,$a0	   #  a1 = a0 so next operation can pass parameters to do mulitpley
# 	addi	$sp,-8	
# 	sw	$ra,($sp)
# 	jal	complex.mul
# 	lw	$ra,($sp)
# 	addi	$sp,8	         # deallocate the stack
# 	li	$t4,0	         # l = 0 
#  
# 4:	blt	$t4,$t1,2f 	#for (unsigned int l = 0; l < k; l++) outer loop
# 
# 	addi	$t4,1	        # k++; outloop
# 
# 
# 
# 	mov	$t5,$t4         # unsigned int a = l	
# 
# 	blt	$t5,$t0,3f  	# inner loop  for (unsigned int a = l; a < N; a += n)
# 
# 	
# 	#	t5 is a , t1 is k , t6 is b
# 	addu	$t6,$t5,$t1	# unsigned int b = a + k;
# 
# 	addi	$sp,-8
# 
# 	sw	$a0,($sp)
# 	
# 	mov	$a1,$a0
# 
# 	addi	$a1,16	# this is x[b]
# 	
# 	addi	$sp,-8	
# 	sw	$ra,($sp)
# 	
# 	jal	complex.sub		# Complex t = x[a] - x[b]
# 	mov	$t8,$v0
# 	jal	complex.add		#             x[a] += x[b];
# 
# 	mov	$t9,$v0			#  t9 containst the x[a]
# 
# 	la	$a1,T
# 	move	$a0,$t8			# trying to put t = x[a] -x[b]  to a0
# 	# finally we can do multicplation
# 	jal	complex.mul			#             x[b] = t * T;
# 3:	
# 
# #	T *=phiT
# 
# 	j	4b	
# 2:	 
# 	jr	$ra
# 