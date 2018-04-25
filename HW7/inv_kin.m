function [theta1,theta2]=inv_kin(x,y)
l1=20;
l2=20;

theta1=atan2(y,x)+acos((l1.^2 - l2.^2 + x.^2 + y.^2)./(2.*l1.*sqrt(x.^2 + y.^2)));
theta2=atan2(y-l1.*sin(theta1),(x-l1.*cos(theta1)))-theta1;

theta1=wrapTo360(rad2deg(theta1));
theta2=wrapTo360(rad2deg(theta2));