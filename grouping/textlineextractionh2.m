function binaryMask = textlineextractionh2(binaryImg,binaryMask)
%function: text line extraction for horizonal texts with word partition
%Input:
%binaryImg - binary image with potential regions
%rgbImg - the corresponding color image
%Output:
%textBox - bounding box of each word
%% initialization
%the features includes skeleton mean, and intensity
%textBox = [];
[L,num] = bwlabel(binaryImg);
s = regionprops(L,'Centroid','BoundingBox','MajorAxisLength','MinorAxisLength','Orientation');
%area = [s.Area]; % compute area
%bBox = (reshape([stats.BoundingBox],4,num))';
centroid = cat(1,s.Centroid);

dist = triu(squareform(pdist(centroid)));
index = dist==0;
dist(index) = Inf;
[dist,distIndex] = sort(dist,2);
centOrientation = squareform(computecentOrientation(centroid));
%centOrientation = centOrientation(distIndex);
bBox = cat(1,s.BoundingBox);
left = bBox(:,1);
right = bBox(:,1)+bBox(:,3);
top = bBox(:,2);
buttom = bBox(:,2)+bBox(:,4);
majorAxisLength = [s.MajorAxisLength]';
minorAxisLength = [s.MinorAxisLength]';
scale = majorAxisLength+minorAxisLength;
orientation = abs([s.Orientation]');

%% mean shift clustering
%feature normalization
[scale_norm,scale_mu,scale_sigma] = featureNormalize(scale);
[orientation_norm,orientation_mu,orientation_sigma] = featureNormalize(orientation);

x = [scale_norm';orientation_norm'];
index = isnan(x);
x(index) = 0;

bandwidth =2.2;
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
% title(['no shifting, numClust:' int2str(numClust)])

%% text grouping
textBox = zeros(num,4);
textLength = zeros(num,1);
comNumLine = zeros(num,1);
flag = zeros(num,1);
lineNum = 0;
for k = 1:numClust
    cIndex = clustMembsCell{k};
        for i = 1:length(cIndex)-1
          if flag(cIndex(i)) == 0
            minIndex = findmindisth(cIndex(i),dist(cIndex(i),:),distIndex(cIndex(i),:),...
            centOrientation(cIndex(i),:),scale,-1,-1,-1);
            if ~isempty(minIndex)
                    lineNum = lineNum+1;
                    textBox(lineNum,1) = min(left(cIndex(i)),left(minIndex));%left
                    textBox(lineNum,2) = max(right(cIndex(i)),right(minIndex));%right
                    textBox(lineNum,3) = min(top(cIndex(i)),top(minIndex));%top
                    textBox(lineNum,4) = max(buttom(cIndex(i)),buttom(minIndex));%buttom
                    flag(cIndex(i)) = lineNum;
                    flag(minIndex) = lineNum;
                    textLength(lineNum) = abs(left(minIndex)-right(cIndex(i)))+1;
                    comNumLine(lineNum) = 2;
            end          
          else
      minIndex = findmindisth(cIndex(i),dist(cIndex(i),:),distIndex(cIndex(i),:),...
      centOrientation(cIndex(i),:),scale,left,right,textLength(flag(cIndex(i))));
            if ~isempty(minIndex)
                    textBox(flag(cIndex(i)),1) = min(textBox(flag(cIndex(i)),1),left(minIndex));%left
                    textBox(flag(cIndex(i)),2) = max(textBox(flag(cIndex(i)),2),right(minIndex));%right
                    textBox(flag(cIndex(i)),3) = min(textBox(flag(cIndex(i)),3),top(minIndex));%top
                    textBox(flag(cIndex(i)),4) = max(textBox(flag(cIndex(i)),4),buttom(minIndex));%buttom
                    flag(minIndex) = flag(cIndex(i));
                    textLength(flag(cIndex(i))) = abs(left(minIndex)-right(cIndex(i)))+1;
                    comNumLine(flag(cIndex(i))) = comNumLine(flag(cIndex(i)))+1;
            end
          end
        end
end
nonzeroIndex =(comNumLine>=2);
textBox = floor(textBox(nonzeroIndex,:));
textBox(:,1) = textBox(:,1)-1;
textBox(:,3) = textBox(:,3)-1;
index = (textBox <= 0);
textBox(index) = 1;

num = size(textBox,1);
for i = 1:num
  binaryMask(textBox(i,3):textBox(i,4),textBox(i,1):textBox(i,2))=255;
end

end




            
