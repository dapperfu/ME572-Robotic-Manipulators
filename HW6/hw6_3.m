clc; clear all
load J
syms Xp Yp omegaz
J=J([1,2,6],:);
Ji=inv(J);
X=simplify(det([[Xp;Yp;omegaz] J(:,2:3)])/det(J));
Y=simplify(det([J(:,1) [Xp;Yp;omegaz] J(:,3)])/det(J));
w=simplify(det([J(:,1:2) [Xp;Yp;omegaz]])/det(J));
Xl=latex(X);
Yl=latex(Y);
wl=latex(w);


srch={'Xp','Yp','omega','theta','s2'};
repl={'X_p','Y_p','\omega_','\theta_','S_2'};
for i=1:numel(srch)
    Xl=strrep(Xl,srch{i},repl{i});
    Yl=strrep(Yl,srch{i},repl{i});
    wl=strrep(wl,srch{i},repl{i});
end
fid=fopen('soln.tex','w');
fprintf(fid,'\\dot{\\theta_1}&=&%s %s \\\\ \n',Xl,'\label{Xp}');
fprintf(fid,'\\dot{S_2}&=&%s %s \\\\ \n',Yl,'\label{Yp}');
fprintf(fid,'\\dot{\\theta_3}&=&%s %s\n',wl,'\label{wp}');
fclose(fid);
fclose all;