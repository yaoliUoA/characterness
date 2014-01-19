function [ valueMap indexMap ] = hog_me(im, angle, bins)
%%function [ valueMap indexMap ] = hog(im, angle, bins)
%%���ܣ�
%%      ����ͼ����ݶȷ��ͼvalueMap�ͽǶ�����ͼindexMap
%%���룺
%%          im�� ͼ�����
%%       angle�� �Ƕȷ�Χ(180:�޷��)��(360:�з��)
%%        bins:  ����bins��
%%�����
%%    valueMap�� �ݶȷ��ͼ
%%    indexMap�� �Ƕ�����ͼ
%%
%%DIPLAB ������2009��6��1��(^_^��ͯ�ڿ��֣���)

if size(im,3) == 3
    imG = rgb2gray(im);
else
    imG = im;
end

[gradientX,gradientY] = gradient(double(imG));                             %%X����Y�����ݶ�ֵ
valueMap = sqrt((gradientX.*gradientX)+(gradientY.*gradientY));            %%�ݶȷ��
index = (gradientX==0); gradientX(index) = 1e-5;                           %%Ϊ����ֵ�ȶ�
YX = gradientY./gradientX;                                                 %%�Ƕȵ�tanֵ

if angle == 180, angleMap = ((atan(YX)+(pi/2))*180)/pi; end                %%�ݶȽǶ�(0~180)    
if angle == 360, angleMap = ((atan2(gradientY,gradientX)+pi)*180)/pi; end  %%�ݶȽǶ�(0~360)
                          
nAngle = angle/bins;                                                       %%�Ƕ��������

angleMap=angleMap+45;

index=find(angleMap>=360);
angleMap(index)=angleMap(index)-360;
indexMap = floor((angleMap-1e-5)/nAngle) + 1;                              %%index���(1~bins)
