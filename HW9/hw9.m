clc;clear all;
syms theta1 theta2 L1 L2 l w1 w2 theta1_dot theta2_dot theta1_dot_dot theta2_dot_dot real;
% L1=l;
% L2=l;
phi1=rotJoint(theta1);
phi2=rotJoint(theta2);
R01(1,4)=L1;
for i=1:4
    R01(i,i)=1;
end
R12(1,4)=L2;
for i=1:4
    R12(i,i)=1;
end

A01=simplify(phi1*R01);
A12=simplify(phi2*R12);
A02=simplify(A01*A12);


e=[0,0,1]';
% r11=
% A12=
% r22=