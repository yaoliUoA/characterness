%function  minIndex = findmindisth(index,dist,distIndex,centOrientation,scale)
function  minIndex = findmindisth(index,dist,distIndex,centOrientation,scale,left,right,textLength)
minIndex = [];
%dist = dist(cIndex);
%distIndex = distIndex(cIndex);
%centOrientation = centOrientation(cIndex);
if textLength == -1
    for i = 1:length(distIndex)
        scaleRatio = max(scale(index)/scale(distIndex(i)),scale(distIndex(i))/scale(index));
        if dist(i)<(scale(index)+scale(distIndex(i)))/2 && scaleRatio<3
            if centOrientation(distIndex(i))<30
                minIndex = distIndex(i);
                return;
            end
        end
    end
else
    for i = 1:length(distIndex)
         scaleRatio = max(scale(index)/scale(distIndex(i)),scale(distIndex(i))/scale(index));
         if dist(i)<(scale(index)+scale(distIndex(i)))/2 && scaleRatio<3
             if abs(left(distIndex(i))-right(index))<3*textLength && centOrientation(distIndex(i))<30
                minIndex = distIndex(i);
                return;
             end
        end
    end
end
                 
        
            
    