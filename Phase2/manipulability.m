function [ax,by,cz,Beta,R]=manipulability(J)
n=min([size(J,2) 3]);
Jtop=J(1:n,1:n);
B=Jtop*Jtop';
[R,L1]=eigs(B^-1);
E=diag(L1);
R1=R*sign(R(1,1));
ax=1/sqrt(E(1));
by=1/sqrt(E(2));
Beta=acos(R1(1,1));
if n==3
    cz=1/sqrt(E(3));
else
    cz=NaN;
end
