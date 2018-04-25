function Tm=hw4(theta1,theta2,S3)
L1=5;
d1=4;

Px=d1*cosd(theta1)+S3*sind(theta1)*sind(theta2);
Py=d1*sind(theta1)-S3*cosd(theta1)*sind(theta2);
Pz=L1+S3*cosd(theta2);

Tm=[cosd(theta1) -cosd(theta2)*sind(theta1)  sind(theta1)*sind(theta2) Px
    sind(theta1)  cosd(theta1)*cosd(theta2) -cosd(theta1)*sind(theta2) Py
    0             sind(theta2)               cosd(theta2)              Pz
    0             0                          0                          1];