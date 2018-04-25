function A = dh(theta,d,a,alpha)
% dh(theta,d,a,alpha) - Denavit & Hartenburg Parameters.
if isnumeric(theta)
    cT=cosd(theta);
    sT=sind(theta);
else
    cT=cos(theta);
    sT=sin(theta);
end
if isnumeric(alpha)
    cA=cosd(alpha);
    sA=sind(alpha);
else
    cA=cos(alpha);
    sA=sin(alpha);
end
A=[cT -sT*cA  sT*sA a*cT
   sT  cT*cA -cT*sA a*sT
   0   sA     cA    d
   0   0      0     1];
end

