function [centroid,skelLength,area,bBox] = componentanalysis(binaryImg)
%function: use some heuristic rules to remove false positives
%Input:  binaryImg - a binary image with potential text regions
%Output£ºcentriod - centriods of components
%        skelLength - skeleton length of components
[imgHeight imgWidth] = size(binaryImg);
[L,num] = bwlabel(binaryImg);
skelImg = skeleton(binaryImg);
top = zeros(num,1); 
buttom = zeros(num,1); 
left = zeros(num,1); 
right = zeros(num,1);
skelLength = zeros(num,1);
area = zeros(num,1);
for i = 1:num
    [r c] = find(L==i);
    index = (L==i);
    area(i) = length(r);
    skelLength(i) = length(find(skelImg(index)==1));
%     if min(r)>2,    top(i) = min(r)-2; else  top(i) = 1; end
%     if max(r)<imgHeight-1, buttom(i) = max(r)+2; else buttom(i) = imgHeight; end
%     if min(c)>2, left(i) = min(c)-2; else left(i) = 1; end
%     if max(c)<imgWidth-1, right(i) = max(c)+2; else right(i) = imgWidth; end
     top(i) = min(r);
     buttom(i) = max(r);
     left(i) = min(c);
     right(i) = max(c);
end
bBox = [left right top buttom];
centroid = [(bBox(:,1)+bBox(:,2))./2, (bBox(:,3)+bBox(:,4))./2];
end

    