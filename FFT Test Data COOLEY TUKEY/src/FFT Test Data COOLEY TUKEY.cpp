

//Original C++ Code



#include <complex>
#include <fstream>
#include <iostream>
#include <valarray>
#include <vector> // Not strictly needed if only using valarray
#include <cmath>  // For log2
#include <iomanip> // For std::fixed and std::setprecision

using namespace std;

const long double PI = 4*atan(1.0L);

typedef complex<double> Complex;
typedef valarray<Complex> CArray;

void printCarray(CArray &datatoprint){
	int k = datatoprint.size();
for(int i =0 ; i < k ; i++){
	if(abs(datatoprint[i].real()) > (10e-8))
		cout <<setprecision(12)<< datatoprint[i].real();
	else
		cout << "0";
	if(datatoprint[i].imag() >= 0)

		cout << '+';

	if(abs(datatoprint[i].imag()) > 10e-8){
		cout << setprecision(12)<< datatoprint[i].imag();

	}
	else{
		if(datatoprint[i].imag()<0)
			cout << '-';
			cout << "0";}
	cout << "j \n";



}
}



// (Your fft, ifft, mul_poly, sdp, int_sdp functions go here,
// copied exactly from your provided code)

// Cooley-Tukey FFT (in-place, breadth-first, decimation-in-frequency)
// Better optimized but less intuitive
// !!! Warning : in some cases this code make result different from not optimased version above (need to fix bug)
// The bug is now fixed @2017/05/30
void fft(CArray &x,unsigned int m)
{
    // DFT
    unsigned int N = x.size(), k = N, n;
    double thetaT = PI / N; // division done in Long double output into double
    Complex phiT = Complex(cos(thetaT), -sin(thetaT)), T;
    while (k > 1)
    {
        n = k;
        k >>= 1;
        phiT = phiT * phiT;
        T = 1.0L;
        for (unsigned int l = 0; l < k; l++)
        {
            for (unsigned int a = l; a < N; a += n)
            {
                unsigned int b = a + k;
                Complex t = x[a] - x[b];
                x[a] += x[b];
                x[b] = t * T;
            }
            T *= phiT;
        }
    }
    // Decimate
//    unsigned int m = (unsigned int)log2(N);
    for (unsigned int a = 0; a < N; a++)
    {
        unsigned int b = a;
        // Reverse bits
        b = (((b & 0xaaaaaaaa) >> 1) | ((b & 0x55555555) << 1));
        b = (((b & 0xcccccccc) >> 2) | ((b & 0x33333333) << 2));
        b = (((b & 0xf0f0f0f0) >> 4) | ((b & 0x0f0f0f0f) << 4));
        b = (((b & 0xff00ff00) >> 8) | ((b & 0x00ff00ff) << 8));
        b = ((b >> 16) | (b << 16)) >> (32 - m);
        if (b > a)
        {
//            Complex t = x[a];
//            x[a] = x[b];
//            x[b] = t;
        	swap(x[a],x[b]);
        }
    }
    //// Normalize (This section make it not working correctly)
    Complex f = 1.0 / N;
    for (unsigned int i = 0; i < N; i++)
        x[i] *= f;
}

// inverse fft (in-place)
void ifft(CArray& x,unsigned int m)
{
    // conjugate the complex numbers
    x = x.apply(std::conj);

    // forward fft
    fft(x,m);

    // conjugate the complex numbers again
    x = x.apply(std::conj);

    // scale the numbers
//    x /= x.size();

    x*=1<<m;
}





int main(){
    // It's better to open the ifstream inside main
    ifstream readfile("src/32DataSetFFT");
    if (!readfile.is_open()) {
        cerr << "Error: Could not open MyFFTTestData. Check path: src/MyFFTTestData" << endl;
        return 1; // Indicate error
    }

    // Determine the number of data points for proper CArray initialization
    int power_of_two = 0,data_size;

    readfile >> power_of_two;

    data_size=1<<power_of_two;
    if (data_size == 0) {
        cerr << "Error: MyFFTTestData is empty." << endl;
        return 1;
    }


    // Declare a single CArray to hold all your data


    Complex firstread[data_size];
    // Read the real values into the CArray
    for (int i = 0; i < data_size; ++i) {
        double real_val;
        if (readfile >> real_val) {
        	firstread[i] = Complex(real_val, 0.0); // Store as Complex with 0 imaginary
        } else {
            cerr << "Error reading data from file at line " << i + 1 << endl;
            return 1;
        }
    }
    CArray myData(firstread,data_size);
    readfile.close(); // Close the file



    // --- Output Initial Data ---

    // --- Perform FFT ---
    fft(myData,power_of_two); // Pass the single CArray to the fft function

    // --- Output FFT Result ---


    // You can keep your mul_poly and sdp tests if you want, but I've commented
    // out the original commented-out block as it was already commented.
    // The current focus is on FFT of file data.





    printCarray(myData);

cout << endl;
    ifft(myData,power_of_two);
    printCarray(myData);

    return 0;
}

















































































