
function [fs,center_p,Num_p,center_lab]=Label_image(f,L)
%fs is the result of segmentation, center_p is the center pixel of each
%areas
% f is the original image
% L is the label image
f=double(f);
num_area=max(max(L)); %The number of segmented areas
Num_p=zeros(num_area,1);
if size(f,3)<2
    [M,N]=size(f);
    s3=L;
    fs=zeros(M,N);
    center_p=zeros(num_area,1);
    for i=1:num_area
        f2=f(s3==i);f_med=median(f2);fx=double((s3==i))*double(f_med);
        fs=fs+fx;
        center_p(i,:)=uint8(f_med);
        Num_p=zeros(num_area,1);
    end
    fs=uint8(fs);
    %% Color image
else
    [M,N]=size(f(:,:,1));
    s3=L;
    fs=zeros(M,N,3);
    fr=f(:,:,1);fg=f(:,:,2);fb=f(:,:,3);
    center_p=zeros(num_area,3);
    for i=1:num_area
        fr2=fr(s3==i);r_med=median(fr2);r=(s3==i)*r_med;
        fg2=fg(s3==i);g_med=median(fg2);g=(s3==i)*g_med;
        fb2=fb(s3==i);b_med=median(fb2);b=(s3==i)*b_med;
        fs=fs+cat(3,r,g,b);
        center_p(i,:)=uint8([r_med g_med b_med]);
        Num_p(i)=sum(sum(s3==i));
    end
    fs=uint8(fs);
end
TT=cat(3,center_p(:,1),center_p(:,2),center_p(:,3));
TT2=colorspace('Lab<-RGB',TT);
TT2r=TT2(:,:,1);TT2g=TT2(:,:,2);TT2b=TT2(:,:,3);
center_lab(:,1)=TT2r(:);center_lab(:,2)=TT2g(:);center_lab(:,3)=TT2b(:);