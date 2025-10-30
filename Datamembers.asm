	.data
PHI:	.double	1.0,0.0			# 360  	N=0
	.double	-1.0,0.0		# -180 	N=1
	.double	0.0,-1.0		# -90 	N=2
	.double	0.7071067811865476,-0.7071067811865475 	#-45 	N=3
	.double	0.9238795325112867,-0.3826834323650898	#-22.5 	N=4
	.double	0.9807852804032304,-0.19509032201612825 #-11.25 
	.double	0.9951847266721969,-0.0980171403295606
	.double	0.9987954562051724,-0.04906767432741801
	.double	0.9996988186962042,-0.02454122852291229
	.double	0.9999247018391445,-0.01227153828571993
	.double	0.9999811752826011,-6.135884649154475e-3
	.double	0.9999952938095762,-3.067956762965976e-3
	.double	0.9999988234517019,-1.5339801862847655e-3
	.double	0.9999997058628822,-7.669903187427044e-4
	.double	0.9999999264657179,-3.8349518757139553e-4
	.double	0.9999999816164293,-1.9174759731070328e-4
	.double	0.9999999954041073,-9.587379909597734e-5
	.double 0.9999999988510269,-4.793689960306688e-5
	.double	0.9999999997127567,-2.3968449808418217e-5
	.double	0.9999999999281892,-1.1984224905069705e-5
	.double	0.9999999999820472,-5.992112452642428e-6


Rounding_Factor:	.double	100000	#number of zeroes increases your digits of accuracy






NormalizationRange:	.double	1e-12


	#Debug Strings I use this to prefix values I need to view in console
realprint:	.asciiz	"This is the Real component "
imagprint:	.asciiz	"imaginary component  "
firstphit:	.asciiz	"We Set the First PhIT  "
firstph2:	.asciiz	"This is the real and imagine of phit^2:  "
compadd:	.asciiz	"Result of a complex addition  "
compsub:	.asciiz "Result of a complex subtraction  "
tandt:		.asciiz	"x[b] = t * T = "

nextphit:	.asciiz	"T *= phiT  "
	.align	8
	
Data:		.space	2000

	.align	8

ButterFlyDebug:	.asciiz	"This is the Butter "


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
# FlexibleDataBuffer:	.space	3

	.align	8
	