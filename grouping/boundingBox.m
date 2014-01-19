function binaryMask = boundingBox(binaryMask,textBox)
num = size(textBox,1);
% left = textBox(:,1);
% right = textBox(:,2);
% top = textBox(:,3);
% buttom = textBox(:,4);
for i = 1:num
  binaryMask(textBox(i,2):textBox(i,4),textBox(i,1):textBox(i,3))=1;
end