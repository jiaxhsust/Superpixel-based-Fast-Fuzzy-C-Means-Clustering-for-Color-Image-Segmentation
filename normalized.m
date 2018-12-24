function g=normalized(a)
if length(size(a))<3
g=g_normalized(a);
else
   f1=a(:,:,1);f2=a(:,:,2);f3=a(:,:,3);   
   ff1=g_normalized(f1);ff2=g_normalized(f2);ff3=g_normalized(f3);
   g=cat(3,ff1,ff2,ff3);
end

function g=g_normalized(a)
a=double(a);
a_min=min(a(:));
g=a-a_min;
g_max=max(g(:));
g=g/g_max;

    