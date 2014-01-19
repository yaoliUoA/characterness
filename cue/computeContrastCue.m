function CueContrast = computeContrastCue(binaryMapTN, image)

R = image(:,:,1);
B = image(:,:,2);
G = image(:,:,3);
[imgH imgW] = size(binaryMapTN);

%% get bounding box
    CC = bwconncomp(binaryMapTN);
    s = regionprops(CC,'boundingbox');
    L = labelmatrix(CC);
    num = CC.NumObjects;
    bBox = cat(1,s.BoundingBox);
    bBox(:,1) = bBox(:,1)-0.5;%bBox(:,1)+0.5;               %left
    bBox(:,2) = bBox(:,2)-0.5;%bBox(:,2)+0.5;               %top
    bBox(:,3) = bBox(:,1)+bBox(:,3)+1;%bBox(:,1)+bBox(:,3)-1;       %right
    bBox(:,4) = bBox(:,2)+bBox(:,4)+1; %bBox(:,2)+bBox(:,4)-1;       %buttom
    index = (bBox<1);
    bBox(index) = 1;
    temp = bBox(:,4);
    index = (temp>imgH);
    temp(index) = imgH;
    bBox(:,4) = temp;
    temp = bBox(:,3);
    index = (temp>imgW);
    temp(index) = imgW;
    bBox(:,3) = temp;
%% get color histogram

x = 0:10:255;
foreContextR = zeros(num,length(x));
foreContextG = zeros(num,length(x));
foreContextB = zeros(num,length(x));

backContextR = zeros(num,length(x));
backContextG = zeros(num,length(x));
backContextB = zeros(num,length(x));


for i = 1:num
    foreindex = find(L(bBox(i,2):bBox(i,4),bBox(i,1):bBox(i,3))==i);
    backindex = find(L(bBox(i,2):bBox(i,4),bBox(i,1):bBox(i,3))==0);
    % R sub-channel 
    tempRegion = R(bBox(i,2):bBox(i,4),bBox(i,1):bBox(i,3));
    forevalue = tempRegion(foreindex);
    backvalue = tempRegion(backindex);
    foreContextR(i,:) = hist(forevalue,x)/length(foreindex);
    backContextR(i,:) = hist(backvalue,x)/length(backindex);
    % G sub-channel
    tempRegion = G(bBox(i,2):bBox(i,4),bBox(i,1):bBox(i,3));
    forevalue = tempRegion(foreindex);
    backvalue = tempRegion(backindex);
    foreContextG(i,:) = hist(forevalue,x)/length(foreindex);
    backContextG(i,:) = hist(backvalue,x)/length(backindex);
    % B sub-channel
    tempRegion = B(bBox(i,2):bBox(i,4),bBox(i,1):bBox(i,3));
    forevalue = tempRegion(foreindex);
    backvalue = tempRegion(backindex);
    foreContextB(i,:) = hist(forevalue,x)/length(foreindex);
    backContextB(i,:) = hist(backvalue,x)/length(backindex);
end
   
%% compute contrast
function d = distfun(x,y)
%function: compute stroke width difference via KLD
%Input: x - 1*n row vector
%       y - m*n matrix
%Output: d - m*1 vector
objectNum = size(y,1);
x2 = repmat(x,objectNum,1);
y = log(x2./y);
d = (x*y')';
end

CueContrastR = zeros(num,1);
CueContrastG = zeros(num,1);
CueContrastB = zeros(num,1);
index = (foreContextR==0);
foreContextR(index) = 1e-5;
index = (foreContextG==0);
foreContextG(index) = 1e-5;
index = (foreContextB==0);
foreContextB(index) = 1e-5;
index = (backContextR==0);
backContextR(index) = 1e-5;
index = (backContextG==0);
backContextG(index) = 1e-5;
index = (backContextB==0);
backContextB(index) = 1e-5;
for i = 1:num
    CueContrastR(i) = pdist([foreContextR(i,:);backContextR(i,:)],@distfun);
    CueContrastG(i) = pdist([foreContextG(i,:);backContextG(i,:)],@distfun);
    CueContrastB(i) = pdist([foreContextB(i,:);backContextB(i,:)],@distfun);
end

CueContrast = CueContrastR+CueContrastG+CueContrastB;

end
