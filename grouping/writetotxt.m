function writetotxt(textBox,fid,imName)
%textBox:left, top, right, bottom
if isempty(textBox);
    fprintf(fid,'%s %d',imName,0);
else
    num = size(textBox,1);
    fprintf(fid,'%s %d',imName,num);
    for i = 1:num
        fprintf(fid,' %d %d %d %d',textBox(i,1),textBox(i,2),textBox(i,3)-textBox(i,1),textBox(i,4)-textBox(i,2));%x,y,w,h
    end
end
fprintf(fid,'\r\n');
fclose(fid);