function Tw=RPR(theta1,l1,s2,theta3,l3)

Tw=[ cos(theta1 + theta3), 0,  sin(theta1 + theta3), l3.*sin(theta1 + theta3) + l1.*cos(theta1) + s2.*sin(theta1);
     sin(theta1 + theta3), 0, -cos(theta1 + theta3), l1.*sin(theta1) - s2.*cos(theta1) - l3.*cos(theta1 + theta3);
                    0, 1,                     0,                                                         0;
                   0, 0,                     0,                                                         1];