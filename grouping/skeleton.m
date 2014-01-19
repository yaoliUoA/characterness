function J=skeleton(J)
% I=imread('骨架.bmp');
% figure;subplot(1,2,1);imshow(I);title('原图');
%J=1-I;
% subplot(1,2,2);imshow(J);title('反相');
rows=size(J,1);
cols=size(J,2);
for m=1:50
J1=zeros(rows,cols);
  for i=2:rows-1
    for j=2:cols-1
          k=0;
          s=0;
         if J(i,j)==1&J(i-1,j)*J(i+1,j)*J(i,j-1)*J(i,j+1)*J(i-1,j-1)*J(i-1,j+1)*J(i+1,j+1)*J(i+1,j-1)==0;
             %统计非零相邻像素个数*************
            k=J(i-1,j)+J(i+1,j)+J(i,j-1)+J(i,j+1)+J(i-1,j-1)+J(i-1,j+1)+J(i+1,j+1)+ J(i+1,j-1);
              %统计相邻像素由0到1的次数****************
                if J(i-1,j)==0 &J(i-1,j+1)==1
                 s=s+1;
                end
               if J(i-1,j+1)==0 &J(i,j+1)==1
                 s=s+1;
              end
                if J(i,j+1)==0 &J(i+1,j+1)==1
                 s=s+1;
                end
                if J(i+1,j+1)==0 &J(i+1,j)==1
                 s=s+1;
                end
                if J(i+1,j)==0 &J(i+1,j-1)==1
                 s=s+1;
                end
                if J(i+1,j-1)==0 &J(i,j-1)==1
                 s=s+1;
                end
                if J(i,j-1)==0 &J(i-1,j-1)==1
                 s=s+1;
                end
                if J(i-1,j-1)==0 &J(i-1,j)==1
                 s=s+1;
                end
         if (J(i,j+1)*J(i+1,j)==0|(J(i-1,j)==0&J(i,j-1)==0))&k<=6&k>=2&s==1
            J1(i,j)=1; 
         end
         end
    end
  end
   J=J-J1;
         
J2=zeros(rows,cols);
for i=2:rows-1
    for j=2:cols-1
          k=0;
          s=0;
         if J(i,j)==1&J(i-1,j)*J(i+1,j)*J(i,j-1)*J(i,j+1)*J(i-1,j-1)*J(i-1,j+1)*J(i+1,j+1)*J(i+1,j-1)==0;
             %统计非零相邻像素个数*************
            k=J(i-1,j)+J(i+1,j)+J(i,j-1)+J(i,j+1)+J(i-1,j-1)+J(i-1,j+1)+J(i+1,j+1)+ J(i+1,j-1);
              %统计相邻像素由0到1的次数****************
                if J(i-1,j)==0 &J(i-1,j+1)==1
                 s=s+1;
                end
               if J(i-1,j+1)==0 &J(i,j+1)==1
                 s=s+1;
              end
                if J(i,j+1)==0 &J(i+1,j+1)==1
                 s=s+1;
                end
                if J(i+1,j+1)==0 &J(i+1,j)==1
                 s=s+1;
                end
                if J(i+1,j)==0 &J(i+1,j-1)==1
                 s=s+1;
                end
                if J(i+1,j-1)==0 &J(i,j-1)==1
                 s=s+1;
                end
                if J(i,j-1)==0 &J(i-1,j-1)==1
                 s=s+1;
                end
                if J(i-1,j-1)==0 &J(i-1,j)==1
                 s=s+1;
                end


         if (J(i-1,j)*J(i,j-1)==0|(J(i,j+1)==0&J(i+1,j)==0))&k<=6&k>=2&s==1
            J2(i,j)=1; 
  
         end
       end
          
    end
end
 J3=J-J2;
  if J1==0&J2==0;
     break
  else
      J=J3;
   end
end