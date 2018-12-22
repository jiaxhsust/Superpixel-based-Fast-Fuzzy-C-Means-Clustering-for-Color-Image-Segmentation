%% MMGR-WT achieves superpixel segmentation using adaptive and multiscale morphological gradient reconstruction
% L_seg is lable image with line
% i is the maximal iterations
% diff is the difference between the previous result and current gradient
function [L_seg,i,diff]=w_MMGR_WT(f,se_start) 
% gauP=5 is the default value
% se_start=1;
max_itr=50;
min_impro=0.0001;
%% step1 gaussian filtering
sigma=1.0;gausFilter=fspecial('gaussian',[5 5],sigma);g=imfilter(f,gausFilter,'replicate');
%% step2 compute gradient image
gg=colorspace('Lab<-RGB',g); 
a1=sgrad_edge(normalized(gg(:,:,1))).^2;b1=sgrad_edge(abs(normalized(gg(:,:,2)))).^2;c1=sgrad_edge(normalized(gg(:,:,3))).^2;
ngrad_f1=sqrt(a1+b1+c1); 
%% step3 MMGR
f_g=zeros(size(f,1),size(f,2));diff=zeros(max_itr,1);
for i=1:max_itr
    gx=w_recons_CO(ngrad_f1,strel('disk',i+se_start-1)); 
    f_g2=max(f_g,double(gx));
    f_g1=f_g;f_g=f_g2;
    diff(i)=mean2(abs(f_g1 - f_g2));
	if i > 1
		if diff(i) < min_impro, break; end
    end  
end
%% step4  watershed
L_seg=watershed(f_g);
