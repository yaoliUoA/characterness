function [combinedDist] = computeDist(binaryImg,I)
%function: compute saliency map via inter-character similarity
%Input: binaryImg - a binary image
%               I - the corresponding rgb image
%Output:   salMap - saliency map via inter-character similarity
%        salValue - saliency value of each region
[L,num] = bwlabel(binaryImg);
% salMap = zeros(size(binaryImg));
% salValue = zeros(num,1);
[lSpace aSpace bSpace] = RGB2Lab(I);
lab = zeros(num,3);
scale = zeros(num,1);
r = 1;
%strokeDiffer = zeros(num,1);
for i = 1:num
    index = (L==i);
    lab(i,1) = mean(lSpace(index));
    lab(i,2) = mean(aSpace(index));
    lab(i,3) = mean(bSpace(index));
    scale(i) = length(lSpace(index));
end;
labDist = squareform(pdist(lab));
%labDist = pdist(lab);

function d = distfun(x,y)
%function: define the scale distance between x and y
%Input: x - 1*1 vector, the scale of a region
%       y - m*1 vector, scale of m regions
%Output: d - m*1 vector  the scale ratio 
d = max(y./x,x./y);
end

%scaleDist = pdist(scale,@distfun);
scaleDist = squareform(pdist(scale,@distfun));
colorDist = labDist.*scaleDist;
index = (colorDist==0);
colorDist(index) = Inf;
[minDist minDistIndex] = min(colorDist,[],2);
index = (colorDist==Inf);
colorDist(index) = 0;

strokeHistgram = computeStrokeHistgram(binaryImg);
index=(strokeHistgram==0);
strokeHistgram(index)=1e-5;

function d = distfun2(x,y)
%function: compute stroke width difference via KLD
%Input: x - 1*n row vector
%       y - m*n matrix
%Output: d - m*1 vector
objectNum = size(y,1);
x2 = repmat(x,objectNum,1);
y = log(x2./y);
d = (x*y')';
end

%strokeDiffer = pdist(strokeHistgram,@distfun2);
strokeDiffer = squareform(pdist(strokeHistgram,@distfun2));

% for i = 1:num
%     index = (L==i);
%     salValue(i) = exp(-strokeDiffer(i,minDistIndex(i))/r);
%     salMap(index) = salValue(i);
% end

%scaling
if max(max(strokeDiffer))~=0
strokeDiffer = strokeDiffer./max(max(strokeDiffer));
end
colorDist = colorDist./max(max(colorDist));
weight = 0.5;
combinedDist = weight*strokeDiffer+(1-weight)*colorDist;
end



