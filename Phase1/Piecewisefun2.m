function [output,flag]=Piecewisefun2(t)
if length(t)>1
    error('%s will only work with scalar inputs',mfilename);
end
if (0<=t && t<5)
    output=0.065.*exp(t);
    flag=0;
    return;
end
if (5<=t && t<14)
    output=(4-2./3.*t);
    flag=1;
    return;
end
if (14<=t && t<20)
    output=sqrt(6+2.*t);
    flag=1;
    return;
end
if (20<=t && t<=30)
    output=16;
    flag=1;
    return;
end
output=NaN;
flag=2;