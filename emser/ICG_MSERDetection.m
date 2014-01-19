function [retimg meanimg nrs] = ICG_MSERDetection(img, stab, minsize, maxsize, plus, meanthres, maxvariation, mindiversity)
%   [retimg meanimg nrs] = ICG_MSERDetection(img, [stab], [minsize], [maxsize], [meanthres],[maxvariation],[mindiversity])
%   ICG_MSERDetection detects the set of Maximally Stable Extremal Regions
%   within the specified image and returns them in a binary image
%   MSER+ detects dark regions with bright boundary
%   MSER- detects bright regions with dark boundary
%
%   Parameter:
%   img ... The image to be analyzed
%   stab (optional) ... The MSER stability
%			DEFAULT: 2
%   minsize (optional) ... The minimum size of the region, in percent 
%			   DEFAULT: 0.001
%   maxsize (optional) ... The maximum size of the region, in percent 
%			   DEFAULT: 0.5
%   plus (optional) ... What should be included in binary result
%                       0 ... Only MSER+ (DEFAULT) (dark on bright)
%                       1 ... Only MSER- (bright on dark)
%                       2 ... Both MSER+ and MSER- 
%   
%
%   Return value: 
%   retimg...Returns the detected MSERs in a binary image
%   meanimg ... The mean image contains the mean grayvalue of the regions
%   nrs ... The number of detected MSERs
%
%   Example
%   -------
%   [retimg meanimg mserp mserm nr] = ICG_MSERDetection(img,10,0.001,0.1,0,100)
%
%   IMPORTANT !!!!!!!!!!!!!!!
%   THIS FUNCTION REQUIRES THE VL-FEAT TOOLBOX (see http://www.vlfeat.org)
%  
%   *****************************************
%   LAST VERSION 15.6.2007
%	Copyright by Michael Donoser
%	Institute for Computer Graphics and Vison
%	Graz University of Technology
%   *****************************************


    if ~exist('plus','var'), plus = 2; end
    if ~exist('stab','var'), stab = 10;end;
    if ~exist('minsize','var'), minsize = 0.01;end;
    if ~exist('maxsize','var'), maxsize = 0.5;end;
    if ~exist('maxvariation','var'), maxvariation = 0.2;end;
    if ~exist('mindiversity','var'), mindiversity = 0.5;end;
    if ~exist('meanthres','var'), meanthres = 0;end;  
    
    warning off all;
    
    % Change to greyscale image
    if length(size(img)) == 3
        img = rgb2gray(img);
    end
    
    retimg = zeros(size(img));
    meanimg = zeros(size(img));
    nr_plus = 0;
    nr_minus = 0;
    if (plus == 0) 
        R = vl_mser(img,'Delta',stab,'MinArea',minsize, ...
            'MaxArea',maxsize,'maxvariation',maxvariation,'mindiversity',mindiversity,...
            'BrightOnDark',0,'DarkOnBright',1);
        for x=R'
            inds = vl_erfill(img,x);
            mean_val = 255 - mean(mean(img(inds)));
            if (mean_val > meanthres)
                retimg(inds) = true;
                meanimg(inds) = mean_val;
            end
        end
        nr_plus = numel(R);
    elseif (plus == 1)
        R = vl_mser(img,'Delta',stab,'MinArea',minsize, ...
            'MaxArea',maxsize,'maxvariation',maxvariation,'mindiversity',mindiversity,...
            'BrightOnDark',1,'DarkOnBright',0);
        
        for x=R'
            inds = vl_erfill(img,x);
            mean_val = mean(mean(img(inds)));
            if (mean_val > meanthres)
                retimg(inds) = true;
                meanimg(inds) = mean_val;
            end
        end
        nr_minus = numel(R);
    elseif (plus == 2)
        R = vl_mser(img,'Delta',stab,'MinArea',minsize, ...
            'MaxArea',maxsize,'maxvariation',maxvariation,'mindiversity',mindiversity,...
            'BrightOnDark',1,'DarkOnBright',1);
        
        for x=R'
            inds = vl_erfill(img,x);
            if (x < 0)
                mean_val = mean(mean(img(inds)));
            else
                mean_val = 255 - mean(mean(img(inds)));
            end
            if (mean_val > meanthres)
                retimg(inds) = true;
                meanimg(inds) = mean_val;
            end
        end
        nr_minus = numel(R);
    end
    
    %label_msers = bwlabeln(retimg);
    %disp(['Num labels: ' num2str(max(label_msers(:)))]);
    %figure;imshow(label2rgb(label_msers));
    
    nrs = nr_plus + nr_minus;
    if (plus == 0)
        disp(['Number of detected regions: ', ...
            num2str(nr_plus), '(!)\',num2str(nr_minus) ...
            ' => ' num2str(nrs)]);
    elseif (plus == 1)
        disp(['Number of detected regions: ', ...
            num2str(nr_plus), '\',num2str(nr_minus) ...
            '(!) => ' num2str(nrs)]);
    else
        disp(['Number of detected regions: ', ...
            num2str(nr_plus), '(!)\',num2str(nr_minus) ...
            '(!) => ' num2str(nrs)]);
    end