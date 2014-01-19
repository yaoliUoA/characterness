    n = 50000;
    t = pi*rand(1);
    X = [cos(t) -sin(t) ; sin(t) cos(t)]*[7 0; 0 2]*rand(2,n);
    X = [X  20*(rand(2,1)-0.5)];  % add an outlier

    tic
    c = minBoundingBox(X);
    toc

    figure;
   hold off,  plot(X(1,:),X(2,:),'.')
  hold on,   plot(c(1,[1:end 1]),c(2,[1:end 1]),'r');
%    hold on, plot(c(1,:),c(2,:),'r');
    %hold on,    plot(c(1,[1,1]),c(2,[1,1]),'r')
    axis equal
% c=[1,-7,-6,2;-3,2,4,-1];
% plot(c(1,[1:end 1]),c(2,[1:end 1]),'r');
% figure,plot(c(1,[1:end 1]),c(2,[1:end 1]),'r*');
%rectangle('Position',[1,1,2,2],'Curvature',[0.5,0.5],'LineWidth',2,'LineStyle','--','EdgeColor','r');
