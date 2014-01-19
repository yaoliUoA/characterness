function [salMapFinal,salValueFinal] = smoothing(binaryImg,salValue,combinedDist)
%function: redefine saliency values of regions 
%Input: salValue - saliency values before smoothing
%Ouput: salValueFinal - saliency values after smoothing
%       salMapFinal - final saliency map
[L,num] = bwlabel(binaryImg);
salMapFinal = zeros(size(binaryImg));
salValueFinal = zeros(1,num);
index = (combinedDist==0);
combinedDist(index) = Inf;
[sortDist sortIndex] = sort(combinedDist,2);
m =2;
for i = 1:num
    index = (L==i);
    sortSum = sum(sortDist(i,1:m));%0.005
    if sortSum<0.1
        weight = [sortSum-sortDist(i,1),sortSum-sortDist(i,2)];
        sal = [salValue(sortIndex(i,1)),salValue(sortIndex(i,2))];
        salValueFinal(i) = sal*weight'/((m-1)*sortSum);
    else 
        salValueFinal(i) = salValue(i);
    end
        salMapFinal(index) = salValueFinal(i);
end

end
        


