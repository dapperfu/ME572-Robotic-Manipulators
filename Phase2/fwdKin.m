function varargout=fwdKin(robotType,Q)
Tm=Tworld(robotType,Q);
Px=Tm{end}(1,4);
Py=Tm{end}(2,4);
Pz=Tm{end}(3,4);
if nargout<=1
    varargout={[Px Py Pz]'};
elseif nargout==3
    varargout={Px Py Pz};
end
end