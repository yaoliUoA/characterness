clear all,close all;
addpath(genpath(pwd));
addpath(genpath('/home/yao/Vision/lib/vlfeat-0.9.17')); %change the path to vlfeat toolbox on your computer
assert((exist('vl_setup.m','file')==2),...
    'You need to download the vlfeat toolbox from http://www.vlfeat.org/ and add it to the matlab search path');
vl_setup;
%% load distribution
% load('data/CueNegativeDistribution_229.mat');
% load('data/CuePositiveDistribution_229.mat');
DrawDistribution;
x = linspace(0,2,51);%SWV
distributionSWV = zeros(2,length(x));
distributionSWV(1,:) = histc(CueSWVimP,x)/length(CueSWVimP);
distributionSWV(2,:) = histc(CueSWVimN,x)/length(CueSWVimN);
index = distributionSWV==0;
distributionSWV(index)=1e-5;
x2 = linspace(0,35,51);%PD
distributionPD = zeros(2,length(x2));
distributionPD(1,:) = histc(CuePDimP,x2)/length(CuePDimP);
distributionPD(2,:) = histc(CuePDimN,x2)/length(CuePDimN);
index = distributionPD==0;
distributionPD(index)=1e-5;
x3 = linspace(0,1,51);%eHOG
distributionHOG = zeros(2,length(x3));
distributionHOG(1,:) = histc(CueHOGimP,x3)/length(CueHOGimP);
distributionHOG(2,:) = histc(CueHOGimN,x3)/length(CueHOGimN);
index = distributionHOG==0;
distributionHOG(index)=1e-5;
priorT = 0.7;
priorN = 0.3;
%% read image 
im = imread('150.jpg');
%im = imread([TestImgDir,filename]);
binaryMask = zeros(size(im,1),size(im,2));
figure,imshow(im);
%% eMSER detection
[brightImg darkImg] = gbmser(im);
%% Characterness evaluation
 for j = 0:1
    if j == 1
     binaryImg = brightImg;  
     else
     binaryImg = darkImg;
    end
%    figure,imshow(binaryImg);
     [binaryImg] = componentfiltering(binaryImg);
     [L,num] = bwlabel(binaryImg);
%     figure,imagesc(L);
%     axis off;
    c = bwconncomp(binaryImg); 
    if c.NumObjects>0
    CueSWV = computestrokewidth(double(binaryImg));
    CueHOG = computeHOG(binaryImg, im);
    CuePD = computeContrastCue(binaryImg, im);
    end
%    positiveSWV = zeros(c.NumObjects,1);
    index = (CueSWV>=2);
    CueSWV(index)=1.99;
    index = (CuePD>=35);
    CuePD(index)=49.9;
    positiveSWV = distributionSWV(1,floor(CueSWV/0.04)+1);
    negativeSWV = distributionSWV(2,floor(CueSWV/0.04)+1);
    positivePD = distributionPD(1,floor(CuePD/0.7)+1);
    negativePD = distributionPD(2,floor(CuePD/0.7)+1);   
     positiveHOG = distributionHOG(1,floor(CueHOG/0.02)+1);
     negativeHOG = distributionHOG(2,floor(CueHOG/0.02)+1); 
%    characterness = (positiveSWV.*positivePD)./(positiveSWV.*positivePD+negativeSWV.*negativePD); %bayesian 
    characterness = (priorT.*positiveSWV.*positivePD.*positiveHOG)./(priorT.*positiveSWV.*positivePD.*positiveHOG+priorN.*negativeSWV.*negativePD.*negativeHOG); %bayesian 
    characternessMap = zeros(size(binaryImg));
    for i = 1:num
        index = (L==i);
        characternessMap(index)=characterness(i);
    end
%    figure,imagesc(characternessMap);axis off;
%    colorbar('South');
%    end   

%% Text Verification 
c = bwconncomp(binaryImg); 
if c.NumObjects>1
[combinedDist] = computesimilarity(binaryImg,im);
%[characternessMapFinal,characternessFinal] = smoothing(binaryImg,characterness,combinedDist);%smoothing
%figure,imagesc(characternessMapFinal);
pairwiseCost = computePairwise(binaryImg,combinedDist);
[label] = graphcutlabeling(characterness,pairwiseCost);
index = find(label==2);
for i=1:length(index)
binaryImg(L==index(i)) = 0;
end
end
%figure,imagesc(binaryImg);axis off;
%% Clustering-based text line extraction (arbitrary)
% c = bwconncomp(binaryImg); 
% %figure,imshow(I);
% if c.NumObjects>=2
%      flag = textline_arbitrary2(binaryImg);
%      binaryMask = boundingbox_arbitrary(binaryImg,flag,binaryMask);
% end

%% Clustering-based text line extraction (horizonal)
c = bwconncomp(binaryImg);
if c.NumObjects>0
[textBox] = textlineextractionh(binaryImg); %left,right,top,bottom
else
    textBox=[];
end

%lef
%[textBox] = textlineextractionh(binaryImg); %left,right,top,bottom
%[textBox] = textline_arbitrary(binaryImg);
if ~isempty(textBox)
    temp = textBox(:,2);
    textBox(:,2)=textBox(:,3);
    textBox(:,3)=temp;
    displaytext2(im,textBox);
%    imwrite(I2,[colorsavepath fileName(1:end-5) '.png'],'png');
    binaryMask = boundingBox(binaryMask,textBox);
%     figure,imshow(binaryMask);
end

end
