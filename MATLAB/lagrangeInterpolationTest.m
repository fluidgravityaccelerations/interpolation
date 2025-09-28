clear all
close all
clc

x               = linspace(-1, 1, 1000);

No              = 30;
xo              = linspace(-1, 1, No);

% --- Example #1: Runge function with uniform sampling
runge           = @(x)(1 ./ (1 + 25 * x.^2));
y               = runge(x);

Ni              = 20;
xi              = linspace(-1, 1, Ni);
yi              = runge(xi);

yo              = lagrangeInterpolation(xi, yi, xo);

figure
plot(x, y, 'k', 'LineWidth', 1.5)
hold on
plot(xi, yi, 'ro')
plot(xo, yo, 'b--')
legend('Exact', 'Samples', 'Interpolation')

% --- Example #2: Runge function with increased sampling at the borders
Ni              = 28;
xi              = [xi 0.6 0.8 0.9 0.95 -0.95 -0.9 -0.8 -0.6];
yi              = runge(xi);

yo              = lagrangeInterpolation(xi, yi, xo);

figure
plot(x, y, 'k', 'LineWidth', 1.5)
hold on
plot(xi, yi, 'ro')
plot(xo, yo, 'b--')
legend('Exact', 'Samples', 'Interpolation')

% --- Example #3: Polynomial function
pol             = @(x)(5 * x.^6 -12 * x.^4 + 21 * x.^3 - x.^2 + 1);
y               = pol(x);

Ni              = 20;
xi              = linspace(-1, 1, Ni);
yi              = pol(xi);

yo              = lagrangeInterpolation(xi, yi, xo);

figure
plot(x, y, 'k', 'LineWidth', 1.5)
hold on
plot(xi, yi, 'ro')
plot(xo, yo, 'b--')
legend('Exact', 'Samples', 'Interpolation')

% --- Example #4: instability for an oscillatory function (sin)
y               = sin(5 * x);

Ni              = 50;   % --- As a consequence, Lagrange polynomial has high degree
xi              = linspace(-1, 1, Ni);
yi              = sin(5 * xi);

yo              = lagrangeInterpolation(xi, yi, xo);

figure
plot(x, y, 'k', 'LineWidth', 1.5)
hold on
plot(xi, yi, 'ro')
plot(xo, yo, 'b--')
legend('Exact', 'Samples', 'Interpolation')

