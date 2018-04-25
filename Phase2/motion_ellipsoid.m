function [beta,ax,by,p]=motion_ellipsoid(theta1,theta2)
[eigen_vec,eigen_value]=eigs(B_inv(theta1,theta2));
beta=acos(eigen_vec(1,1))*180/pi;
ax=1/sqrt(eigen_value(1,1));
by=1/sqrt(eigen_value(2,2));
p = calculateEllipse(0, 0, ax, by, beta);