function [textBox,flag] = lineformation(centroid,skelLength,bBox,numClust,clustMembsCell)
%function:
%compute the location of each word
%input: 
%centriod - n*2,centriod of each component
%skelLength - n*1,skeletion length of each component
%bBox - n*4, coordinate of each component, ie, left,right,top,buttom
%numClust - 1,number of Clusters
%clustMembsCell - the indexes of components in each cluster
%ouput:
%textBox - bounding boxes of words
% distance = triu(squareform(pdist(centriod)));
% index = distance==0;
% distance(index) = Inf;
% [minDist,minIndex] = min(distance,[],2);
lineNum = 0;
textBox = zeros(length(skelLength),4);
flag = zeros(length(skelLength),1);
for k = 1:numClust
    regionIndex = clustMembsCell{k};
    if length(regionIndex)>=3
        dist = triu(squareform(pdist(centroid(regionIndex,:))));
        index = dist==0;
        dist(index) = Inf;
        [minDist,minIndex] = min(dist,[],2);
        for i = 1:length(regionIndex)
            if minDist(i)<(skelLength(regionIndex(i))+skelLength(regionIndex(minIndex(i))))/2
                if flag(regionIndex(i))==0 %一行新文字
                    lineNum = lineNum+1;
                    textBox(lineNum,1) = min(bBox(regionIndex(i),1),bBox(regionIndex(minIndex(i)),1));%left
                    textBox(lineNum,2) = max(bBox(regionIndex(i),2),bBox(regionIndex(minIndex(i)),2));%right
                    textBox(lineNum,3) = min(bBox(regionIndex(i),3),bBox(regionIndex(minIndex(i)),3));%top
                    textBox(lineNum,4) = max(bBox(regionIndex(i),4),bBox(regionIndex(minIndex(i)),4));%buttom
                    flag(regionIndex(i)) = lineNum;
                    flag(regionIndex(minIndex(i))) = lineNum;
                else %同一行文字
                    textBox(lineNum,1) = min(textBox(lineNum,1),bBox(regionIndex(minIndex(i)),1));%left
                    textBox(lineNum,2) = max(textBox(lineNum,2),bBox(regionIndex(minIndex(i)),2));%right
                    textBox(lineNum,3) = min(textBox(lineNum,3),bBox(regionIndex(minIndex(i)),3));%top
                    textBox(lineNum,4) = max(textBox(lineNum,4),bBox(regionIndex(minIndex(i)),4));%buttom
                    flag(regionIndex(minIndex(i))) = lineNum;
                end
            end
        end
    end
end
                  
                    
                    
                    
                
                
            

        
        
        
        
        