function [label] = graphcutlabeling(dataTerm,pairwiseCost)
%Function: energy minization via graph cuts
%Input: dataTerm - data term of graph cuts
%       smoothTerm - smooth term of graph cuts
%Output: label - label of each regions: text or background interference

num = int32(length(dataTerm));
h = GCO_Create(num,2); 
dataTerm2 = 2*[round(10*(1-dataTerm));round(10*dataTerm)];
%index = dataTerm2<0;
%dataTerm2(index)=0;
dataTerm2 = int32(dataTerm2);
GCO_SetDataCost(h,dataTerm2);
GCO_SetSmoothCost(h,[0 1; 1 0;]);
pairwiseCost = round(pairwiseCost*10);
Upper = triu(ones(size(pairwiseCost)));
neighbors = pairwiseCost.*Upper;
GCO_SetNeighbors(h,neighbors);
GCO_Expansion(h);
label = GCO_GetLabeling(h);
GCO_Delete(h);


