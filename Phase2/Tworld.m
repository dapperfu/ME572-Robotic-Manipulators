function [Tm,n]=Tworld(robotType,Q)
% This us used so often, make it a new function.

% Get data from the shape matrix.
[jointType,T]=shape(robotType);
n=length(jointType);
if length(Q)<n % Number of input variables has to be the same as the number of transforms.
    error('Incorrect number of input parameters. There are %d joints but only %d variables specified',n,length(Q));
end
Tm=cell(1,n+1); % Empty cell array for speed. 
Tm{1}=eye(4); % Initial one is an identity. Because of Matlab's 1 indexing everything is actually n-1.
for j=1:length(jointType)
    switch jointType(j)
        case 0,
            phi=phiR(Q(j));
        case 1,
            phi=phiP(Q(j));
        otherwise,
            error('Unknown joint type %d',jointType(j))
    end
    % Find each intermediate transform matrix.
    Tm{j+1}=Tm{j}*phi*T{j};
end
end
% Sub functions
function m=phiR(theta)
if isnumeric(theta)
    theta=theta*pi/180;
end
m=[cos(theta) -sin(theta) 0 0
    sin(theta)  cos(theta) 0 0
    0            0           1 0
    0            0           0 1];
end
function m=phiP(X)
m=[1 0 0 0
    0 1 0 0
    0 0 1 X
    0 0 0 1];
end