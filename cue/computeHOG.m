function CueHOGNew = computeHOG(binaryImg,rgbImg)
%function: compute saliency map via HOG
%Input: binaryImg - a binary imge
%       rgbImg - the corresponding color image
%       t - t=1, bright image , t=0, dark image
%Output: salMap - saliency map via HOG
%        salValue - saliency value of each region

% dilation operation


se = strel('rectangle',[7 7]);
binaryImgNew = imdilate(binaryImg,se);%
salMap = zeros(size(binaryImg));
[L1,num1] = bwlabel(binaryImg);
hsiImg = rgb2hsi(rgbImg); 
grayImg = hsiImg(:,:,3);

% [binaryImgNew meanimg nrs] = ICG_MSERDetection(grayImg,10, 0.00002, 0.1, t, 10);
% figure,imshow(binaryImgNew);

[L2,num2] = bwlabel(binaryImgNew);
edgeHOGMap = zeros(size(binaryImg));
CueHOG = zeros(num2,1);


%grayImg = rgb2gray(rgbImg);
th = graythresh(grayImg);
if th>0.3
edgeMap = edge(grayImg,'canny',th-0.3);
else
edgeMap = edge(grayImg,'canny',th);   
end
%figure,imshow(edgeMap);
[ valueMap indexMap ] = hog_me(grayImg, 360, 4);
index = (edgeMap==1);
edgeHOGMap(index) = indexMap(index);
hogNum = zeros(4,1);
for i = 1:num2
%    index = (L1==i);
    index2 = (L2==i);
    temp = edgeHOGMap(index2);
    edgeNum = length(find(temp~=0));
    if edgeNum==0
        CueHOG(i) = 0;
    else
    hogNum(1) = length(find(temp==1));
    hogNum(2) = length(find(temp==2));
    hogNum(3) = length(find(temp==3));
    hogNum(4) = length(find(temp==4));
    CueHOG(i) = sqrt((hogNum(1)-hogNum(3)).^2+(hogNum(2)-hogNum(4)).^2)./edgeNum;
    end
    salMap(index2) = CueHOG(i);
end

CueHOGNew = zeros(num1,1);
salMap = salMap.*binaryImg;
if num1 == num2
    CueHOGNew = CueHOG;
else

    for i = 1:num1
        index = (L1==i);
        CueHOGNew(i) = mean(salMap(index));
    end
end
    
    
    
