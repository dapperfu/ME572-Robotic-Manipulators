function [delta_u1,delta_u2]=delta_function_temp(links)
length_1=links.length_1;
angle_1=links.angle_1;
length_2=links.length_2;
angle_2=links.angle_2;
length_3=links.length_3;
angle_3=links.angle_3;
length_4=links.length_4;
angle_4=links.angle_4;
length_5=0;
angle_5=0;
length_6=0;
angle_6=0;
length_7=0;
angle_7=0;
length_8=0;
angle_8=0;
length_9=0;
angle_9=0;
length_10=0;
angle_10=0;
% Static delta function with unknown variables: angle_2 & angle_3
delta_u1=-(length_3.*sin(angle_3).*(length_1.*sin(angle_1) + length_2.*sin(angle_2) + length_3.*sin(angle_3) + length_4.*sin(angle_4) + length_5.*sin(angle_5) + length_6.*sin(angle_6) + length_7.*sin(angle_7) + length_8.*sin(angle_8) + length_9.*sin(angle_9) + length_10.*sin(angle_10)) + length_3.*cos(angle_3).*(length_1.*cos(angle_1) + length_2.*cos(angle_2) + length_3.*cos(angle_3) + length_4.*cos(angle_4) + length_5.*cos(angle_5) + length_6.*cos(angle_6) + length_7.*cos(angle_7) + length_8.*cos(angle_8) + length_9.*cos(angle_9) + length_10.*cos(angle_10)))./(length_2.*length_3.*cos(angle_2).*sin(angle_3) - length_2.*length_3.*cos(angle_3).*sin(angle_2));
delta_u2=(length_2.*sin(angle_2).*(length_1.*sin(angle_1) + length_2.*sin(angle_2) + length_3.*sin(angle_3) + length_4.*sin(angle_4) + length_5.*sin(angle_5) + length_6.*sin(angle_6) + length_7.*sin(angle_7) + length_8.*sin(angle_8) + length_9.*sin(angle_9) + length_10.*sin(angle_10)) + length_2.*cos(angle_2).*(length_1.*cos(angle_1) + length_2.*cos(angle_2) + length_3.*cos(angle_3) + length_4.*cos(angle_4) + length_5.*cos(angle_5) + length_6.*cos(angle_6) + length_7.*cos(angle_7) + length_8.*cos(angle_8) + length_9.*cos(angle_9) + length_10.*cos(angle_10)))./(length_2.*length_3.*cos(angle_2).*sin(angle_3) - length_2.*length_3.*cos(angle_3).*sin(angle_2));
end
