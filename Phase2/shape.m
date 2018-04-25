function [jointType,T]=shape(robotType)
switch robotType
    case 'RR', % From homework 7
        jointType=[0 0];
        L1=20;
        L2=20;
        % T1
        T{1}=[1 0 0 L1
            0 1 0  0
            0 0 1  0
            0 0 0  1];
        % T2
        T{2}=[1 0 0 L2
            0 1 0  0
            0 0 1  0
            0 0 0  1];
        return;
    case 'RRP', % From homework 4
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
    case 'RRR', % From homework 4
        d1=4;
        L3=4;
        L1=5;
        L2=5;
        jointType=[0 0 0];
        T{1}=[0 0 1 d1
            1 0 0 0
            0 1 0 L1
            0 0 0 1];
        T{2}=[1 0 0 0
            0 1 0 L2
            0 0 1 0
            0 0 0 1];
        T{3}=[0 1 0 0
            0 0 1 L3
            1 0 0 0
            0 0 0 1];
    otherwise,
        error('Unknown robot type %s',robotType)
end

end