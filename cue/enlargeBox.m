function Box = enlargeBox(BoundingBox,ImgHeight,ImgWidth)

%% enlarge bounding box
Box(:,1) = BoundingBox(:,1)-1;
Box(:,2) = BoundingBox(:,2)-1;
Box(:,3) = BoundingBox(:,3)+1;
Box(:,4) = BoundingBox(:,4)+1;
index = (Box<1);
Box(index) = 1;
temp = Box(:,3);
index = (temp>ImgWidth);
temp(index) = ImgWidth;
Box(:,3) = temp;
temp = Box(:,4);
index = (temp>ImgHeight);
temp(index) = ImgHeight;
Box(:,4) = temp;