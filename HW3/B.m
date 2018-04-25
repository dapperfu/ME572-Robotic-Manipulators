
theta1=pi/2;
l1=3;
S2=2;
l2=3;
theta3=0;
Trans=[  0,   1,  0,   0;
1,   0,  0,   0;
S2,  11, l2,   0;
l1, -S2,  0, -l2];

M=[sin(theta1);cos(theta1);sin(theta1+theta3);cos(theta1+theta3)];

A=Trans*M;

[A(1) 0 A(2) A(3);
 A(2) 0 -A(1) A(3);
    0 1 0 0;
    0 0 0 1]