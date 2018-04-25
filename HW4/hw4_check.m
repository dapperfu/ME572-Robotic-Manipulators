function Tm=hw4_check(theta1,theta2,theta3)
theta1=theta1*pi/180;
theta2=theta2*pi/180;
theta3=theta3*pi/180;
L1=5;
L2=5;
d1=4;
L3=4;
% phi1=rotJoint(theta1);
% T1  =[0 0 1 d1
%     1 0 0 0
%     0 1 0 L1
%     0 0 0 1];
% 
% phi2=rotJoint(theta2);
% T2  =[0 1 0 0
%     0 0 1 0
%     1 0 0 0
%     0 0 0 1];
% 
% phi3=prizJoint(S3);
% T3  =[1 0 0 0
%     0 1 0 0
%     0 0 1 0
%     0 0 0 1];
% Tm=(phi1*T1*phi2*T2*phi3*T3);
% Tm=Tm(1:3,4);
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
Tm=((phi1*T1*phi2*T2*phi3*T3));
Tm=Tm(1:3,4);
