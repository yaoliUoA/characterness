function centOrientation = computecentOrientation(centroid)

function d = distfun(x,y)
d = (atan2(abs(x(2)-y(:,2)),abs(x(1)-y(:,1)))*180)/pi;
end

centOrientation = pdist(centroid,@distfun);

end
