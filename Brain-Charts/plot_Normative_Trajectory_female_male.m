

% load('Trajectory_whole-brain_mean_FC.mat');

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

max_data = max(max(centile_all));
min_data = min(min(centile_all));

fig.Color='w';fig.Position=[100 100 1000 700]; 
hp1=plot(x,centile_male(:,3),'Color',[0 188/255 194/255],'LineWidth',3);
hold on;
hp2=plot(x,centile_female(:,3),'Color',[246/255 118/255 108/255],'LineWidth',3);




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
legend([hp1, hp2], 'Male', 'Female', 'Location', 'best');
