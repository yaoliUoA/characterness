%% Draw distribution
close all;
clear all;
%% load .mat
load('/data/CueNegativeDistribution_229.mat');
load('/data/CuePositiveDistribution_229.mat');
%methods_name = {'Positive likelihood','Negative likelihood'};
%methods_colors = distinguishable_colors(2);
%% Draw the distribution of SW
x = linspace(0,2,50);
h = zeros(2,length(x));
h(1,:) = histc(CueSWVimP,x)/length(CueSWVimP);
h(2,:) = histc(CueSWVimN,x)/length(CueSWVimN);
figure,subplot(2,1,1),bar(h(1,:));
title('positive distribution of cue SW');
set(gca,'XLim',[1 size(h,2)]);
xlabel('bins','fontsize',14);
ylabel('likelihood','fontsize',14);
set(gca,'YLim',[0 0.35]);
subplot(2,1,2),bar(h(2,:),'r');
title('negative distribution of cue SW');
xlabel('bins','fontsize',14);
ylabel('likelihood','fontsize',14);
set(gca,'XLim',[1 size(h,2)]);
set(gca,'YLim',[0 0.35]);
%% Draw the distribution of perceputal divergenece
x = linspace(0,35,50);
h = zeros(2,length(x));
h(1,:) = histc(CuePDimP,x)/length(CuePDimP);
h(2,:) = histc(CuePDimN,x)/length(CuePDimN);
figure,subplot(2,1,1),bar(h(1,:));
title('positive distribution of cue PD');
xlabel('bins','fontsize',14);
ylabel('likelihood','fontsize',14);
set(gca,'XLim',[1 size(h,2)]);
set(gca,'YLim',[0 0.1]);
subplot(2,1,2),bar(h(2,:),'r');
title('negative distribution of cue PD');
xlabel('bins','fontsize',14);
ylabel('likelihood','fontsize',14);
set(gca,'XLim',[1 size(h,2)]);
set(gca,'YLim',[0 0.1]);
%% Draw the distribution of eHOG
x = linspace(0,1,50);
h = zeros(2,length(x));
h(1,:) = histc(CueHOGimP,x)/length(CueHOGimP);
h(2,:) = histc(CueHOGimN,x)/length(CueHOGimN);
figure,subplot(2,1,1),bar(h(1,:));
title('positive distribution of cue eHOG');
xlabel('bins','fontsize',14);
ylabel('likelihood','fontsize',14);
set(gca,'XLim',[1 size(h,2)]);
set(gca,'YLim',[0 0.5]);
subplot(2,1,2),bar(h(2,:),'r');
title('negative distribution of cue PD');
xlabel('bins','fontsize',14);
ylabel('likelihood','fontsize',14);
set(gca,'XLim',[1 size(h,2)]);
set(gca,'YLim',[0 0.5]);