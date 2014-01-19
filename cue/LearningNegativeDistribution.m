clear all,close all;
addpath('./gbmser');
addpath('./gbmser/guidedfilter');
addpath('./CharacternessCue');
TrainImgDir = './TrainingImages/*.jpg';
TextLocalizationGtDir = './Training_GT';
% Training
dir_train = dir(TrainImgDir);
num_train_images = length(dir_train); % Change to real number of training images
    CueSWVimN = [];
    CueHOGimN = [];
    CueContrastimN = [];

% Loop through the training set images
for i = 1:num_train_images
    % Read image
    
    imName = dir_train(i).name;
    %imName = '105.jpg';
    fprintf('\nRunning %s, %d images remain.\n',imName,num_train_images-i);
    image = imread([TrainImgDir(1:end-5),imName]);
%    figure,imshow(image);
    [m n t] = size(image);

    
    %% Generate ground truth bounding boxes
    gt_filename = [TextLocalizationGtDir, '/gt_', imName(1:end-4),'.txt'];
    fid = fopen(gt_filename, 'r');
    if (fid == -1)
        disp('invalid Bounding Box file');
        return;
    end;
    BoundingBoxesGT = textscan(fid,'%d %d %d %d %*[^\n]', 'CollectOutput', 1);%left, top, right, bottom
    BoundingBoxesGT = BoundingBoxesGT{1};
    fclose(fid);
    binaryMapGT = getbinarymap(BoundingBoxesGT,m,n);
%    figure,imshow(binaryMapGT)
    
   %% eMSER detection
  [brightImg darkImg] = gbmser(image);
  for j = 0:1
     if j == 0
     binaryImg = brightImg;  
     else
     binaryImg = darkImg;
     end
     
%    figure,imshow(binaryImg);
    
% Generate detected bounding boex
%     s = regionprops(c,'boundingbox');
%     bBox = cat(1,s.BoundingBox);
%     bBox(:,1) = bBox(:,1)+0.5;               %left
%     bBox(:,2) = bBox(:,2)+0.5;               %top
%     bBox(:,3) = bBox(:,1)+bBox(:,3)-1;       %right
%     bBox(:,4) = bBox(:,2)+bBox(:,4)-1;       %buttom
%     binaryMapDetected = getbinarymap(bBox,m,n);
%     figure,imshow(binaryMapDetected);
  %% Find true negatives
  binaryMapTN = (~binaryMapGT) & (binaryImg);
%  figure,imshow(binaryMapTN);
  c = bwconncomp(binaryMapTN); 
  if c.NumObjects>0
  CueSWVtemp = computestrokewidth(double(binaryMapTN));
  CueHOGtemp = computeHOG(binaryMapTN, image);
  CueContrastemp = computeContrastCue(binaryMapTN, image);
  CueSWVimN = [CueSWVimN;CueSWVtemp];
  CueHOGimN = [CueHOGimN;CueHOGtemp];
  CueContrastimN = [CueContrastimN;CueContrastemp];
  end
  end
end  
save('CueNegativeDistribution','CueSWVimN','CueHOGimN','CueContrastimN');

