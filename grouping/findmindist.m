function minIndex = findmindist(index,cIndex,dist,distIndex,skelLength,area,flag,orientation,slope)
minIndex = [];
if slope==-1
    for i = 1:3
        if dist(i)<(skelLength(index)+skelLength(distIndex(i)))/2 && flag(distIndex(i))==0
            if (area(index)/area(distIndex(i)))<3 && (area(index)/area(distIndex(i)))>0.4
            minIndex = cIndex(distIndex(i));
            return;
            end
        end
    end
else
    for i = 1:3
        if dist(i)<(skelLength(index)+skelLength(distIndex(i)))/2 && flag(distIndex(i))==0
            if abs(orientation(cIndex(index),cIndex(distIndex(i)))-slope)<30 &&...
               (area(index)/area(distIndex(i)))<4 && (area(index)/area(distIndex(i)))>0.25
            minIndex = cIndex(distIndex(i));
            return;
            end
        end
    end
end
% if slope==-1
%     for i = 1:3
%         if dist(i)<(skelLength(index)+skelLength(distIndex(i)))/2 && flag(distIndex(i))==0
%             if (area(index)/area(distIndex(i)))<3 && (area(index)/area(distIndex(i)))>0.4
%             minIndex = cIndex(distIndex(i));
%             return;
%             end
%         end
%     end
% else
%     for i = 1:3
%         if dist(i)<(skelLength(index)+skelLength(distIndex(i)))/2 && flag(distIndex(i))==0
%             if abs(orientation(cIndex(index),cIndex(distIndex(i)))-slope)<30 &&...
%                (area(index)/area(distIndex(i)))<4 && (area(index)/area(distIndex(i)))>0.25
%             minIndex = cIndex(distIndex(i));
%             return;
%             end
%         end
%     end
% end
    