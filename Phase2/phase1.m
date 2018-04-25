function varargout=phase1(file)
error(nargchk(0, 1, nargin, 'struct'))
error(nargchk(0, 4, nargout, 'struct'))
if nargin<1||~exist(file,'file')
    file='trajectory1_robot.dat';
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
Tm=cell(1,m);
for i=1:m
    Tm_tmp=Tworld(robotType,Q(:,i));
    Tm{i}=Tm_tmp{end};
end
if nargout==3
    for i=1:m
        P(i,:)=Tm{i}(1:3,4)';
    end
    varargout{1}=P(:,1);
    varargout{2}=P(:,2);
    varargout{3}=P(:,3);
else
    [p,n]=fileparts(file);
    phase1Tex=fullfile(p,[n '_tm.tex']);
    if nargout==1
        varargout{1}=phase1Tex;
    end
    fid=fopen(phase1Tex,'w');
    fprintf(fid,'\\newpage\nWorld transforms of the robot at positions calculated for coordinate interpolated motion.\n');
    for i=1:m
        fprintf(fid,'\\begin{verbatim}\n');
        fprintf(fid,'POSITION %d: INPUT: JOINT VARIABLES (',i);
        fprintf(fid,'% 8.3f,',Q(:,i));
        fprintf(fid,')\nOUTPUT:');
        fprintf(fid,'% 10.3f',Tm{i}(1,:));
        fprintf(fid,'\n       ');
        fprintf(fid,'% 10.3f',Tm{i}(2,:));
        fprintf(fid,'\n       ');
        fprintf(fid,'%10.3f',Tm{i}(3,:));
        fprintf(fid,'\n       ');
        fprintf(fid,'%10.3f',Tm{i}(4,:));
        fprintf(fid,'\n');
        fprintf(fid,'\\end{verbatim} \\pagebreak[1]');
    end
    fclose(fid);
end
end
function m=phiR(theta)
theta=theta.*pi./180;
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