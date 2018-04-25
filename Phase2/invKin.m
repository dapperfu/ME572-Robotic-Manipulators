function varargout=invKin(robotType,P)
if size(P,1)>1
    px=P(:,1);
    py=P(:,2);
    if size(P,2)==3
        pz=P(:,3);
    end
else
    px=P(1);
    py=P(2);
    if size(P,2)==3
        pz=P(3);
    end
end
switch robotType
    case 'RRR',
        %  Inverse Kinematics for device #1 from homework #4
        %  Cartesian values are px, py, pz  (Input)
        %  Joint values are th1, th2, th3   (Output)   Note: units are radians
        %  L1, L2, L3, and d1 are link lengths
        L1 = 5;
        L2 = 5;
        L3 = 4;
        d1 = 4;
        %
        e = (px.*px + py.*py);
        %
        th1 = atan2(py,px) - acos(d1./sqrt(e));
        %
        a = px-d1.*cos(th1);
        b = py-d1.*sin(th1);
        c = pz-L1;
        d = px.*sin(th1) -py.*cos(th1);
        %
        th3 = acos((a.*a + b.*b + c.*c - L2.*L2 - L3.*L3)./(2.*L2.*L3));
        %
        num=d.*(L2+L3.*cos(th3))-c.*L3.*sin(th3);
        denom=c.*(L2+L3.*cos(th3))+d.*L3.*sin(th3);
        th2 = atan2(num,denom);
        %% Outputs
        th1=wrapTo360(th1.*180./pi);
        th2=wrapTo360(th2.*180./pi);
        th3=wrapTo360(th3.*180./pi);
    case 'RR',
        % Inverse Kinematics for planar RR robot (from homework #7)
        %  Cartesian values are px, py, pz  (Input)
        %  Joint values are th1, th2, th3   (Output)   Note: units are radians
        %  Also note that th3 is always zero since this is a 2 link robot
        %  L1 and L2 are link lengths
        L1 = 20;
        L2 = 20;
        %
        a = (px.*px + py.*py + L1.*L1 - L2.*L2)./(2.*L1);
        b = sqrt(px.*px + py.*py);
        %
        th1 = atan2(py,px) + acos(a./b);
        %
        num=py-L1.*sin(th1);
        denom=px-L1.*cos(th1);
        th2 = atan2(num,denom) - th1;
        %% Outputs
        th1=wrapTo360(th1.*180./pi);
        th2=wrapTo360(th2.*180./pi);
        th3=zeros(size(th1));
end
if nargout<=1
    varargout{1}=[th1 th2 th3];
elseif nargout==2
    varargout{1}=th1;
    varargout{2}=th2;
elseif nargout==3
    varargout{1}=th1;
    varargout{2}=th2;
    varargout{3}=th3;
else
    error('Incorrect number of outputs')
end
end