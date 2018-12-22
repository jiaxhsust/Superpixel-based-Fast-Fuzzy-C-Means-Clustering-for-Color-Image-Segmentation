function grad_f=sgrad_edge(f)
f=double(f);
h=fspecial('sobel');
gs=imfilter(double(f),h);
gs2=imfilter(double(f),h');
grad_f=normalized(sqrt(gs.^2+gs2.^2));
