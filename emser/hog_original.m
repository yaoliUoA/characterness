function [ valueMap angleMap indexMap ] = hog_original(im, angle, bins)
%%function [ valueMap indexMap ] = hog(im, angle, bins)
%%功能：
%%      计算图像的梯度幅度图valueMap和角度量化图indexMap
%%输入：
%%          im： 图像数据
%%       angle： 角度范围(180:无符号)或(360:有符号)
%%        bins:  量化bins数
%%输出：
%%    valueMap： 梯度幅度图
%%    indexMap： 角度量化图
%%
%%DIPLAB 王栋于2009年6月1日(^_^儿童节快乐！！)

if size(im,3) == 3
    imG = rgb2gray(im);
else
    imG = im;
end

[gradientX,gradientY] = gradient(double(imG));                             %%X方向，Y方向梯度值
valueMap = sqrt((gradientX.*gradientX)+(gradientY.*gradientY));            %%梯度幅度
index = (gradientX==0); gradientX(index) = 1e-5;                           %%为了数值稳定
YX = gradientY./gradientX;                                                 %%角度的tan值

if angle == 180, angleMap = ((atan(YX)+(pi/2))*180)/pi; end                %%梯度角度(0~180)    
if angle == 360, angleMap = ((atan2(gradientY,gradientX)+pi)*180)/pi; end  %%梯度角度(0~360)
                          
nAngle = angle/bins;                                                       %%角度量化间隔

indexMap = floor((angleMap-1e-5)/nAngle) + 1;                              %%index输出(1~bins)
