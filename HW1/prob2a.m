clear;
length1=4;   % in
length2=2;   % in
length3=0.5; %in
dTheta=5;
theta1=([-90:90])';
theta2=([-90:90])';
theta3=([-180])';
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
l=(P<=(4+2-0.5)&P>=4)|(P>=(4+0.5-2)&(P>=0.5 & P<=4));
Pxo=Px(l);
Pyo=Py(l);
Po=sqrt(Pxo.^2+Pyo.^2);
%%
% save('workspaceData.mat','Px','Py','XX','YY','P');
% figure(1);
clf;
% plot(XX',YY','r-',XX',YY','b.',Px,Py,'k*');
% figure(2);
% clf;
% hold on;
% plot(Px,Py,'.r');
plot(Px,Py,'.r');
% xlabel('X-axis end position (in)');
% ylabel('Y-axis end position (in)');
% title('Planar Manipulator Workspace');
% legend('Full Workspace','Orientation Workspace');

axis([-6.5 6.5 -6.5 6.5])