function [brightImg darkImg] = gbmser(rgbImg)
% This function is the implementation of 'Gradient Based Maximally Stable
% Extremal Region' algorithm 
% Input: rgbImg - color image in the rgb form
% Output: brightImg - image with bright regions
%         darkImg - image with dark regions

hsiImg = rgb2hsi(rgbImg); % change the image into hsi space
grayImg = hsiImg(:,:,3); % extract the intensity part
%grayImg = im2uint8(grayImg);
guidedImg=guidedfilter(im2double(grayImg),im2double(grayImg),1,0.005);
grayImg = im2uint8(guidedImg);
angle = 360;    bins = 8;
[ valueMap angleMap indexMap ] = hog_original(grayImg, angle, bins); % compute gradient via HOG
 valueMapT = abs(valueMap);
valueMapT = 255*(valueMapT-min(min(valueMapT)))/(max(max(valueMapT))-min(min(valueMapT)));
 valueMapT = uint8(valueMapT);
 brightGrayImg = grayImg - 0.5*valueMapT;%bright text 
 darkGrayImg   = grayImg + 0.5*valueMapT;%dark text
% brightGrayImg = grayImg - valueMapT;%bright text 
% darkGrayImg   = grayImg + valueMapT;

% MSER algorithm(0.00005:0.1)
[brightImg meanimg nrs] = ICG_MSERDetection(brightGrayImg,10, 0.00002, 0.1, 1, 10);
[darkImg meanimg nrs] = ICG_MSERDetection(darkGrayImg,10, 0.00002, 0.1, 0, 10);
% [brightImg meanimg nrs] = ICG_MSERDetection(grayImg,10, 0.00002, 0.1, 1, 10);
% [darkImg meanimg nrs] = ICG_MSERDetection(grayImg,10, 0.00002, 0.1, 0, 10);%10
end