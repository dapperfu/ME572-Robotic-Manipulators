% function [ output_args ] = ne_recursive( input_args )
% %NE_RECURSIVE Summary of this function goes here
% %   Detailed explanation goes here
%
%
% end
clc;clear all;
syms theta1 theta2 dTheta1 dTheta2 ddTheta1 ddTheta2 L1 L2 m1 m2 g l real;
L1=l;
L2=l;
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

n=3;
% Initialization
e=[0 0 1]';
w{1}=[0,0,0]';
a{1}=[0,0,0]';
vb{1}=[0,0,0]';
ab{1}=[0,g,0]';
F{n+1}=zeros(n,1);
T{n+1}=zeros(n,1);
P_star{n+1}=0;
R_hat{n+1}=0;
% Rotation matrix.
R_hat{2}=A01(1:3,1:3);
R_hat{3}=A12(1:3,1:3);
% Direction vector, technically the T matrix.
P_star{2}=R_hat{2}'*A01(1:3,4);
P_star{3}=R_hat{3}'*A12(1:3,4);

% Direction vector from end link to center of gravity.
G{2}=[-L1/2,0,0]';
G{3}=[-L2/2,0,0]';
% Link type. 1=prismatic, 0=revolute
J{2}=0;
J{3}=0;
% Partial diff parameters
dq{2}=dTheta1;
ddq{2}=ddTheta1;
dq{3}=dTheta2;
ddq{3}=ddTheta2;
% Masses
m{2}=m1;
m{3}=m2;
%
I_tmp(2,2)=1/12*m{2}*L2^2;
I_tmp(3,3)=1/12*m{2}*L2^2;
I{2}=I_tmp;
I_tmp(2,2)=1/12*m{3}*L2^2;
I_tmp(3,3)=1/12*m{3}*L2^2;
I{3}=I_tmp;

for i=2:n
    w{i}=R_hat{i}'*(w{i-1}+dq{i}*e*(1-J{i})); %#ok<*SAGROW>
    a{i}=R_hat{i}'*(a{i-1}+(ddq{i}*e+dq{i}*cross(w{i-1},e)*(1-J{i})));
    ab{i}=cross(a{i},P_star{i})+cross(w{i},cross(w{i},P_star{i}))+R_hat{i}'*(ab{i-1});
    ag{i}=ab{i}+cross(a{i},G{i})+cross(w{i},cross(w{i},G{i}));
end

% Simplify symbolic equations.
if strcmpi(class(ab{1}),'sym')
    for i=2:n
        w{i}=simplify(w{i});
        a{i}=simplify(a{i});
        ab{i}=simplify(ab{i});
        ag{i}=simplify(ag{i});
    end
end

% Forces and torques
%%
for i=n:-1:2
    F{i}=R_hat{i}*F{i+1}+m{i}*ag{i};
    M{i}=I{i}*a{i}+cross(w{i},I{i}*w{i});
    T{i}=R_hat{i}*T{i+1}+cross(P_star{i},R_hat{i+1}*F{i+1})+ ...
            cross(m{i}*(P_star{i}+G{i}),ag{i})+M{i};
    D{i}=dot(R_hat{i}'*F{i},e*J{i})+dot(R_hat{i}'*T{i},e*(1-J{i}));
end