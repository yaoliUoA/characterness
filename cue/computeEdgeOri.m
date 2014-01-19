function CueEQ = computeEdgeOri(Img,Box)
% compute edge orientation feature
% Image: input image
%   Box: Bounding boxes (left,top,right,bottom)
ImgHeight = size(Img,1);
ImgWidth = size(Img,2);
num = size(Box,1);
Box = enlargeBox(Box,ImgHeight,ImgWidth);
ImgHSI = rgb2hsi(Img); 
ImgGray = ImgHSI(:,:,3);
th = graythresh(ImgGray);
EdgeMap = edge(ImgGray,'canny',th);
[ valueMap angleMap indexMap ] = hog_original(ImgGray, 360, 4);


for i = 1:num
    EdgeCropped = EdgeMap(Box(i,2):Box(i,4),Box(i,1):Box(i,3));
    figure,imshow(EdgeCropped);
    [L,EdgeNum] = bwlabel(EdgeCropped);
     OriFeature = find(angleMap(EdgeCropped);
end  