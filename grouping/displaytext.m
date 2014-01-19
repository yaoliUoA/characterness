function displaytext(rgb,textBox,colorsavepath,imName)
if ~isempty(textBox)
num = size(textBox,1);
left = textBox(:,1);
top = textBox(:,2);
right = textBox(:,3);
bottom = textBox(:,4);
for i = 1:num
    if  top(i)>2&&left(i)>2
        rgb(top(i)-2:bottom(i)+2,left(i)-2:left(i),1)=255;
        rgb(top(i)-2:bottom(i)+2,left(i)-2:left(i),2)=255;       
        rgb(top(i)-2:bottom(i)+2,left(i)-2:left(i),3)=51;        
        
        rgb(top(i)-2:bottom(i)+2,right(i):right(i)+2,1)=255;
        rgb(top(i)-2:bottom(i)+2,right(i):right(i)+2,2)=255;
        rgb(top(i)-2:bottom(i)+2,right(i):right(i)+2,3)=51;
        
        rgb(top(i)-2:top(i),left(i):right(i),1)=255;
        rgb(top(i)-2:top(i),left(i):right(i),2)=255;
        rgb(top(i)-2:top(i),left(i):right(i),3)=51;
        
        rgb(bottom(i):bottom(i)+2,left(i):right(i),1)=255;
        rgb(bottom(i):bottom(i)+2,left(i):right(i),2)=255;        
        rgb(bottom(i):bottom(i)+2,left(i):right(i),3)=51;

    end;
end;
end
%figure,imshow(rgb,[]);
imwrite(rgb,[colorsavepath,imName(1:end-3),'png']);
end