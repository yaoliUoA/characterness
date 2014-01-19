function nerigbors = getnerigbor(binaryImg)
%Function:finding nerigbors of regions
%Input: binaryImg - a binary image
%Output: nerigbors - a m*m logical maxtrix (m is the number of objects). 
%        if nerigbors(i,j)==1 i and j are neigbors

CC = bwconncomp(binaryImg);
L = labelmatrix(CC);
s = regionprops(L,'Centroid','MajorAxisLength','MinorAxisLength');
majorAxisLength = [s.MajorAxisLength]';
minorAxisLength = [s.MinorAxisLength]';
scale = majorAxisLength+minorAxisLength;
centroid = cat(1,s.Centroid);
%disteuclidean = triu(squareform(pdist(centroid)));
disteuclidean = pdist(centroid);
%num = CC.NumObjects;

function d = distScale(x1,x2)
objects = size(x2,1);
x1 = repmat(x1,objects,1);
x = cat(2,x1,x2);
d = min(x,[],2);
end

%distscale = triu(squareform(pdist(scale,@distScale)));
distscale = pdist(scale,@distScale);
nerigbors = squareform(distscale > disteuclidean);

end


