

load('Trajectory_whole-brain_mean_FC.mat');

delta_x = x(2:8001) - x(1:8000);

for i = 1:5
    delta_y(:,i) = centile_all(2:8001,i) - centile_all(1:8000,i);
    rate_of_change(:,i) =  delta_y(:,i) ./ delta_x;
end

fig=figure;
% amount of shift of x and y axis in normalized coordinates
dx=0.02;
dy=0.03;
plotAx=axes('Position',[0.15 0.15 0.8 0.8],'Color','none');
% create shifted y axis
yax=axes('Position',plotAx.Position-[dx 0 -dx 0],'Color','none','XColor','none');
yax.XGrid='off';
yax.TickDir='out';
% create shifted x axis
xax=axes('Position',plotAx.Position-[0 dy 0 -dy],'Color','none','YColor','none');
xax.YGrid='off';
xax.TickDir='out';
axes(plotAx); % set curr axis

max_data = max(max(rate_of_change));
min_data = min(min(rate_of_change));

fig.Color='w';fig.Position=[100 100 1000 700]; 
hp=plot(x(2:8001),rate_of_change,'Color',[0 0 0],'LineWidth',1,'LineStyle','--');
hp(3).LineStyle='-';
hp(3).LineWidth=4;
hold on;
hp=plot(x(2:8001),zeros(8000,1),'Color',[0 0 1 0.4],'LineWidth',4,'LineStyle','--');
box off;

linkaxes([plotAx,yax,xax]);
yticklabels([]);
xticklabels([]);
% remove rulers
plotAx.XColor='none';
plotAx.YColor='none';
xax.XLim = [-1,80];

yax.YLim = [min_data, max_data];
xax.FontSize = 28;
yax.FontSize = 28;
xax.XAxis.TickLength = [0.025, 0];
yax.YAxis.TickLength = [0.025, 0];
xax.LineWidth = 2.5;
yax.LineWidth = 2.5;
xax.XAxis.TickValues = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80]; 
xax.XAxis.TickLabels = {'0','','10','','20','','30','','40','','50','','60', '','70','','80'};

