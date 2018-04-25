% syms theta1 s2 theta3 a b
% s2=2;
% theta1=pi/2;
% theta3=0;
a=3;
b=3;
syms theta1 theta3 s2 Px Py nx ny ax ay real;
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
  
%mat2latex(phi1,'\phi_1')
%mat2latex(T1,'T_1')
%mat2latex(phi2,'\phi_1')
%mat2latex(T2,'T_2')
%mat2latex(phi3,'\phi_3')
%mat2latex(T3,'\T_3')
Tw=phi1*T1*phi2*T2*phi3*T3;
Tw=simplify(Tw);

%mat2latex(Tw,'T_w');
% Sanity Checks
% s2=2;
% theta1=pi/2;
% theta3=0;
% a=3;
% b=3;

% A01=[0 0 1 0
%  0 1 0 a
%  -1 0 0 0
%  0 0 0 1]
% A02=[1 0 0 s2
%  0 1 0 a
%  0 0 1 0
%  0 0 0 1]
% A03=[0 0 1 s2+b
%  1 0 0 a
%  0 1 0 0
%  0 0 0 1]
 %mat2latex(A01,'{}^0A_1');
 %mat2latex(A02,'{}^0A_2');
 %mat2latex(A03,'{}^0A_3');
 