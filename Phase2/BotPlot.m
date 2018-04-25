function BotPlot(robotType,Q)
Tm=Tworld(robotType,Q);
for i=1:numel(Tm)-1
    plot([Tm{i}(1,4) Tm{i+1}(1,4)],[Tm{i}(2,4),Tm{i+1}(2,4)]);hold all
    plot([Tm{i}(1,4) Tm{i+1}(1,4)],[Tm{i}(2,4),Tm{i+1}(2,4)],'*r');hold all
end