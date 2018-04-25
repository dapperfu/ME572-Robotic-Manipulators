% syms theta1 s2 theta3 a b
clear all
clc;
syms theta1 theta2 theta3 L1 d1 L2 L3
% theta1=0
% theta2=pi/2;
% theta3=pi/2;
% L1=5;
% d1=4;
% L2=5;
% L3=4;
phi1=rotJoint(theta1);
T1  =[0 0 1 d1
      1 0 0 0
      0 1 0 L1
      0 0 0 1];

phi2=rotJoint(theta2);
T2  =[1 0 0 0
      0 1 0 L2
      0 0 1 0
      0 0 0 1];

phi3=rotJoint(theta3);
T3  =[0 1 0 0
      0 0 1 L3
      1 0 0 0
      0 0 0 1];
Tm=(simplify(phi1*T1*phi2*T2*phi3*T3))
% %%
% syms Nx Ny Nz Sx Sy Sz Ax Ay Az Px Py Pz
% x=simplify(collect(Tm(1,4),sin(theta1)));
% y=simplify(collect(Tm(2,4),cos(theta1)));
% z=simplify(Tm(3,4));
% % 
% % T1=phi2*T2*phi3*T3;
% % Tw=(phi1*T1)^-1*[Nx Sx Ax Px;Ny Sy Ay Py;Nz Sz Az Pz;0 0 0 1];
% % simplify(Tw(:,4))
% % simplify(T1(:,4))
% 
% clc;
% x0=[Px x];
% y0=[Py y];
% z0=[Pz z];
% fprintf('%s=%s\n',char(x0(1)),char(x0(2)));
% fprintf('%s=%s\n',char(y0(1)),char(y0(2)));
% fprintf('%s=%s\n',char(z0(1)),char(z0(2)));
% fprintf('--------------------------\n');
% Ta=phi1*T1*phi2*T2*phi3*T3;
% Tw=[Nx Sx Ax Px;Ny Sy Ay Py;Nz Sz Az Pz;0 0 0 1];
% tmp1=simplify(Tw(:,4));
% tmp2=simplify(Ta(:,4));
% x1=[tmp1(1) tmp2(1)];
% y1=[tmp1(2) tmp2(2)];
% z1=[tmp1(3) tmp2(3)];
% for i=1:3
%     fprintf('%s=%s\n',char(tmp1(i)),char(tmp2(i)));
% end
% fprintf('--------------------------\n');
% Ta=phi2*T2*phi3*T3;
% Tw=(phi1*T1)^-1*[Nx Sx Ax Px;Ny Sy Ay Py;Nz Sz Az Pz;0 0 0 1];
% tmp1=simplify(Tw(:,4));
% tmp2=simplify(Ta(:,4));
% tmp1(1)=tmp1(1)*-1;
% tmp2(1)=tmp2(1)*-1;
% x2=[tmp1(1) tmp2(1)];
% y2=[tmp1(2) tmp2(2)];
% z2=[tmp1(3) tmp2(3)];
% for i=1:3
%     fprintf('%s=%s\n',char(tmp1(i)),char(tmp2(i)));
% end
% fprintf('--------------------------\n');
% Ta=phi3*T3;
% Tw=(phi1*T1*phi2*T2)^-1*[Nx Sx Ax Px;Ny Sy Ay Py;Nz Sz Az Pz;0 0 0 1];
% tmp1=simplify(Tw(:,4));
% tmp2=simplify(Ta(:,4));
% tmp1(1)=tmp1(1)*-1;
% tmp2(1)=tmp2(1)*-1;
% x3=[tmp1(1) tmp2(1)];
% y3=[tmp1(2) tmp2(2)];
% z3=[tmp1(3) tmp2(3)];
% for i=1:3
%     fprintf('%s=%s\n',char(tmp1(i)),char(tmp2(i)));
% end
% fprintf('--------------------------\n');
% 
% %%%
% eqn1=(x0-d1*cos(theta1)).^2+(y0-d1*sin(theta1)).^2
% eqn2=subs(eqn1,sin(theta2+theta3),sqrt(1-(L1 - Pz + L2*cos(theta2))^2/L3^2))
% eqn3=subs(eqn2,{theta1,L1,L2,d1,L3,Px,Py,Pz},{254.2776*pi/180,5,5,4,4,3,-5,10})
% solve(eqn3(1)-eqn3(2))