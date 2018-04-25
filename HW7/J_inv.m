function [w1,w2]=J_inv(theta1,theta2,dX,dY)
theta1=theta1.*pi./180;
theta2=theta2.*pi./180;
w1=-(dX.*cos(theta1 + theta2))./(20.*(cos(theta1 + theta2).*sin(theta1) - sin(theta1 + theta2).*cos(theta1))) - (dY.*sin(theta1 + theta2))./(20.*(cos(theta1 + theta2).*sin(theta1) - sin(theta1 + theta2).*cos(theta1)));
w2=(dX.*(cos(theta1 + theta2) + cos(theta1)))./(20.*(cos(theta1 + theta2).*sin(theta1) - sin(theta1 + theta2).*cos(theta1))) + (dY.*(sin(theta1 + theta2) + sin(theta1)))./(20.*(cos(theta1 + theta2).*sin(theta1) - sin(theta1 + theta2).*cos(theta1)));
w1=w1.*180./pi;
w2=w2.*180./pi;