syms t1
syms t2
syms t3
theta1=60;
theta2=300;
theta3=45;

R1=rotx(t1)
R2=rotz(t2)
R3=roty(t3)

R=R3*R1*R2

subs(R,{t1,t2,t3},[theta1,theta2,theta3]*pi/180)
roty(theta3*pi/180)*rotx(theta1*pi/180)*rotz(theta2*pi/180)
