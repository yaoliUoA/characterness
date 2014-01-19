function [binaryImg] = componentfiltering(binaryImg)
%[B,L,N,A]=bwboundaries(binaryImg,'noholes');
% if ~isempty(A)
% [r c] = find(A==1);
% for i = 1:length(r)
%     index = (L==r(i));
%     binaryImg(index) = 0;
% end
% end

[L,num] = bwlabel(binaryImg);
%s = regionprops(L,'Orientation');
%orientation = abs([s.Orientation]');
skelImg = bwmorph(binaryImg,'skel',inf);
for i = 1:num
    index = (L==i);
    [r c] = find(L==i);
    skelLength = length(find(skelImg(index))==1);
    height = max(r)-min(r);
    width = max(c)-min(c);
    if skelLength<20
        binaryImg(index) = 0;
     elseif width/height>3
                  binaryImg(index) = 0;
     elseif width<2
          binaryImg(index) = 0;
%     elseif abs(orientation(i))<45
%         binaryImg(index) = 0;
%     elseif length(r)/(height*width)>0.8 && width/height>0.8
%         binaryImg(index) = 0;
    end
end    
end