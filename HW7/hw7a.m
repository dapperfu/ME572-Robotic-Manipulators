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
[theta1,dTheta1,A_star1,w1]=trajPlanner(theta1_0,theta1_f,points,accel_points,accel_points,dt);
[theta2,dTheta2,A_star2,w2]=trajPlanner(theta2_0,theta2_f,points,accel_points,accel_points,dt);
[X_jim,Y_jim]=fwd_kin(theta1,theta2);

% Cartesian interpolated motion
[Px,dPx,A_star3,Vx]=trajPlanner(Px_0,Px_f,points,accel_points,accel_points,dt);
[Py,dPy,A_star4,Vy]=trajPlanner(Py_0,Py_f,points,accel_points,accel_points,dt);
[theta1_cim,theta2_cim]=inv_kin(Px,Py);

t=linspace(0,0.5,points+1);
close all;
% %
% figure(1);
% %
% plot(t,X_jim,t,Y_jim,t,Px,t,Py);
% legend('JIM: X','JIM: Y','CIM: X','CIM: Y','location','northeast')
% xlabel('Time (s)');
% ylabel('Position');
% title('X & Y Positions vs Time for CIM & JIM')
% print -depsc2 EndPosition
% %
% figure(2);
% %
% plot(t,theta1,t,theta2,t,theta1_cim,t,theta2_cim);
% legend('JIM: \theta_1','JIM: \theta_2','CIM: \theta_1','CIM: \theta_2','location','southeast')
% xlabel('Time (s)');
% ylabel('Angle (^o)');
% title('Joint Angles \theta_1 & \theta_2 vs Time for CIM & JIM')
% print -depsc2 JointAngles
% %
% figure(3)
% %
% plot(t,[0;diff(X_jim)/dt],t,[0;diff(Y_jim)/dt],t,[0;diff(Px)/dt],t,[0;diff(Py)/dt]);
% legend('JIM: V_X','JIM: V_Y','CIM: V_X','CIM: V_Y','location','northeast')
% xlabel('Time (s)');
% ylabel('Velocity (1/s)');
% title('X & Y Velocity vs Time for CIM & JIM')
% print -depsc2 EEVel
% %
% figure(4)
% %
% plot(t,[0;diff(theta1)/dt],t,[0;diff(theta2)/dt],t,[0;diff(theta1_cim)/dt],t,[0;diff(theta2_cim)/dt]);
% legend('JIM: \omega_1','JIM: \omega_2','CIM: \omega_1','CIM: \omega_2','location','northeast')
% xlabel('Time (s)');
% ylabel('Angle Velocity (^o/s)');
% title('Joint Angle Velocity \omega_1 & \omega_2 vs Time for CIM & JIM')
% print -depsc2 AngleVel
% %
% figure(5)
% 
% plot(t,[0;diff(theta1)/dt],t,[0;diff(theta2)/dt],t,[0;diff(theta1_cim)/dt],t,[0;diff(theta2_cim)/dt]);
% legend('JIM: \omega_1','JIM: \omega_2','CIM: \omega_1','CIM: \omega_2','location','northeast')
% xlabel('Time (s)');
% ylabel('Angle Velocity (^o/s)');
% title({'Joint Angle Velocity \omega_1 & \omega_2 vs Time for CIM & JIM','Zoomed in to see other angular velocities'})
% axis([0 .5 -70 4.5e+02])
% print -depsc2 AngleVel2
%%
figure(6)
%%
[x2,y2,x1,y1]=fwd_kin(theta1,theta2);
XX=[zeros(size(Px'));x1';x2'];
YY=[zeros(size(Py'));y1';y2'];
plot(XX(3,:),YY(3,:),'*r');
hold on
plot(XX(:,1),YY(:,1),'b');
plot(XX,YY,'b','HandleVisibility','off');
hold on
plot(XX(2,:),YY(2,:),'og');
legend('End Effector','Linkages','Joint','location','NorthEast');
axis([-20 20 -20 20]);
title('Joint Interpolated Motion');
xlabel('X');
ylabel('Y');
print -depsc2 EndEffectorJIM
%%
figure(7)
%%
[x2,y2,x1,y1]=fwd_kin(theta1_cim,theta2_cim);
XX=[zeros(size(Px'));x1';x2'];
YY=[zeros(size(Py'));y1';y2'];
plot(XX(3,:),YY(3,:),'*r'); hold on
plot(XX(:,1),YY(:,1),'b');
plot(XX,YY,'b','HandleVisibility','off');
plot(XX(2,:),YY(2,:),'og');
legend('End Effector','Linkages','Joint','location','NorthEast');
axis([-20 20 -20 20]);
title('Cartesian Interpolated Motion');
xlabel('X');
ylabel('Y');
print -depsc2 EndEffectorCIM
%%
figure(8);
%%
clf
% JIM
[x2,y2,x1,y1]=fwd_kin(theta1,theta2);
XX1=[zeros(size(Px'));x1';x2'];
YY1=[zeros(size(Py'));y1';y2'];
% CIM 
[x2,y2,x1,y1]=fwd_kin(theta1_cim,theta2_cim);
XX=[zeros(size(Px'));x1';x2'];
YY=[zeros(size(Py'));y1';y2'];
% Plot the linkages first:
plot(XX1(:,1),YY1(:,1),'c'); hold on
plot(XX(:,1),YY(:,1),'b');
plot(XX1,YY1,'c','HandleVisibility','off');
plot(XX,YY,'b','HandleVisibility','off');
% Now plot end effector
plot(XX1(3,:),YY1(3,:),'*r');
plot(XX(3,:),YY(3,:),'*k');
legend('JIM: Linkages','CIM: Linkages','JIM: End Effector','CIM: End Effector','location','NorthEast');
axis([-20 20 -20 20]);
title('Joint vs Cartesian Interpolated Motion');
xlabel('X');
ylabel('Y');
print -depsc2 EndEffectorBoth;