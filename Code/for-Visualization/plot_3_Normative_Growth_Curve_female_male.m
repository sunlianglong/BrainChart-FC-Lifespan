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

max_data = max(max([centiles_female(:,4);centiles_male(:,4)]));
min_data = min(min([centiles_female(:,4);centiles_male(:,4)]));
max_min_range = max_data - min_data;

fig.Color='w';fig.Position=[100 100 1200 700]; 
hp1=plot(X,centiles_male(:,4),'Color',[0 188/255 194/255],'LineWidth',3);
hold on;
hp2=plot(X,centiles_female(:,4),'Color',[246/255 118/255 108/255],'LineWidth',3);

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
legend([hp1, hp2], 'Male', 'Female', 'Location', 'best', 'FontSize', 18);
title(plotAx, ['Lifespan normative growth curve of ' phenotype_name], 'FontSize', 28);  % …Ë÷√±ÍÃ‚
xlabel(xax, 'Age', 'FontSize', 28);