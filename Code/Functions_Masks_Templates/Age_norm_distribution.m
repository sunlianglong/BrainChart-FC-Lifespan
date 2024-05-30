function df = Age_norm_distribution(Atlas_order,listPath)

Atlas_age_before_all = [-0.1667;-0.1250;-0.0833;-0.0417;0;0.0833;0.25;0.5;0.75;1;1.5;2;4;6;8;10;12;14;16;18;20;30;40;50;60;70];
Atlas_age_all=[-0.1250,-0.0833,-0.0417,0,0.0833,0.25,0.5,0.75,1,1.5,2,4,6,8,10,12,14,16,18,20,30,40,50,60,70,80]';
Atlas_age_after_all = [-0.0833;-0.0417;0;0.0417;0.1667;0.5;0.75;1;1.25;2;2.5;6;8;10;12;14;16;18;20;22;40;50;60;70;80;80];
tmp=[Atlas_age_before_all,Atlas_age_all,Atlas_age_after_all];

age = load([listPath '/Atlas' int2str(Atlas_order) '_subage.list']);
age_origin = age; 
Atlas_age = Atlas_age_all(Atlas_order);
Atlas_age_before = Atlas_age_before_all(Atlas_order) - Atlas_age;
Atlas_age_after = Atlas_age_after_all(Atlas_order) - Atlas_age;
age = age - Atlas_age;
scale_x1 = -1.96 / Atlas_age_before;
scale_x2 = 1.96 / Atlas_age_after;
for i = 1:length(age)
    if age(i) < 0
        age(i) = age(i) * scale_x1;
    else
        age(i) = age(i) * scale_x2;
    end
end

mu = 0; 
sigma = 1;
df = normpdf(age, mu, sigma);

[a,b] = sort(age);
x=age_origin(b);
y=df(b);

fig = figure;
plot(x, y, '-o', 'LineWidth', 2); 
hold on;

% x_sections = linspace(tmp(Atlas_order,1), tmp(Atlas_order,3), 5);
% for i = 2:3
%     idx = (x >= x_sections(i)) & (x <= x_sections(i+1));
%     fill([x(idx); flipud(x(idx))], [y(idx); zeros(sum(idx), 1)], [0, 0.5, 1], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
% end
% for i = [1, 4]
%     idx = (x >= x_sections(i)) & (x <= x_sections(i+1));
%     fill([x(idx); flipud(x(idx))], [y(idx); zeros(sum(idx), 1)], [1, 0.5, 0], 'FaceAlpha', 0.3, 'EdgeColor', 'none');
% end
% 
% 
% ax = gca; 
% ax.XAxis.TickLength = [0.02, 0.02]; 
% ax.XAxis.LineWidth = 1.5;  
% ax.YAxis.TickLength = [0.02, 0.02];  
% ax.YAxis.LineWidth = 1.5;  
% ylim([min(y),max(y)]);
% box off;