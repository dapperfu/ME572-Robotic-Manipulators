% diary on
clear all
clc;
syms theta1 theta2 dTheta1 dTheta2 
phi1=rotJoint(theta1);
T1  =[1 0 0 20
      0 1 0 0
      0 0 1 0
      0 0 0 1];
phi2=rotJoint(theta2);
T2  =[1 0 0 20
      0 1 0 0
      0 0 1 0
      0 0 0 1];
Tw=simplify(phi1*T1*phi2*T2);
%
Pe=Tw(1:3,4);
i0=eye(4);
an0=i0(1:3,3);
P0=(Pe-i0(1:3,4));
J(:,1)=simplify([cross(an0,P0);an0]);
%
Pe=Tw(1:3,4);
i1=phi1*T1;
an1=i1(1:3,3);
P1=(Pe-i1(1:3,4));
J(:,2)=simplify([cross(an1,P1);an1]);

Jtop=simplify(J(1:2,1:2));
JtopT=[Jtop(1,1) Jtop(2,1);Jtop(1,2) Jtop(2,2)];
B=Jtop*JtopT;
B0=subs(B,{'theta1','theta2'},{81.4686*pi/180,197.2539*pi/180})
B0_1=B0^-1
[R,L]=eigs(B0)
[R1,L1]=eigs(B0_1)