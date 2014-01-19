function pairwiseCost = computePairwise(binaryImg,combinedDist)
combinedDist = ones(size(combinedDist))-tanh(combinedDist);
nerigbors = getnerigbor(binaryImg);
pairwiseCost = zeros(size(combinedDist));
pairwiseCost(nerigbors) = combinedDist(nerigbors);