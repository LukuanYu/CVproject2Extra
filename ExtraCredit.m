clc
clear all

im1=rgb2gray(imread('nyc.jpg'));
im1=imresize(im1,[900 1600]);
im2=rgb2gray(imread('husky.jpg'));
im2=imresize(im2,[300 400]);
im1f=figure; imshow(im1);
title('Click on the frame corners. Starting from top left -> top right -> bottom right -> bottom left, then press enter.')
im2f=figure; imshow(im2);
[m,n,b]=size(im2);

figure(im1f), [x1,y1]=getpts;
figure(im2f), 
x2=[1;n;n;1];
y2=[1;1;m;m];

figure(im1f), hold on, plot(x1,y1,'or');
figure(im2f), hold on, plot(x2,y2,'or');
T=maketform('projective',[x2 y2],[x1 y1]);
T.tdata.T;

[im2t,xdataim2t,ydataim2t]=imtransform(im2,T);
% now xdataim2t and ydataim2t store the bounds of the transformed im2
xdataout=[min(1,xdataim2t(1)) max(size(im1,2),xdataim2t(2))];
ydataout=[min(1,ydataim2t(1)) max(size(im1,1),ydataim2t(2))];
% transform both images with the computed xdata and ydata
im2t=imtransform(im2,T); %,'XData',xdataout,'YData',ydataout
im1t=imtransform(im1,maketform('affine',eye(3)),'XData',xdataout,'YData',ydataout);


roi = roipoly(im1,x1,y1);
%n = nnz(roi);
%mask = im2double(roi);
[s, t]=size(im2t);
%mask = 1+poly2mask(x1,y1,s,t);
level = graythresh(imgaussfilt(im2t,0.25));
BW = im2bw(imgaussfilt(im2t,0.25),level);


figure, imshow(im1)
figure, imshow(roi)

img_out = im1;
img_out(roi) = 0;

imshow(img_out);
hold on


pic = pasteimage(img_out, im2t, min([y1(1) y1(2)]),x1(1),BW);
figure
imshow(pic)



