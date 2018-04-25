clc; clear all
load J
Jp=subs(J,{'theta1','s2','theta3'},{330*pi/180,3,80*pi/180});
Jp2=Jp([1,2,6],:);
J_inv=Jp2^-1;
fid=fopen('J2.tex','w');
fprintf(fid,'J&=&%s \\label{Jp} \\\\ \n',mat2latex(Jp,'%.3f'));
fprintf(fid,'J&=&%s \\label{Jp3} \\\\ \n',mat2latex(Jp2,'%.3f'));
fprintf(fid,'J^{-1}&=&%s \\label{Jp3} \\\\ \n',mat2latex(J_inv,'%.3f'));
fclose(fid);

fid=fopen('part2.tex','w');
SolnA=Jp2*[5,-4,-2]';
SolnB=J_inv*[-2,5,-3]';
fprintf(fid,'%s&=&%s \\label{parta} \\\\ \n','\begin{Bmatrix}\dot{X_p} \\ \dot{Y_p} \\ \dot{\omega_z}\end{Bmatrix}',mat2latex(SolnA,'%.3f'));
fprintf(fid,'%s&=&%s \\label{partb} \\\\ \n','\begin{Bmatrix}\dot{\theta_1} \\ \dot{S_2} \\ \dot{\theta_3}\end{Bmatrix}',mat2latex(SolnB,'%.3f'));
fclose(fid);