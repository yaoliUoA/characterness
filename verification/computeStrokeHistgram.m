function StrokeHistgram=computeStrokeHistgram(BinaryImg)
[L,num]=bwlabel(BinaryImg);
%SkelDistImg=zeros(size(BinaryImg));
DistanceImg=double(bwdist(~BinaryImg));
x=1.5:3:88.5;
StrokeHistgram=zeros(num,length(x));
for i=1:num
    index=(L==i);
    StrokeValue=DistanceImg(index);
    N=hist(StrokeValue,x);
    StrokeHistgram(i,:)=N/length(StrokeValue);
end
    
    