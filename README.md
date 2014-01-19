characterness
=============

This software package contains the scene text detection algorithm described in the the paper: "Characterness: An Indicator of Text in the Wild", IEEE Transactions on Image Processing, 2014. 

This software is provided for research purposes. Please cite our paper if you use the package. The code is tested on Matlab 2013a, Ubuntu 13.10. 

Installation
-------------

Before you use this software, please download the vlfeat toolbox from 
http://www.vlfeat.org/ and add it to the current Matlab search path. 

Getting started
---------------

Please run the demo.m file to see how the algorithm works. 

Note that in the package, we load pretained distributions of the three cues on characters and non-characters (See data/CueNegativeDistribution_229.mat and data/CuePositiveDistribution_229.mat).The distributions are learned from the ICDAR 2013 Robust Reading Competition (Challenge 2) training set. 


License
-------
Copyright (c) 2014 Yao Li, Wenjing Jia, Chunhua Shen, Anton van den Hengel

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


Questions and Comments
----------------------

If you have any feedback, please email to 
yao.li01@adelaide.edu.au, chunhua.shen@adelaide.edu.au.

