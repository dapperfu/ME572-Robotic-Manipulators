function rotAxis(theta,style)
a=axis;
hold on;
if nargin<2
    plot([sind(theta) -sind(theta)].*100,[-cosd(theta) cosd(theta)].*100);
    plot([-cosd(theta) cosd(theta)].*100,[-sind(theta) sind(theta)].*100,'HandleVisibility','off');
else
    plot([sind(theta) -sind(theta)].*100,[-cosd(theta) cosd(theta)].*100,style);
    plot([-cosd(theta) cosd(theta)].*100,[-sind(theta) sind(theta)].*100,style,'HandleVisibility','off');
end
hold off;
axis(a);

