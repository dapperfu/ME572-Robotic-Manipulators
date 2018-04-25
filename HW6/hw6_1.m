% syms theta1 s2 theta3 a b
clear all
s2=3;
theta1=330*pi/180;
theta3=80*pi/180;
a=3;
b=3;
syms theta1 theta3 s2 l1 l2
syms dTheta1 dTheta3 dS2
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
Tw=simplify(phi1*T1*phi2*T2*phi3*T3);

fid=fopen('Tw.tex','w');
fprintf(fid,'\\begin{eqnarray}');
tmp=mat2latex(Tw);
Tm_latex=strrep(tmp,'s2','s_2');
fprintf(fid,'T_w&=&%s',Tm_latex);
fprintf('%s\n',Tm_latex);
fprintf(fid,'\\end{eqnarray}');
fclose(fid);fclose all;
%%
dTw=simplify(...
    dTheta1*diff(phi1)*T1*phi2      *T2           *phi3*T3 ...
   +dS2    *phi1      *T1*diff(phi2)*T2           *phi3*T3 ...
   +dTheta3*phi1      *T1*phi2      *T2*diff(phi3)*T3);

dTw2=simplify(...
     dTheta1*dQr*phi1*T1*phi2*T2*phi3*T3 ...
    +dS2    *phi1*T1*dQp*phi2*T2*phi3*T3 ...
    +dTheta3*phi1*T1*phi2*T2*dQr*phi3*T3);
%%
Pe=Tw(1:3,4);
i1=eye(4);
an1=i1(1:3,3);
P=(Pe-i1(1:3,4));
J(:,1)=simplify([cross(an1,P);an1])
%%
Pe=Tw(1:3,4);
i1=phi1*T1;
an1=i1(1:3,3);
J(:,2)=[an1;0;0;0];
%%
Pe=Tw(1:3,4);
i1=phi1*T1*phi2*T2;
an1=i1(1:3,3);
P=(Pe-i1(1:3,4));
J(:,3)=simplify([cross(an1,P);an1])
%%
Qa=simplify(J*[dTheta1;dS2;dTheta3])
Qb=simplify(dTw(1:3,4));
Q=[Qa [Qb;0;0;0]];
%%
fid=fopen('J.tex','w');
fprintf(fid,'\\begin{eqnarray}');
tmp=mat2latex(J);
J_latex=strrep(tmp,'s2','s_2');
fprintf(fid,'J&=&%s',J_latex);
fprintf('%s\n',J_latex);
fprintf(fid,'\\end{eqnarray}');
fclose(fid);fclose all;