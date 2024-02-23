% set up the problem

close all; clear; clc;

N      = 3;
keys   = dec2bin(0:(2^N) - 1);
values = [0; 0; 0; 1; 0; 3; 1; 3];
v      = dictionary(keys, values);

min1 = v('001') / v('111');
max1 = (v('111') - v('110')) / v('111');

min2 = v('010') / v('111');
max2 = (v('111') - v('101')) / v('111');

min3 = v('100') / v('111');
max3 = (v('111') - v('011')) / v('111');

% define necessary functions

x = 0:0.01:1;

y1     = @(x) sqrt(3) - (sqrt(3) * x);
y1_max = @(x) y1(x + max1);
y1_min = @(x) y1(x + min1);

y2     = @(x) sqrt(3) * x;
y2_max = @(x) y2(x - max2);
y2_min = @(x) y2(x - min2);

y3     = @(x) zeros(1, length(x));
y3_max = @(x) y3(x) + (max3 * (0.5 * sqrt(3)));
y3_min = @(x) y3(x) + (min3 * (0.5 * sqrt(3)));

% plot the core

figure;
hold on;

vertices = [0, 0; 1, 0; 0.5, 0.5 * sqrt(3)];

fill(vertices(:, 1), vertices(:, 2), 'b');
fill([x, fliplr(x)], [y1_min(x), fliplr(y1(x))], 'w', 'EdgeColor', 'none');
fill([x, fliplr(x)], [y2_min(x), fliplr(y2(x))], 'w', 'EdgeColor', 'none');
fill([x, fliplr(x)], [y3_min(x), fliplr(y3(x))], 'w', 'EdgeColor', 'none');
fill([x, fliplr(x)], [y1_max(x), fliplr(y3_min(x))], 'w', 'EdgeColor', 'none');
fill([x, fliplr(x)], [y2_max(x), fliplr(y3_min(x))], 'w', 'EdgeColor', 'none');
fill([x, fliplr(x)], [y3_max(x), fliplr(y1(x))], 'w', 'EdgeColor', 'none');

triplot(triangulation([1 2 3], vertices));
text(0, 0, '(1, 0, 0)', 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');
text(1, 0, '(0, 1, 0)', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
text(0.5, 0.5 * sqrt(3), '(0, 0, 1)', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');

plot(x, y1_min(x));
plot(x, y1_max(x));
plot(x, y2_min(x));
plot(x, y2_max(x));
plot(x, y3_min(x));
plot(x, y3_max(x));

xlim([-0.2, 1.2]);
ylim([-0.2, (0.5 * sqrt(3)) + 0.2]);
set(gca, 'XColor', 'none', 'YColor', 'none');
title('Core of the Game');
hold off;