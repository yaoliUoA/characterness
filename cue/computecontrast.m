function [salMap,salValue] = computecontrast(binaryImg,I,bBox)
%Function: compute saliency map via contrast
%Input: binaryImg - a binary image
%               I - the corresponding rgb image
%Output:   salMap - saliency map via 
%        salValue - saliency value of each region
[L,num] = bwlabel(binaryImg);
%num = size(boundingBox,1);
salMap = zeros(size(binaryImg));
salValue = zeros(num,1);
[lSpace aSpace bSpace] = RGB2Lab(I);
meanColor = zeros(2,3);
contrast= zeros(num,1);
r = 5;
for i = 1:num
    tBinaryImg = binaryImg(bBox(i,3):bBox(i,4),bBox(i,1):bBox(i,2));
    tLSpace = lSpace(bBox(i,3):bBox(i,4),bBox(i,1):bBox(i,2));
    tASpace = aSpace(bBox(i,3):bBox(i,4),bBox(i,1):bBox(i,2));
    tBSpace = bSpace(bBox(i,3):bBox(i,4),bBox(i,1):bBox(i,2));
    index = (tBinaryImg==0);
    meanColor(1,:) = [mean(tLSpace(index)),mean(tASpace(index)),mean(tBSpace(index))];
    index = (L==i);
    meanColor(2,:) = [mean(lSpace(index)),mean(aSpace(index)),mean(bSpace(index))];
    contrast(i) = pdist(meanColor);
    salValue(i) = 1./(1+exp(-(contrast(i)-15)));
    salMap(index) = salValue(i);
end;

end
    
    
       