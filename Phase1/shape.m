function [jointType,T]=shape(robotType)
switch robotType
    case 'RR',
        jointType=[0 0];
        % T1
        T{1}=[1 0 0 20
            0 1 0  0
            0 0 1  0
            0 0 0  1];
        % T2
        T{2}=[1 0 0 20
            0 1 0  0
            0 0 1  0
            0 0 0  1];
        return;
    case 'RRP',
        jointType=[0 0 1];
        % Joint parameters
        L1=5;
        d1=4;
        % T1
        T{1}=[0 0 1 d1
            1 0 0 0
            0 1 0 L1
            0 0 0 1];
        % T2
        T{2}=[0 1 0 0
            0 0 1 0
            1 0 0 0
            0 0 0 1];
        % T3
        T{3}=eye(4);
        return
    otherwise,
        error('Unknown robot type %s',robotType)
end

end