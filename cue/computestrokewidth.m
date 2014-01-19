function CueSWV = computestrokewidth(binaryImg)
% compute Stroke Width Variance(SWV) cue
[L,num] = bwlabel(binaryImg);
CueSWV = zeros(num,1);
skelImg = bwmorph(binaryImg,'skel',inf);
distImg = double(bwdist(~binaryImg));
skelDistImg = zeros(size(binaryImg));
index = (skelImg==1);
skelDistImg(index) = distImg(index); 
for i = 1:num
    index = (L==i);
    temp = skelDistImg(index);
    index2 = (temp~=0);
    CueSWV(i) = var(temp(index2))/(mean(temp(index2)).^2);
%    CueSWV(i) = var(temp(index2));
end

end
    
    