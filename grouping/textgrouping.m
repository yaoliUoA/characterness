function [textBox,comNumLine] = textgrouping(binaryImg,rgbImg)
%function: group text components into text lines and remove false
%positives.
%input: binaryImg - a binaryImg with potential regions
%       rgbImg - the corresponding rgb image
%output: lineIndex - 2*4*m maxtrix

%% first layer clustering
%the features includes skeleton mean, and intensity
[L,num] = bwlabel(binaryImg);

%compute skeleton mean and intensity
skel = zeros(num,1);
intensity = zeros(num,1);
skelImg = skeleton(binaryImg);
intensityImg = rgb2gray(rgbImg);
%hsiImg = rgb2hsi(rgbImg); % change the image into hsi space
%intensityImg = hsiImg(:,:,3); % extract the intensity part
distImg = double(bwdist(~binaryImg));
skelDistImg = zeros(size(binaryImg));
index = (skelImg==1);
skelDistImg(index) = distImg(index); 
for i = 1:num
    index = (L==i);
    temp = skelDistImg(index);
    index2 = (temp~=0);
    if ~isempty(temp(index2))
    skel(i) = mean(temp(index2));
    else
        skel(i)=0;
    end
    intensity(i) = mean(intensityImg(index));
end

%feature normalization
[skel_norm,skel_mu,skel_sigma] = featureNormalize(skel);
[inten_norm,inten_mu,inten_sigma] = featureNormalize(intensity);

%mean shift clustering
x = [skel_norm';inten_norm'];

bandwidth =2;
tic
[clustCent,point2cluster,clustMembsCell] = MeanShiftCluster(x,bandwidth);
toc

numClust = length(clustMembsCell);

% figure,hold on
% cVec = 'bgrcmykbgrcmykbgrcmykbgrcmyk';%, cVec = [cVec cVec];
% for k = 1:min(numClust,length(cVec))
%     myMembers = clustMembsCell{k};
%     myClustCen = clustCent(:,k);
%     plot(x(1,myMembers),x(2,myMembers),[cVec(k) '.'])
%     plot(myClustCen(1),myClustCen(2),'o','MarkerEdgeColor','k','MarkerFaceColor',...
%     cVec(k), 'MarkerSize',10)
% end
%axis off;
%title(['no shifting, numClust:' int2str(numClust)])

%% second layer clustering
[centroid,skelLength,area,bBox] = componentanalysis(binaryImg);
% centroid2 = regionprops(binaryImg,'Centroid');
% bBox2 = regionprops(binaryImg,'BoundingBox');
lineNum = 0;

textBox = zeros(length(skelLength),4);
flag = zeros(length(skelLength),1);
slope = zeros(length(skelLength),1); 
%textLength = zeros(length(skelLength),1);  
comNumLine = zeros(length(skelLength),1);
%comDistLine = zeros(length(skelLength),length(skelLength));
orientation = computeOrientation(centroid);
for k = 1:numClust
    cIndex = clustMembsCell{k}; %component index
    if length(cIndex)>=3
      dist = triu(squareform(pdist(centroid(cIndex,:))));
      index = dist==0;
      dist(index) = Inf;
      [dist,distIndex] = sort(dist,2);
       for i = 1:length(cIndex)-1         
        if flag(cIndex(i)) ==0
            minIndex = findmindist(i,cIndex,dist(i,:),distIndex(i,:),...
            skelLength(cIndex),area(cIndex),flag(cIndex),orientation,-1);
            if ~isempty(minIndex)
                    lineNum = lineNum+1;
                    textBox(lineNum,1) = min(bBox(cIndex(i),1),bBox(minIndex,1));%left
                    textBox(lineNum,2) = max(bBox(cIndex(i),2),bBox(minIndex,2));%right
                    textBox(lineNum,3) = min(bBox(cIndex(i),3),bBox(minIndex,3));%top
                    textBox(lineNum,4) = max(bBox(cIndex(i),4),bBox(minIndex,4));%buttom
                    flag(cIndex(i)) = lineNum;
                    flag(minIndex) = lineNum;
                    slope(lineNum) = orientation(cIndex(i),minIndex);
                    comNumLine(lineNum) = 2;
            end
        else
            minIndex = findmindist(i,cIndex,dist(i,:),distIndex(i,:),skelLength(cIndex),...
            area(cIndex),flag(cIndex),orientation,slope(flag(cIndex(i))));
            if ~isempty(minIndex)
                textBox(flag(cIndex(i)),1) = min(textBox(flag(cIndex(i)),1),bBox(minIndex,1));%left
                textBox(flag(cIndex(i)),2) = max(textBox(flag(cIndex(i)),2),bBox(minIndex,2));%right
                textBox(flag(cIndex(i)),3) = min(textBox(flag(cIndex(i)),3),bBox(minIndex,3));%top
                textBox(flag(cIndex(i)),4) = max(textBox(flag(cIndex(i)),4),bBox(minIndex,4));%buttom
                flag(minIndex) = flag(cIndex(i));   
                slope(flag(cIndex(i))) = orientation(cIndex(i),minIndex);
                comNumLine(flag(cIndex(i))) = comNumLine(flag(cIndex(i)))+1;
            end
        end
       end
    end
end
nonzeroIndex =(comNumLine>=3);
textBox = floor(textBox(nonzeroIndex,:));
index = (textBox == 0);
textBox(index) = 1;

end




    