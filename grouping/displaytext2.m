function displaytext2(rgb,textBox)
num = size(textBox,1);
left = textBox(:,1);
right = textBox(:,3);
top = textBox(:,2);
buttom = textBox(:,4);
figure,imshow(rgb);
c = zeros(2,4);
hold on;
for i = 1:num
    c(1,1) = left(i)-2;
    c(1,2) = left(i)-2;
    c(1,3) = right(i)+2;
    c(1,4) = right(i)+2;
    c(2,2) = top(i)-2;
    c(2,3) = top(i)-2;
    c(2,1) = buttom(i)+2;
    c(2,4) = buttom(i)+2;
    plot(c(1,[1:end 1]),c(2,[1:end 1]),'y','LineWidth',5);
end
hold off;
% for i = 1:num
%     if  top(i)>2&&left(i)>2
%         rgb(top(i)-5:buttom(i)+5,left(i)-5:left(i),1)=255;
%         rgb(top(i)-5:buttom(i)+5,left(i)-5:left(i),2)=0;       
%         rgb(top(i)-5:buttom(i)+5,left(i)-5:left(i),3)=0;        
%         
%         rgb(top(i)-5:buttom(i)+5,right(i):right(i)+5,1)=255;
%         rgb(top(i)-5:buttom(i)+5,right(i):right(i)+5,2)=0;
%         rgb(top(i)-5:buttom(i)+5,right(i):right(i)+5,3)=0;
%         
%         rgb(top(i)-5:top(i),left(i):right(i),1)=255;
%         rgb(top(i)-5:top(i),left(i):right(i),2)=0;
%         rgb(top(i)-5:top(i),left(i):right(i),3)=0;
%         
%         rgb(buttom(i):buttom(i)+5,left(i):right(i),1)=255;
%         rgb(buttom(i):buttom(i)+5,left(i):right(i),2)=0;        
%         rgb(buttom(i):buttom(i)+5,left(i):right(i),3)=0;
% 
%     end;
% end;
end