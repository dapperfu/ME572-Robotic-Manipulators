function err=seekfcn(theta1,S2,theta3)
theta1=theta1*pi/180;
theta3=theta3*pi/180;
Tw=rpr(theta1,3,S2,theta3,3);
nx=Tw(1,1);
ny=Tw(2,1);
ax=Tw(1,3);
ay=Tw(2,3);
Px=Tw(2,4);
Py=Tw(2,4);

err=sqrt(nx^2+ny^2+ax^2+ay^2+Px^2+Py^2);