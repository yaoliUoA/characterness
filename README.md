characterness
=============

This software package contains the scene text detection algorithm described in the the paper: 

## [Yao Li](https://cs.adelaide.edu.au/~yaoli/), [Wenjing Jia](http://cfsites1.uts.edu.au/research/strengths/inext/member-detail.cfm?StaffID=4857), [Chunhua Shen](http://cs.adelaide.edu.au/~chhshen/), [Anton van den Hengel](http://cs.adelaide.edu.au/~hengel/).**Characterness: An Indicator of Text in the Wild.** IEEE Transactions on Image Processing, 2014. [PDF](http://cs.adelaide.edu.au/~yaoli/wp-content/publications/tip14_characterness.pdf) | [Project page](http://cs.adelaide.edu.au/~yaoli/?page_id=111/) 


This software is provided for research purposes. Please cite our paper if you use the package. The code is tested on Matlab 2013a, Ubuntu 13.10. 

Abstract
--------

Text in an image provides vital information for interpreting its contents, and text in a scene can aid a variety of tasks from navigation to obstacle avoidance and odometry. Despite its value, however, detecting general text in images remains a challenging research problem. Motivated by the need to consider the widely varying forms of natural text, we propose a bottom-up approach to the problem which reflects the 'characterness' of an image region. In this sense our approach mirrors the move from saliency detection methods to measures of 'objectness' . In order to measure the characterness we develop three novel cues that are tailored for character detection, and a Bayesian method for their integration. Because text is made up of sets of characters, we the design a Markov random field (MRF) model so as to exploit the inherent dependencies between characters. We experimentally demonstrate the effectiveness of our characterness cues as well as the advantage of Bayesian multi-cue integration. The proposed text detector outperforms state-of-the-art methods on a few benchmark scene text detection datasets. We also show that our measurement of 'characterness' is superior than state-of-the-art saliency detection models when applied to the same task.

Installation
-------------

Before you use this software, please download the [vlfeat toolbox](http://www.vlfeat.org/) and add it to the current Matlab search path. 

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

