x=3;
y=-5;
z=10;

d2d3=4;
d1=5;
a3=4;
a2=5;

q1=acos((x*d2d3+y*sqrt(x^2+y^2-d2d3^2))/(x^2+y^2));

pwh=-sqrt((x-d2d3*cos(q1))^2+(y+d2d3*sin(q1))^2);

pwv=z-d1;

q3=atan2(sqrt(1-((pwh+pwv^2-a2^2-a3^2)/(2*a2*a3))^2),(pwh+pwv^2-a2^2-a3^2)/(2*a2*a3))
q2=atan2((a2+a3*sin(q3))*pwv-cos(q3)*pwh,(a2+a3*sin(q3))*pwh+cos(q3)*pwv)
q1