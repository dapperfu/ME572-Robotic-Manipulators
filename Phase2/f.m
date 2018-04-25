function z = f(t,T)
Ts = T(1);
Tg = T(2);
Cs = 5123891.5;
Cg = 5888470;
air = 1200;
tt = 0.7;
Rs = .0326;
Rg = .003214;
const = (2*pi)/(86400);
Ta = 12.5 + 7.5*sin(const*t - pi/2);
Hg = 36.232;
Ig = max(0,1000*sin((pi/12)*(t/3600-6)));
if (t > 36000) && (t < 54000)
    F = 0.1;
elseif (t > 122400) && (t < 140400)
    F = 0.1;
elseif (t > 208800) && (t < 226800)
    F = 0.1;
elseif (t > 295200) && (t < 313200)
    F = 0.1;
elseif (t > 381600) && (t < 399600)
    F = 0.1;
elseif (t > 468000) && (t < 486000)
    F = 0.1;
elseif (t > 544400) && (t < 572400)
    F = 0.1;
elseif (t > 640800) && (t < 658800)
    F = 0.1;
elseif (t > 727200) && (t < 745200)
    F = 0.1;
elseif (t > 813600) && (t < 831600)
    F = 0.1;
elseif (t > 900000) && (t < 918000)
    F = 0.1;
else
    F = 0 ;
end
z = [F*air*Tg - F*air*Ts + (1/Rs)*(Ts-Ta)/Cs ; (tt*Ig*Hg+F*air*Ts-F*air*Tg-(1/Rg)*(Tg-Ta))/Cg];
return