complex: 	.struct
real:		.double	0.0
imaginary:	.double	0.0
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