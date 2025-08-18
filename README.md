# FFT implementation in Mipsym Done by Gurjot Singh under advisement of Doctor Roger E Doering
The FFT algorithm decomposes a signal transform it from time domain to the frequency domain allowing for further analysis. Thereby allowing for 
| Useful Processes: | 
|---:|
| Noise Reduction:  | 
| Filtering:        | 
| Compression:      | 

The Algorithm implemented is implemented in a Mipsym(Trademark of Dr. Roger Doering Phd) an Mips assembly language simulator thereby forcing the use of custom conversion routines to do file I/O on real Doubles

#  How to Use
  ### First Install MipSym from https://mipsym.com
  ### Install this repo into a suitable directory
  ### Write your sample fft data in the Text file labled "Data.txt"
  ### call the function complex.Cooley_Tukey_FFT
