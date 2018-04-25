function [X,V,dX]=trajPlanner(X0,Xf,Tf,dt,accel_steps,decel_steps)
% Calculate the number of steps
steps=Tf./dt;
% Figure out the number of center (constant velocity) steps.
center_steps=steps-accel_steps-decel_steps;
% Calculate A star for a linear system.
steps_mod=(accel_steps+2*center_steps+decel_steps)/2;
A_star=(Xf-X0)/steps_mod;
% Calculate the percentage of A_star.
dA=((1:accel_steps)-.5)./accel_steps;
dD=((decel_steps:-1:1)-.5)./decel_steps;
% Create area of percentages of A_star
percentA=[0 dA ones(1,center_steps) dD]';
% Calculate the area (and thus dX for each step)
dX=percentA.*A_star;
% Sum up the changes and finding incremental X.
X=cumsum(dX)+X0;
% Calculate V_max
V_max=A_star./dt;
% Instantaneous velocity
V=[linspace(0,V_max,accel_steps+1) V_max.*ones(1,center_steps-1) linspace(V_max,0,decel_steps+1)]';
end
