## FFT-Cooley Tukey Implentation in Mips Simulator


### Resources

* Original Author of C++ Code Dr Chen from Harvard University https://gist.github.com/hsiuhsiu/a0c63f2555f5af7ba622d4e911a68898
*  J. F. JAMES book on Fourier AStudent’s Guide to Fourier Transforms with Applications in Physics and Engineering
*  Please support his book if possible I make no money from you clicking on the Amazon link and I am not paid by Mr. James for promoting his book. As well we have never met
*  https://www.amazon.com/Students-Guide-Fourier-Transforms-Applications/dp/0521176832
### Work Credit
Dr. Roger Doering without whose guidance this project wouldn't be possible and helped write the complex math operators +,-,divide and multiply and assisted in C++
I Gurjot Singh wrote the entire FFT algo translated the FFT Algorithm from the C++ code of Dr Chen 



#### Summary of the guidelines:

* One pull request per issue;
* Choose the right base branch;
* Include tests and documentation;
* Clean up "oops" commits before submitting;
* Follow the [coding style guide](https://github.com/opencv/opencv/wiki/Coding_Style_Guide).

### Additional Resources

* [Submit your OpenCV-based project](https://form.jotform.com/233105358823151) for inclusion in Community Friday on opencv.org
* [Subscribe to the OpenCV YouTube Channel](http://youtube.com/@opencvofficial) featuring OpenCV Live, an hour-long streaming show
* [Follow OpenCV on LinkedIn](http://linkedin.com/company/opencv/) for daily posts showing the state-of-the-art in computer vision & AI
* [Apply to be an OpenCV Volunteer](https://form.jotform.com/232745316792159) to help organize events and online campaigns as well as amplify them
* [Follow OpenCV on Mastodon](http://mastodon.social/@opencv) in the Fediverse
* [Follow OpenCV on Twitter](https://twitter.com/opencvlive)
* [OpenCV.ai](https://opencv.ai): Computer Vision and AI development services from the OpenCV team.

















# FFT implementation in Mipsym 
# Done by Gurjot Singh under advisement of Doctor Roger E Doering
# Important citation for writing the original C++ code that I translated to Dr. Yi-Hsiu Chen at Harvard University
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
