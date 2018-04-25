% syms theta1 s2 theta3 a b
clear all
clc;
syms theta1 theta2 S3 L1 d1 L2 L3
% theta1=0;
% theta2=-pi/2;
% L1=5;
% d1=4;
% L2=5;
%
% theta1=-1.8452;
% theta2=-0.7037;
% S3=sqrt(43);


phi1=rotJoint(theta1);
T1  =[0 0 1 d1
    1 0 0 0
    0 1 0 L1
    0 0 0 1];

phi2=rotJoint(theta2);
T2  =[0 1 0 0
    0 0 1 0
    1 0 0 0
    0 0 0 1];

phi3=prizJoint(S3);
T3  =[1 0 0 0
    0 1 0 0
    0 0 1 0
    0 0 0 1];

% q=phi1*T1*phi2*T2*phi3*T3;
% q(:,4)
Tm=simplify(phi1*T1*phi2*T2*phi3*T3);
%%
% Px=3;
% Py=-5;
% Pz=10;
%
syms Nx Ny Nz Sx Sy Sz Ax Ay Az Px Py Pz

x=simplify(collect(Tm(1,4),sin(theta1)));
y=simplify(collect(Tm(2,4),cos(theta1)));
z=simplify(Tm(3,4));
%%
clc;
Ta=phi1*T1*phi2*T2*phi3*T3;
Tw=[Nx Sx Ax Px;Ny Sy Ay Py;Nz Sz Az Pz;0 0 0 1];
tmp1=simplify(Tw(:,4));
tmp2=simplify(Ta(:,4));
for i=1:3
    fprintf('%s=%s\n',char(tmp1(i)),char(tmp2(i)));
end
fprintf('--------------------------\n');
Ta=T1*phi2*T2*phi3*T3;
Tw=(phi1)^-1*[Nx Sx Ax Px;Ny Sy Ay Py;Nz Sz Az Pz;0 0 0 1];
tmp1=simplify(Tw(:,4));
tmp2=simplify(Ta(:,4));
for i=1:3
    fprintf('%s=%s\n',char(tmp1(i)),char(tmp2(i)));
end
fprintf('--------------------------\n');
Ta=phi2*T2*phi3*T3;
Tw=(phi1*T1)^-1*[Nx Sx Ax Px;Ny Sy Ay Py;Nz Sz Az Pz;0 0 0 1];
tmp1=simplify(Tw(:,4));
tmp2=simplify(Ta(:,4));
for i=1:3
    fprintf('%s=%s\n',char(tmp1(i)),char(tmp2(i)));
end
fprintf('--------------------------\n');
Ta=T2*phi3*T3;
Tw=(phi1*T1*phi2)^-1*[Nx Sx Ax Px;Ny Sy Ay Py;Nz Sz Az Pz;0 0 0 1];
tmp1=simplify(Tw(:,4));
tmp2=simplify(Ta(:,4));
for i=1:3
    fprintf('%s=%s\n',char(tmp1(i)),char(tmp2(i)));
end
fprintf('--------------------------\n');
Ta=phi3*T3;
Tw=(phi1*T1*phi2*T2)^-1*[Nx Sx Ax Px;Ny Sy Ay Py;Nz Sz Az Pz;0 0 0 1];
tmp1=simplify(Tw(:,4));
tmp2=simplify(Ta(:,4));
for i=1:3
    fprintf('%s=%s\n',char(tmp1(i)),char(tmp2(i)));
end
fprintf('--------------------------\n');
Ta=T3;
Tw=(phi1*T1*phi2*T2*phi3)^-1*[Nx Sx Ax Px;Ny Sy Ay Py;Nz Sz Az Pz;0 0 0 1];
tmp1=simplify(Tw(:,4));
tmp2=(Ta(:,4));
for i=1:3
    fprintf('%s=%i\n',char(tmp1(i)),(tmp2(i)));
end
% %%
% syms Pxx Pyy Pzz
% % simplify(Px^2+Py^2)
eqn1=[simplify(Px^2+Py^2+(Pz-L1)^2)];
%
% %%
% S3=sqrt(43);
% LHS=simplify(Px^2+Py^2);
% RHS=x^2+y^2;
% solve(subs(LHS-RHS,S3,-sqrt(43)))
% %%
% solve(-tan(theta1)-(x-4*cos(theta1))/(y-4*sin(theta1)))

%%
clc
syms R phi alpha;
eqn1=[Px*cos(theta1) + Py*sin(theta1) d1]
eqn2=(subs(eqn1,{Px,Py},{R*cos(phi),R*sin(phi)}))
eqn3=subs(simplify(eqn2),phi-theta1,alpha)
eqn4=eqn3*sin(alpha)
eqn5=eqn4./d1
eqn6=eqn5./cos(alpha)
eqn7=simplify(eqn6)
eqn8=subs(eqn7,sin(alpha),sqrt(1-(d1/R)^2))
eqn9=subs(eqn8,R,sqrt(Px^2+Py^2))
eqn10=subs(eqn9,{Px,Py,d1},{3,-5,4})
[N,D]=numden(eqn10(1));
eqn11=[atan(eqn10(1)) alpha];
eqn12=subs(eqn11,{alpha},{phi-theta1})
eqn13=(eqn12-phi)*-1
eqn14=subs(eqn13,phi,atan(Py/Px))
%%
eqn1=[Py*cos(theta1) - Px*sin(theta1) -S3*sin(theta2)]
eqn2=eqn1./-S3