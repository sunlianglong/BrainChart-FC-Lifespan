%% plot growth curve
phenotype_name = 'global mean of FC';
load('..\..\Data\Growth_curve_global_mean_of_FC.mat');

fig=figure;
% amount of shift of x and y axis in normalized coordinates
dx=0.02;
dy=0.03;
plotAx=axes('Position',[0.18 0.22 0.7 0.7],'Color','none');
% create shifted y axis
yax=axes('Position',plotAx.Position-[dx 0 -dx 0],'Color','none','XColor','none');
yax.XGrid='off';
yax.TickDir='out';
% create shifted x axis
xax=axes('Position',plotAx.Position-[0 dy 0 -dy],'Color','none','YColor','none');
xax.YGrid='off';
xax.TickDir='out';
axes(plotAx); % set curr axis

max_data = max(max(centiles));
min_data = min(min(centiles));
max_min_range = max_data - min_data;

fig.Color='w';fig.Position=[100 100 1200 700]; 
hp=plot(X,centiles,'Color',[0 0 0],'LineWidth',3,'LineStyle','--');
hp(4).LineStyle='-';
hp(4).LineWidth=4;


linkaxes([plotAx,yax,xax]);
yticklabels([]);
xticklabels([]);
% remove rulers
plotAx.XColor='none';
plotAx.YColor='none';
xax.XLim = [-1,80];

yax.YLim = [min_data - max_min_range*0.2, max_data + max_min_range*0.2];
xax.FontSize = 28;
yax.FontSize = 28;
xax.XAxis.TickLength = [0.025, 0];
yax.YAxis.TickLength = [0.025, 0];
xax.LineWidth = 2.5;
yax.LineWidth = 2.5;
xax.XAxis.TickValues = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80]; 
xax.XAxis.TickLabels = {'0','','10','','20','','30','','40','','50','','60', '','70','','80'};
title(plotAx, ['Lifespan normative growth curve of ' phenotype_name], 'FontSize', 28);  % …Ë÷√±ÍÃ‚
xlabel(xax, 'Age', 'FontSize', 28);

