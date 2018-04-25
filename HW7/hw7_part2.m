% clear all
% clc;
syms theta1 theta2 dTheta1 dTheta2 real
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
% fid=fopen('transforms.tex','w');
% fprintf(fid,'\\begin{eqnarray}\n');
% fprintf(fid,'\\phi_1&=&%s \\\\\n',mat2latex(phi1));
% fprintf(fid,'T_1&=&%s \\\\\n',mat2latex(T1));
% fprintf(fid,'\\phi_2&=&%s \\\\\n',mat2latex(phi2));
% fprintf(fid,'T_2&=&%s \\\\\n',mat2latex(T2));
% fprintf(fid,'T_w&=&%s \n',mat2latex(Tw));
% fprintf(fid,'\\end{eqnarray}\n');
% fclose(fid);
% 
% fid=fopen('transforms2.tex','w');
% fprintf(fid,'\\begin{eqnarray}\n');
% fprintf(fid,'x&=&%s \\\\\n',mat2latex(Tw(1,4)));
% fprintf(fid,'y&=&%s \n',mat2latex(Tw(2,4)));
% fprintf(fid,'\\end{eqnarray}\n');
% fclose(fid);
%%
% fid=fopen('JacobianParts.tex','w');
% fprintf(fid,'\\begin{eqnarray}\n');

Pe=Tw(1:3,4);
i0=eye(4);
an0=i0(1:3,3);
P0=(Pe-i0(1:3,4));
J(:,1)=simplify([cross(an0,P0);an0]);
%%
Pe=Tw(1:3,4);
i1=phi1*T1;
an1=i1(1:3,3);
P1=(Pe-i1(1:3,4));
J(:,2)=simplify([cross(an1,P1);an1])
% fprintf(fid,'P_e&=&%s \\\\ \n',mat2latex(Pe));
% fprintf(fid,'a_0&=&%s \\\\ \n',mat2latex(an0));
% fprintf(fid,'P_0&=&%s \\\\ \n',mat2latex(P0));
% fprintf(fid,'a_1&=&%s \\\\ \n',mat2latex(an1));
% fprintf(fid,'P_1&=&%s \\\\ \n',mat2latex(P1));
% fprintf(fid,'J&=&%s \n',mat2latex(simplify(J)));
% fprintf(fid,'\\end{eqnarray}\n');
% fclose(fid);
%%
% Jtop=simplify(J(1:2,1:2));
% JtopT=Jtop';
% B=Jtop*JtopT;
% Binv=simplify(B^-1);
% fid=fopen('JTop.tex','w');
% fprintf(fid,'\\begin{eqnarray}\n');
% fprintf(fid,'J_{top}&=&%s \\\\\n',mat2latex(Jtop));
% fprintf(fid,'B^{-1}&=&(J_{top}J_{top}^T)^{-1} \\\\ \n')
% fprintf(fid,'B^{-1}_{(1,1)}&=&%s \\\\ \n',mat2latex(simplify(Binv(1,1))))
% fprintf(fid,'B^{-1}_{(1,2)}&=&%s \\\\ \n',mat2latex(simplify(Binv(1,2))))
% fprintf(fid,'B^{-1}_{(2,1)}&=&%s \\\\ \n',mat2latex(simplify(Binv(2,1))))
% fprintf(fid,'B^{-1}_{(2,2)}&=&%s \\ \n',mat2latex(simplify(Binv(2,2))))
% fprintf(fid,'\\end{eqnarray}\n');
% fclose(fid);
%%
% % Jtop
% Jf=subs(Jtop,{'theta1','theta2'},{81.4686*pi/180,197.2539*pi/180})
% B1=subs(Binv,{'theta1','theta2'},{81.4686*pi/180,197.2539*pi/180})
% J_r=subs(J,{'theta1','theta2'},{81.4686*pi/180,197.2539*pi/180});
% [R1,L1]=eigs(B1);
% R1=R1*sign(R1(1,1));
% Beta1=acos(R1(1,1))*180/pi;
% ax1=1/sqrt(L1(1,1));
% by1=1/sqrt(L1(2,2));
% cz1=1/sqrt(L1(3,3))

%%
% % fid=fopen('Ellipsoid.tex','w');
% % fprintf(fid,'\\begin{eqnarray}\n');
% 
% % fprintf(fid,'\\end{eqnarray}\n');
% % fclose(fid);