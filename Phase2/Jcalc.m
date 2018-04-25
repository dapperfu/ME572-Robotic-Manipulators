function J=Jcalc(robotType,Q)
[jointType,~]=shape(robotType);
[Tm,n]=Tworld(robotType,Q);
% Get the final P position.
Pe=Tm{end}(1:3,4);
% For each link find out the Jacobian column.
for i=1:n
    switch jointType(i)
        case 0, % Rotation joint
            an=Tm{i}(1:3,3);
            Pn=Tm{i}(1:3,4);
            J(:,i)=[cross(an,Pe-Pn);an];
        case 1, % Prismatic joint
            an=Tm{i}(1:3,3);
            J(:,i)=[an;0;0;0];
        otherwise,
            error('Unknown joint type %d',jointType(i))
    end
end
% Clean up symbolic stuff to make it more readable.
if ~isnumeric(J)
    J=simplify(J);
end
end