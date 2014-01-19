function textBox = textboxformation(binaryMask)
%function: find coordinates of regions in binaryMask
%input: binaryMask - a binaryImg
%output: textBox - n*4 maxtrix in the form of 'x y w h'
[L,num] = bwlabel(binaryMask);
textBox = [];
if num>0
    textBox = zeros(num,4);
    for i = 1:num
   [r c] = find(L==i);
   textBox(i,1) = min(c);
   textBox(i,2) = min(r);
   textBox(i,3) = max(c)-min(c);
   textBox(i,4) = max(r)-min(r);
    end
end
    
