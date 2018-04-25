function varargout=project1(file)
error(nargchk(0, 1, nargin, 'struct'))
error(nargchk(0, 3, nargout, 'struct'))
if nargin<1||~exist(file,'file')
    file='robot1.dat';
else
    if strcmpi(file,'prompt')
        [filename, pathname] = uigetfile( ...
            {'*.dat';'*.txt';'*.*'}, ...
            'Pick a robot datafile');
        feval(mfilename,fullfile(pathname,filename));
        return;
    end
end
fid=fopen(file,'r');
n=fscanf(fid,'%d',1);
m=fscanf(fid,'%d',1);
robotType=fscanf(fid,'%s',1);
Q=fscanf(fid,'%f',[n,m]);
fclose(fid);
[jointType,T]=shape(robotType);
Tm=cell(1,m);
for i=1:m
    Tm{i}=eye(4);
    for j=1:n
        switch jointType(j)
            case 0,
                phi=phiR(Q(j,i));
            case 1,
                phi=phiP(Q(j,i));
            otherwise,
                error('Unknown joint type %d',jointType(j))
        end
        Tm{i}=Tm{i}*phi*T{j};
    end
end
if nargout>0
    if nargout==2
        error('Incorrect number of outputs')
        
    end
    P=zeros(m,3);
    for i=1:m
        P(i,:)=Tm{i}(1:3,4)';
    end
    if nargout==1
        varargout{1}=P;
    else
        varargout{1}=P(:,1);
        varargout{2}=P(:,2);
        varargout{3}=P(:,3);
    end
else
    for i=1:m
        fprintf('POSITION %d: INPUT: JOINT VARIABLES (',i);
        fprintf('%+8.3f,',Q(:,i));
        fprintf('\b)\nOUTPUT:\t');
        fprintf('%8.3f\t',Tm{i}(1,:));
        fprintf('\n\t\t');
        fprintf('%8.3f\t',Tm{i}(2,:));
        fprintf('\n\t\t');
        fprintf('%8.3f\t',Tm{i}(3,:));
        fprintf('\n\t\t');
        fprintf('%8.3f\t',Tm{i}(4,:));
        fprintf('\n\n');
    end
end
end
function m=phiR(theta)
m=[cosd(theta) -sind(theta) 0 0
    sind(theta)  cosd(theta) 0 0
    0            0           1 0
    0            0           0 1];
end
function m=phiP(X)
m=[1 0 0 0
    0 1 0 0
    0 0 1 X
    0 0 0 1];
end