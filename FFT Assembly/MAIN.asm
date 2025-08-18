	


	
	.data
	
TtT:	.asciiz	"T *= phit"
SPACE:	.asciiz	"             "


Rounding_Factor:	.double	100000	#number of zeroes increases your digits of accuracy
NormalizationRange:	.double	1e-12

complexmulprint:	.asciiz	"Result of complex multiplication"

	#Debug Strings I use this to prefix values I need to view in console
realprint:		.asciiz	"This is the Real component "
imagprint:		.asciiz	"imaginary component  "

firstphit:		.asciiz	"We Set the First PhIT cos and sin  "
firstph2:		.asciiz	"This is the real and imagine of phit^2:  "



compadd:		.asciiz	"Result of a complex addition     "
compsub:		.asciiz "Result of a complex subtraction  "
tandt:			.asciiz	"x[b] = t * T = "
nextphit:	.asciiz	"T *= phiT  "



Data:		.word	0

	
ButterFlyDebug:	.asciiz	"  Output FFT DATA    "
		


PI:	.double	3.1415926535897931
# use atan 1 compe up with pi 
T:	.double	1
	.double	0

#i need to read file to get number of values which is 2^(first read byte of file)
#I need to sw into N and than convert into a float and store that in Nfloat


Nfloat:	.double	16
N:	.word	16


ThetaT:	.double	0
phiT:	.double	0
	.double	0
Datapointer:	.word	0
t:	.double	0,0
m:	.word	4

roundingfacttor:	.double	2e-12



	
	.include	"funoffsets.asm"

	.include	"comp2str.asm"


	.code
	.include	"printdata.asm"
	.include	"compops.asm"
	.include	"AlgoFFT.asm"
	.include	"fileio.asm"

	.data


	.code


main:	.globl	main
	jal	file.readfile

	
	li	$a0,'\n
	syscall	$print_char
	jal	printalldata

	
	jal	complex.Cooley_Tukey_FFT

	li	$a0,'\n
	syscall	$print_char
	jal	printalldata	
	jal	file.writeData
	

	jal	complex.IFFT
	syscall	$exit