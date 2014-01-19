function orientation = computeOrientation(centroid)
orientation = zeros(size(centroid,1),size(centroid,1));
for i = 1:size(centroid,1)
    for j = i+1:size(centroid,1)
        cy=abs(centroid(j,2)-centroid(i,2));
        cx=abs(centroid(j,1)-centroid(i,1));
        orientation(i,j)=(atan2(cy,cx)*180)/pi;
    end;
end;
        