function [combinedDist] = computesimilarity(binaryImg,I)
[L,num] = bwlabel(binaryImg);
[lSpace aSpace bSpace] = RGB2Lab(I);
lab = zeros(num,3);

%% color distance 
for i = 1:num
    index = (L==i);
    lab(i,1) = mean(lSpace(index));
    lab(i,2) = mean(aSpace(index));
    lab(i,3) = mean(bSpace(index));
end;
colorDist = squareform(pdist(lab));

%% stroke width histgram
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

%scaling
if max(max(strokeDiffer))~=0
strokeDiffer = strokeDiffer./max(max(strokeDiffer));
end
colorDist = colorDist./max(max(colorDist));
weight = 0.5;
combinedDist = weight*strokeDiffer+(1-weight)*colorDist;



%combinedDist = strokeDiffer;

end
