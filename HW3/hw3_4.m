% syms theta1 s2 theta3 a b
clear all
s2=3;
theta1=330*pi/180;
theta3=80*pi/180;
a=3;
b=3;
syms theta1 theta3 s2 l1 l2
% a=l1;
% b=l2;
phi1=rotJoint(theta1);
T1  =[0 1 0  a
      0 0 -1 0
      -1 0 0 0
      0 0 0 1];
phi2=prizJoint(s2);
T2  =[0 0 -1 0
      0 1 0  0
      1 0 0 0
      0 0 0 1];
phi3=rotJoint(theta3);
T3  =[0 0 1 b
      1 0 0 0
      0 1 0 0
      0 0 0 1];
  
Tw=simplify(phi1*T1*phi2*T2*phi3*T3)