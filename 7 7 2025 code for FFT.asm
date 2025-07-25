	.data

tempstore:	.double 0






complex: 	.struct
real:		.double	0.0
imaginary:	.double	0.0

PI:		.double	3.1415265358979323864233


testData:	.double	52:10

powerofTwo:	.double	5	
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
	s.d	$f0,complex.real($v0)
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
#complex:v0 complex::div(complex*arg1:a0,complex*arg2:a2)

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

	mul.d	$f4,$f16,$f16	#c�
	mul.d	$f8,$f18,$f18	#d�

	add.d	$f4,$f4,$f8	#c�+d�

	div.d	$f0,$f0,$f4	# whole real term

	div.d	$f2,$f2,$f4	# whole imaginary term

	s.d	$f0,complex.real($v0)
	s.d	$f2,complex.imaginary($v0)

	jr	$ra




Cooley_Tukey_FFT:
		

	li	$t0,32 		# N = size
	li	$t1,32		# k = N
	li	$t2,0		#n = 0


	l.d	$f4,PI
	l.d	$f6,32

	div.d	$f4,$f4,$f6	# thetaT = PI/ N

	cos.d	$f9,$f4
	neg.d	$f4,$f4	
	sin.d	$f8,$f4	#complex  sin complex theta T

	# f9 has complex (cos(theat t) and f8 has the imaginary component minus

	la	$a0,temp

	s.d	$f9,complex.real($a0)
	s.d	$f8,complex.imaginary($a0)

1:	
	
	mov	$t2,$t1	# n = k 
	srl	$t1,$t1,1  #  k >>=1
	mov	$a1,$a0	#  a1 = a0 so next operation can pass parameters to do mulitpley
	addi	$sp,-8	
	sw	$ra,($sp)
	jal	complex.mul
	lw	$ra,($sp)
	addi	$sp,8	# deallocate teh stack
	li	$t4,0	# l = 0 
2: 
	addi	$t4,1	# k++; outloop
3:	

	mov	$t5,$t4 # unsigned int a = l	
	addu	$t6,$t5,$t1	# unsigned int b = a + k;
	addi	$t5,1	 
	blt	$t5,$t0,3b  	# inner loop  for (unsigned int a = l; a < N; a += n)
	blt	$t4,$t1,2b 	#for (unsigned int l = 0; l < k; l++) outer loop
	jr	$ra




#get a phasor input 
# gtive it a magniatude and angle convert that to complex 

#write those routines to complex from phasor and than form phasor to complex

# two routines one is polar ot rectangular
# other is rectangular to polar 
#polar being the phasor can also call it phasor 

#get the source of the pynum FFT
main:





















#                             ASCII Table                                       
#    0 1 2 3 4 5 6 7 8 9 a b c d e f     0 1 2 3 4 5 6 7 8 9 a b c d e f        
#   �������������������������������ͻ   �������������������������������ͻ       
#  0� ������� control codes ��  8���������������������������������       
#   �������������������������������Ķ   �������������������������������Ķ       
#  1�����������������  9���������������������������������       
#   �������������������������������Ķ   �������������������������������Ķ       
#  2� �!�"�#�$�%�&�'�(�)�*�+�,�-�.�/�  a���������������������������������       
#   �������������������������������Ķ   �������������������������������Ķ       
#  3�0�1�2�3�4�5�6�7�8�9�:�;�<�=�>�?�  b���������������������������������       
#   �������������������������������Ķ   �������������������������������Ķ       
#  4�@�A�B�C�D�E�F�G�H�I�J�K�L�M�N�O�  c�����³óĳųƳǳȳɳʳ˳̳ͳγϺ       
#   �������������������������������Ķ   �������������������������������Ķ       
#  5�P�Q�R�S�T�U�V�W�X�Y�Z�[�\�]�^�_�  d�гѳҳӳԳճֳ׳سٳڳ۳ܳݳ޳ߺ       
#   �������������������������������Ķ   �������������������������������Ķ       
#  6�`�a�b�c�d�e�f�g�h�i�j�k�l�m�n�o�  e������������������       
#   �������������������������������Ķ   �������������������������������Ķ       
#  7�p�q�r�s�t�u�v�w�x�y�z�{�|�}�~��  f��������������������������� �       
#   �������������������������������ͼ   �������������������������������ͼ       
# 07 Bell       \a      0B Up Line      \v      FF Forward space     \255       
# 08 Backspace  \b      0C Clear Screen \f                                      
# 09 Tab        \t      0D Return       \r                                      
# 0A New Line   \n      0E Down Line    \14                                     
# Do not attempt to include characters less than 0x20 in source code.           
# You may paste this entire screen into source for reference, omitting 0x1a.     

# chantge whole thread use uncidoe buffer isntead of ascii 
# and have to trnslate the ascii thats is sent to into unicode at the point of the
# syscall