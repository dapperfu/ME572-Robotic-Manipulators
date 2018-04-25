% %% ME 572- Homework Set #1. Problem 1.
% % Assumptions: For simplicity in the sketches the following will be followed:
% % 1) All links with revolute joints will be 3" long.
% % 2) All revolute joints will have full range of motion (0-360)
% % 3) All prismatic joints will have a range 1"-4".
% % There are 8 different possible combinations of 3 joint manipulators.
% j=['R','P'];
% for a=j
%     for b=j
%         for c=j
%             fprintf('%c%c%c\n',a,b,c);
%         end
%     end
% end
% 
% %% 

theta=[0:2.5:360];
lr=2;
lp=0:.1:2;

% RRR
[l1,l2,Theta3]=meshgrid(lp,lp,theta);
Theta1=0;
Theta2=90;
% Theta3=Theta2;
X=l1.*cosd(Theta1)+l2.*cosd(Theta2)+lr.*cosd(Theta3);
Y=l1.*sind(Theta1)+l2.*sind(Theta2)+lr.*sind(Theta3);

X=reshape(X,1,numel(X));
Y=reshape(Y,1,numel(Y));
plot(X,Y,'r.');
% m=min([a(1) a(3)]);
% mx=max([a(2) a(4)]);
% axis([m mx m mx]);
% RRP
% pause;
% [Theta1,Theta2,Lp]=meshgrid(theta,theta,lp);
% Theta2=Theta2+Theta1;
% Theta3=Theta2;
% X=lr*cosd(Theta1)+lr*cosd(Theta2)+Lp.*cosd(Theta3);
% Y=lr*sind(Theta1)+lr*sind(Theta2)+Lp.*sind(Theta3);
% X=reshape(X,1,numel(X));
% Y=reshape(Y,1,numel(Y));
% plot(X,Y,'b.');
% % RPR
% pause;
% [Theta1,Lp1,Lp2]=meshgrid(theta,Lp,lp);
% Theta2=Theta1+45;
% Theta3=Theta1-45;
% X=lr*cosd(Theta1)+Lp1*cosd(Theta2)+Lp2.*cosd(Theta3);
% Y=lr*sind(Theta1)+Lp1*sind(Theta2)+Lp2.*sind(Theta3);
% X=reshape(X,1,numel(X));
% Y=reshape(Y,1,numel(Y));
% plot(X,Y,'b.');