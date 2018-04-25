syms rx ry rz
syms A
syms B
syms P
A=asin(ry/sqrt(ry^2+rz^2));
B=rx;
x=2;
y=1;
z=-1;
N=sqrt(x^2+y^2+z^2);
x=x/N;
y=y/N;
z=z/N;
alpha=acos(z/sqrt(y^2+z^2));
beta=acos(sqrt(y^2+z^2)/sqrt(x^2+y^2+z^2));
beta=asin(x);
phi=30*pi/180;

%R=rotx(-alpha)*roty(beta)*rotz(phi)*roty(-beta)*rotx(alpha)
R=simplify(rotx(-A)*roty(B)*rotz(P)*roty(-B)*rotx(A))
%subs(R,{A,B,P},[alpha,beta,phi])
