w = 5;
x = 28;
y = 2;
p = 0.2;
g = 0.1;
l = 2.25;
r = 13;

xx = (w-3):0.01:(w+x+10);

width = 8;
height = 4;
figure1 = figure('visible', 'off');
set(gcf, 'Position', [0 0 width*100, height*100]);
axes1 = axes('Parent', figure1, 'FontSize', 15);
box(axes1, 'on')
hold(axes1, 'on')

plot(xx, xx.^g, 'LineWidth', 3)
plot([w+y w+x], [(w+y)^g (w+x)^g], 'LineWidth', 3)
plot([w + (1-p)*y+p*x w + (1-p)*y+p*x], [0, (1-p)*(w+y)^g + p*(w+x)^g], 'LineWidth', 3)
hold off
xlabel("Wealth", "FontSize", 15)
ylabel("Utility", "FontSize", 15)

ylim([1.1,1.45])

% File formatting.
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);

g = 0.5;
xx = 2:0.01:25;

figure1 = figure('visible', 'off');
set(gcf, 'Position', [0 0 width*100, height*100]);
axes1 = axes('Parent', figure1, 'FontSize', 15);
box(axes1, 'on')
hold(axes1, 'on')

plot(xx(xx>=r), (xx(xx>=r)-r).^g, 'LineWidth', 3, 'Color', [0.2, 0.2 0.7])
plot(xx(xx<=r), -l*(-(xx(xx<=r)-r)).^g, 'LineWidth', 3, 'Color', [0.2, 0.2 0.7])
plot(xx, xx * 0, 'LineWidth', 3)

hold off
xlabel("Wealth", "FontSize", 15)
ylabel("Utility", "FontSize", 15)

xlim([5,25])
% File formatting.
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);

saveas(figure1, 'cpt_utility.png');


p_gain = 0:0.01:1;
dp =0.64;

figure1 = figure('visible', 'on');
set(gcf, 'Position', [0 0 width*100, height*100]);
axes1 = axes('Parent', figure1, 'FontSize', 15);
box(axes1, 'on')
hold(axes1, 'on')

plot(p_gain, (p_gain.^dp)./((p_gain.^dp + (1-p_gain).^dp).^(1/dp))  , 'LineWidth', 3)
dp = 0.4;
plot(p_gain, (p_gain.^dp)./((p_gain.^dp + (1-p_gain).^dp).^(1/dp))  , 'LineWidth', 3)
plot(p_gain, p_gain, 'LineWidth', 3)

hold off
xlabel("Wealth", "FontSize", 15)
ylabel("Utility", "FontSize", 15)

xlim([0, 1])
% File formatting.
set(gcf,'InvertHardcopy','on');
set(gcf,'PaperUnits', 'inches');
papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);

saveas(figure1, 'cpt_weights.png');
