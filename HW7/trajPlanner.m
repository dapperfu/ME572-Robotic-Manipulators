function [X,V,V_max,t,dX]=trajPlanner(X0,Xf,steps,accel_steps,decel_steps,dt)
% Figure out the number of center (constant velocity) steps.
center_steps=steps-accel_steps-decel_steps;
% Calculate A star for a linear system.
steps_mod=(accel_steps+2*center_steps+decel_steps)/2;
A_star=(Xf-X0)/steps_mod;

% Calculate the Deltas.
dA=((1:accel_steps)-.5)./accel_steps;
dD=((decel_steps:-1:1)-.5)./decel_steps;
% Calculate the percent of each 
percentA=[0 dA ones(1,center_steps) dD]';
% Calculate the area (and thus delta X for each step)
dX=percentA.*A_star;
% Sum up the changes 
X=cumsum(dX)+X0;

% Calculate max velocity
V_max=A_star./dt;
% Instantaneous velocity
V=[linspace(0,V_max,accel_steps+1) V_max.*ones(1,center_steps-1) linspace(V_max,0,decel_steps+1)]';
t=0:dt:(steps)*dt;
end
