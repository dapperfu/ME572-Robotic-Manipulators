% Robot parameters
Px_0=6;
Px_f=-4;
Py_0=0.01;
Py_f=0.01;
% Inverse kinematics for angles
[theta1_0,theta2_0]=inv_kin(Px_0,Py_0);
[theta1_f,theta2_f]=inv_kin(Px_f,Py_f);
%%
t_f=0.5; % Final time
accel_time=.05; % Time needed to accel
points=20; % Number of points
dt=0.5/points; % Time between points
accel_points=accel_time/(t_f/points); % Number of acceleration points
% Decel points are same as accel points

% Joint interpolated motion
[theta1_jim,w1_jim,w1_max_jim]=trajPlanner(theta1_0,theta1_f,points,accel_points,accel_points,dt);
[theta2_jim,w2_jim,w2_max_jim]=trajPlanner(theta2_0,theta2_f,points,accel_points,accel_points,dt);
[X_jim,Y_jim]=fwd_kin(theta1_jim,theta2_jim);
[Vx_jim,Vy_jim]=J_fwd(theta1_jim,theta2_jim,w1_jim,w2_jim);

% Cartesian interpolated motion
[X_cim,Vx_cim,Vx_max_cim]=trajPlanner(Px_0,Px_f,points,accel_points,accel_points,dt);
[Y_cim,Vy_cim,Vy_max_cim]=trajPlanner(Py_0,Py_f,points,accel_points,accel_points,dt);
[theta1_cim,theta2_cim]=inv_kin(X_cim,Y_cim);
[w1_cim,w2_cim]=J_inv(theta1_cim,theta2_cim,Vx_cim,Vy_cim);

t=linspace(0,0.5,points+1);
close all;
% figure(1)
% plot(t,X_jim,t,Y_jim,t,X_cim,t,Y_cim)
% figure(2)
% plot(t,theta1_jim,t,theta2_jim,t,theta1_cim,t,theta2_cim)
% figure(3)
% plot(t,Vx_jim,t,Vy_jim,t,Vx_cim,t,Vy_cim)
% figure(4)
% plot(t,w1_jim,t,w2_jim,t,w1_cim,t,w2_cim)

i=find(w1_cim==max(w1_cim));
% for i=1:points+1
[beta,ax,by,p]=motion_ellipsoid(theta1_cim(i),theta2_cim(i));
fid=fopen('Results.tex','w');
fprintf(fid,'\\begin{eqnarray}\n');
fprintf(fid,'\\theta_1 &=& %f \\\\ \n',theta1_cim(i));
fprintf(fid,'\\theta_2 &=& %f \\\\ \n',theta2_cim(i));
fprintf(fid,'a_x &=& %f \\\\ \n',ax);
fprintf(fid,'b_y &=& %f \\\\ \n',by);
fprintf(fid,'\\beta &=& %f \n',beta);
fprintf(fid,'\\end{eqnarray}\n');
fclose(fid);
plot(p(:,1), p(:,2)),hold all, axis equal
rotAxis(beta,'b--');
hline(0,'r-');
vline(0,'r-');
legend('Ellipsoid','x'' & y''');
print -depsc2 Ellipsoid1
%%
l={};
clf;
set(gca,'ColorOrder',varycolor(13));
hold all
for i=1:13
    [beta,ax,by,p]=motion_ellipsoid(theta1_cim(i),theta2_cim(i));
    plot(p(:,1), p(:,2));
    l=[l {sprintf('\\theta_1=%.2f \\theta_2=%.2f',theta1_cim(i),theta2_cim(i))}];
end
 axis square
title('Cartesian Interpolated Motion Steps 0-12')
legend(l,'Location','EastOutside');
print -depsc2 Ellipsoid2

% xlabel('
% a=axis;
% pause(0.5);
% end