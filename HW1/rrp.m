clear;
length1=4;   % in
length2=2;   % in
length3=0.5; %in
theta1=([-90:90])';
theta2=([90])';
theta3=([atan(0.5)*180/pi+90])';
l1=length(theta1);
l2=length(theta2);
l3=length(theta3);
L=l1*l2*l3;

[T1,T2,T3]=meshgrid(theta1,theta2,theta3);
T2=T1+T2;
T3=T2+T3;
%%
T1=reshape(T1,L,1);
T2=reshape(T2,L,1);
T3=reshape(T3,L,1);
%%
X1=cosd(T1).*length1;
Y1=sind(T1).*length1;
X2=cosd(T2).*length2;
Y2=sind(T2).*length2;
X3=cosd(T3).*length3;
Y3=sind(T3).*length3;
%%
XX=[zeros(L,1) X1 X1+X2 X1+X2+X3];
YY=[zeros(L,1) Y1 Y1+Y2 Y1+Y2+Y3];
Px=XX(:,end);
Py=YY(:,end);
P=sqrt(Px.^2+Py.^2);

% 0.5 is shortest   & 4 is the longest. 0.5<=P<=4
l1=(0.5+4<=2+P)&(P<=4)&(0.5<=P);
% P is the shortest & 4 is the longest.      P<=0.5
l2=(P+4<=0.5+2)&(P<=0.5);
% P is the longest & 0.5 is the shortest.    P>=4
l3=(P+0.5<=4+2)&(P>=4);

% Pxo=Px(l);
% Pyo=Py(l);
%%
% save('workspaceData.mat','Px','Py','XX','YY','P');
% figure(1);
clf
plot(XX',YY','r-',XX(:,1:end-1)',YY(:,1:end-1)','b.',Px,Py,'ko');
% figure(2);
% clf;
% plot(Px,Py,'.b',Px(l2),Py(l2),'r.')%,Px(~l2),Py(~l2),'k.',Px(~l3),Py(~l3),'g.');
xlabel('X-axis end position (in)');
ylabel('Y-axis end position (in)');
title('Planar Manipulator Workspace');
% legend('Full Workspace','Orientation Workspace');

axis([-6.5 6.5 -6.5 6.5])