function [x,y,x1,y1]=fwd_kin(theta1,theta2)
x=20.*cosd(theta1+theta2)+20.*cosd(theta1);
y=20.*sind(theta1+theta2)+20.*sind(theta1);
x1=20*cosd(theta1);
y1=20*sind(theta1);