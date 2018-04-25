function phase2(file)
close all;
error(nargchk(0, 1, nargin, 'struct'))
error(nargchk(0, 0, nargout, 'struct'))
if nargin<1||~exist(file,'file')
    file='trajectory1.dat';
    feval(mfilename,file);
    file='trajectory2.dat';
    feval(mfilename,file);
%     file='trajectory1_slow.dat';
%     feval(mfilename,file);
%     file='trajectory2_slow.dat';
%     feval(mfilename,file);
    return;
else
    if strcmpi(file,'prompt')
        [filename, pathname] = uigetfile( ...
            {'*.dat';'*.txt';'*.*'}, ...
            'Pick a robot datafile');
        feval(mfilename,fullfile(pathname,filename));
        return;
    end
end
%% Data Input
% Open the data file.
fid=fopen(file,'r');
% Read in times.
Tf=fscanf(fid,'%f',1);
dT=fscanf(fid,'%f',1);
% Read in Initial Position.
Px(1)=fscanf(fid,'%f',1);
Py(1)=fscanf(fid,'%f',1);
Pz(1)=fscanf(fid,'%f',1);
% Read in Final Position.
Px(2)=fscanf(fid,'%f',1);
Py(2)=fscanf(fid,'%f',1);
Pz(2)=fscanf(fid,'%f',1);
% Open the TexFile that is used to write the outputs to.
[p,n]=fileparts(file);
texFid=fopen(fullfile(p,[n '.tex']),'w');
%% Calculations
t=[0:dT:Tf]';
[X,Vx,~]=trajPlanner(Px(1),Px(2),Tf,dT,2,2); % Plan the X Path
[Y,Vy,~]=trajPlanner(Py(1),Py(2),Tf,dT,2,2); % Plan the Y Path
[Z,Vz,~]=trajPlanner(Pz(1),Pz(2),Tf,dT,2,2); % Plan the Z Path
% Determine robot type based on Z. If it's all 0 then it's just an RR.
if all(Z==0)
    robotType='RR';
else
    robotType='RRR';
end
%%
theta=invKin(robotType,[X Y Z]); % Do inverse kinematics.
dTheta=zeros(size(theta,1),3); % Preallocate for speed.
%% Calculate the Jacobian symbolically.
if strcmpi(robotType,'RRR')
    syms theta1 theta2 theta3 real;
    J=Jcalc(robotType,[theta1 theta2 theta3]);
else
    syms theta1 theta2 real;
    J=Jcalc(robotType,[theta1 theta2]);
end
dataOut=fullfile(p,[n '_jacobian.tex']);
fid=fopen(dataOut,'w');
fprintf(fid,'\\begin{eqnarray}\n');
for i=1:size(J,1)
    for j=1:size(J,2)
        if i==size(J,1) && j==size(J,2)
            fprintf(fid,'J(%d,%d)&=&%s\n \\nonumber',i,j,mat2latex(simplify(J(i,j))));
        else
            fprintf(fid,'J(%d,%d)&=&%s\n \\nonumber \\\\',i,j,mat2latex(simplify(J(i,j))));
        end
    end
end
fprintf(fid,'\\end{eqnarray}\n');
fprintf(texFid,'Symbolic jacobian matrix for %s.\n',robotType);
fprintf(texFid,'\\input{%s}\n',dataOut);% Write it to the main file to include.
%% Calculate numerically.
for i=1:size(theta,1) % For each position.
    J=Jcalc(robotType,theta(i,:)); % Calculate the Jacobian.
    switch robotType
        % Get the top Jacobian and calculate joint rates.
        case 'RR',
            JTop=J(1:2,1:2);
            J_inv=JTop^-1;
            dTheta(i,1:2)=[J_inv*[Vx(i) Vy(i)]']';
        case 'RRR',
            JTop=J(1:3,1:3);
            J_inv=JTop^-1;
            dTheta(i,:)=[J_inv*[Vx(i) Vy(i) Vz(i)]']';
    end
    % Get the manipulability.
    [ax(i),by(i),cz(i),Beta(i),R{i}]=manipulability(J);
end
% dTheta=dTheta.*180/pi; % Just to check answers against HW7
%% Position of the Joints
dataOut=fullfile(p,[n '_trajectory.tex']);
fid=fopen(dataOut,'w');
fprintf(fid,'\\begin{verbatim}\n');
fprintf(fid,'%d %% Number of positions\n',length(X));
if strcmpi(robotType,'RRR')
    fprintf(fid,'%%  t(s) %9s%9s%9s%9s%9s%9s\n','Theta1','Theta2','Theta3','Omega1','Omega2','Omega3');
    fprintf(fid,'% 8.3f % 8.3f % 8.3f % 8.3f % 8.3f % 8.3f % 8.3f\n',[t,theta(:,1),theta(:,2),theta(:,3),dTheta(:,1),dTheta(:,2),dTheta(:,3)]');
else
    fprintf(fid,'%%  t(s) %9s%9s%9s%9s\n','Theta1','Theta2','Omega1','Omega2');
    fprintf(fid,'% 8.3f % 8.3f % 8.3f % 8.3f % 8.3f\n',[t,theta(:,1),theta(:,2),dTheta(:,1),dTheta(:,2)]');
end
fprintf(fid,'\\end{verbatim}\n');
fclose(fid);
fprintf(texFid,'Joint position and velocities for %s.\n',[n '.dat']);
fprintf(texFid,'\\input{%s}\n',dataOut);% Write it to the main file to include.

%% Joint positions & velocities.
[~,n] = fileparts(file);

% Determine the number of joints to print out.
if strcmpi(robotType,'RR')
    q=2;
else
    q=3;
end
for i=1:q
    close all;
    h=plotyy(t,theta(:,i),t,dTheta(:,i));
    xlabel('Time (s)');
    ylabel(h(1),sprintf('\\theta_%d (^o)',i));
    ylabel(h(2),sprintf('\\omega_%d (rad/s)',i));
    title(sprintf('%s Joint %d Angle & Velocity',robotType,i));
    jointFile=sprintf('%s_joint%d',n,i);
    % print('--depsc2',jointFile);
    fprintf(texFid,'\\fig{%s}{%s Joint %d Angle and Velocity}\n',jointFile,robotType,i);
end

%% Plot the EECS
close all; % New figure & increment.
subplot(q,1,1); % New sub plot with the number of axes
plot(t,X,'.');axis('tight'); % Plot X
ylabel('X'); % Label
xlabel('Time (s)');
subplot(q,1,2);
plot(t,Y,'.');axis('tight'); % Plot Y
ylabel('Y'); % Label
xlabel('Time (s)');
set(gca,'YAxisLocation','Right'); % Flip the axes to the other side for readability.
if strcmpi(robotType,'RRR'); % If it has a 3rd linkage, print the 3rd dimension.
    subplot(313);
    plot(t,Z,'.');axis('tight');
    ylabel('Z');
    xlabel('Time (s)');
end
eecsFile=sprintf('%s_EECS',n);
% print('--depsc2',eecsFile);
fprintf(texFid,'\\fig{%s}{Position of the end effector for each of the coordinates vs time}\n',eecsFile);
% Now in 3D
close all;
plot3(X,Y,Z);
title(sprintf('%s end effector position in 3D',robotType));
xlabel('X');
ylabel('Y');
zlabel('Z');
grid('on');
eecsFile3=sprintf('%s_EECS_3D',n);
% print('--depsc2',eecsFile3);
fprintf(texFid,'\\fig{%s}{%s end effector position in 3D}\n',eecsFile3,robotType);

%% Do Phase 1 & Forward Kinematics.
[p,n] = fileparts(file);
phase1_file=fullfile(p,[n '_robot.dat']); % Create the .dat file to write for phase1.
fid=fopen(phase1_file,'w'); % Open it.
fprintf(fid,'%d %d %s\n',2+~all(Z==0),length(X),robotType); % Write the first line.
if strcmpi('RRR',robotType)
    fprintf(fid,'%.10f\t%.10f\t%.10f\n',[theta(:,1),theta(:,2),theta(:,3)]'); % Print each of the joint values.
else
    fprintf(fid,'%.10f\t%.10f\n',[theta(:,1),theta(:,2)]'); % Print each of the joint values.
end
fclose(fid); % Close the file.
[X2,Y2,Z2]=feval('phase1',phase1_file); % Get the EECS position based on forward kinematics.
phase1Tex= feval('phase1',phase1_file); % Print phase1 to a .tex file.
fprintf(texFid,'\\input{%s}\n',phase1Tex);% Write it to the main file to include.

%% Manipulability.
[p,n] = fileparts(file);
dataOut=fullfile(p,[n '_manip.tex']);
fid=fopen(dataOut,'w');
fprintf(fid,'Manipulability of the robot.\n \\pagebreak[1]');
fprintf(fid,'\\begin{verbatim}\n');
if strcmpi(robotType,'RRR')
    fprintf(fid,'%%  t(s)%9s%9s%9s\n','ax','by','cz');
    fprintf(fid,'% 8.3f% 8.3f % 8.3f % 8.3f\n',[t';ax;by;cz]);
else
    fprintf(fid,'%%  t(s)%9s%9s\n','ax','by');
    fprintf(fid,'% 8.3f% 8.3f % 8.3f\n',[t';ax;by]);
end
fprintf(fid,'\\end{verbatim}\n');
fprintf(texFid,'\\input{%s}\n',dataOut);% Write it to the main file to include.

%% Plot the ellipsoid.
[ix,iy]=find(abs(dTheta)==max(max(abs(dTheta)))); % Find the point where joint velocity is near the maximum.

if strcmpi('RRR',robotType)
    for i=[1 ix length(ax)]
        [Ex,Ey,Ez]=ellipsoid(0,0,0,ax(i),by(i),cz(i));
        % Rotate each Point
        for j=1:size(Ex,1)
            for k=1:size(Ex,2)
                E=R{i}*[Ex(j,k) Ey(j,k) Ez(j,k)]';
                Ex(j,k)=E(1);
                Ey(j,k)=E(2);
                Ez(j,k)=E(2);
            end
        end
        close all;
        surf(Ex,Ey,Ez)
        title(sprintf('Manipulability ellipse for \\theta_1=%.3f^o, \\theta_2=%.3f^o, \\theta_3^o=%.3f', theta(i,1), theta(i,2),theta(i,3)))
        axis equal
        axis([-1 1 -1 1 -1 1]*max(axis));
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        eFile=sprintf('%s_ell%d',n,i);
        % print('--depsc2',eFile);
        fprintf(texFid,'\\fig{%s}{Manipulability of %s at position %d.}\n',eFile,robotType,i-1);
    end
else
    for i=[1 ix length(ax)]
        % 2D Way
%         [ex,ey] = calculateEllipse(0, 0, ax(i), by(i), Beta(i));
%         close all;
%         plot(ex,ey);
%         title(sprintf('Manipulability ellipse for \\theta_1=%.3f^o, \\theta_2=%.3f^o', theta(i,1), theta(i,2)))
%         axis equal
%         axis([-1 1 -1 1]*max(axis));
%         xlabel('X');
%         ylabel('Y');
        
        % 3D Way
        [Ex,Ey,Ez]=ellipsoid(0,0,0,ax(i),by(i),0);
        % Rotate each Point
        for j=1:size(Ex,1)
            for k=1:size(Ex,2)
                E=R{i}*[Ex(j,k) Ey(j,k)]';
                Ex(j,k)=E(1);
                Ey(j,k)=E(2);
            end
        end
        close all;
        surf(Ex,Ey,Ez);
        title(sprintf('Manipulability ellipse for \\theta_1=%.3f^o, \\theta_2=%.3f^o, \\theta_3^o=%.3f', theta(i,1), theta(i,2),theta(i,3)))
        axis equal
        axis([-1 1 -1 1 -1 1]*ceil(max(axis)));
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        eFile=sprintf('%s_ell%d',n,i);
        % View from the top.
        set(gca,'CameraPosition',[0 0 1])
        % print('--depsc2',eFile);
        fprintf(texFid,'\\fig{%s}{Manipulability of %s at position %d.}\n',eFile,robotType,i-1);
    end
end
%% Sanity check the CIM trajectory planning against the output from phase1
if max(abs(X-X2))>.1
    error('Something went wrong with forward kinematics. Check phase1.m and shape.m');
else
    disp('EECS X-axis validated');
end
if max(abs(Y-Y2))>.1
    error('Something went wrong with forward kinematics. Check phase1.m and shape.m');
else
    disp('EECS Y-axis validated');
end
if max(abs(Z-Z2))>.1
    error('Something went wrong with forward kinematics. Check phase1.m and shape.m');
else
    disp('EECS Z-axis validated');
end
%%
fclose('all');