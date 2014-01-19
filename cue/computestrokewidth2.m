function strokeWidth = computestrokewidth2(binaryImg)
%function: compute stroke width variance 
%Input: binaryImg - a binary image (MSER result)
%Output:stroke width variance of each component
[L,num] = bwlabel(binaryImg);
strokeWidth = zeros(num,1);
skelImg = bwmorph(binaryImg,'skel',inf);
distImg = double(bwdist(~binaryImg));
skelDistImg = zeros(size(binaryImg));
index = (skelImg==1);
skelDistImg(index) = distImg(index); 
for i = 1:num
    index = (L==i);
    temp = skelDistImg(index);
    index2 = (temp~=0);
    strokeWidth(i) = var(temp(index2));
end

end