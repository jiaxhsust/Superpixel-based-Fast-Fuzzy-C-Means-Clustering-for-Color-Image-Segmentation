% Please cite the paper "Tao Lei, Xiaohong Jia, Yanning Zhang, Shigang Liu, Hongying Meng and Asoke K. Nandi, 
%Superpixel-based Fast Fuzzy C-Means Clustering for Color Image
%Segmentation, IEEE Transactions on Fuzzy Systems,Doi: 10.1109/TFUZZ.2018.2889018"

% The paper is OpenAccess and you can download freely from "http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=8265186."
% The code was written by Tao Lei and Xiaohong Jia in 2018.
clear all
close all
%% 
cluster=2;
f_ori=imread('113044.jpg');
% Note that you can repeat the program for several times to obtain the best
% segmentation result for image '12003.jpg'
%% generate superpixels
%SFFCM only needs a minimal structuring element for MMGR, we usually set SE=2 or SE=3 for
%MMGR.
SE=3;
L1=w_MMGR_WT(f_ori,SE);
L2=imdilate(L1,strel('square',2));
[~,~,Num,centerLab]=Label_image(f_ori,L2);
%% fast FCM
Label=w_super_fcm(L2,centerLab,Num,cluster);
Lseg=Label_image(f_ori,Label);
figure,imshow(Lseg);

