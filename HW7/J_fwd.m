function [vx,vy]=J_fwd(theta1,theta2,dT1,dT2)
theta1=theta1.*pi./180;
theta2=theta2.*pi./180;
dT1=dT1.*pi./180;
dT2=dT2.*pi./180;
vx=-20.*dT2.*sin(theta1 + theta2) - dT1.*(20.*sin(theta1 + theta2) + 20.*sin(theta1));
vy=dT1.*(20.*cos(theta1 + theta2) + 20.*cos(theta1)) + 20.*dT2.*cos(theta1 + theta2);