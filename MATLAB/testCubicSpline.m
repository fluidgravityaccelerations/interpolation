clear all
close all
clc

handleFigure = 0;

N           = 40;
Nout        = 20;
numMesh     = 100;

runge       = @(x) 1 ./ (1 + 25 * x.^2);

xMesh       = linspace(-1, 1, numMesh);
yMesh       = runge(xMesh);

handleFigure = handleFigure + 1;
figure(handleFigure)
plot(xMesh, yMesh)
hold on

xin         = linspace(-1, 1, N + 1);
yin         = runge(xin);

xout        = linspace(-1, 1, Nout);

plot(xin, yin, 'o')

yout        = cubicSplineInterpolation(xin, yin, xout);

hold on
plot(xout, yout, 'kx', 'MarkerSize', 8, 'LineWidth', 2)
legend('Runge function', 'Interpolation nodes', 'Spline interpolation', 'Location', 'best')
title('Cubic Spline Interpolation of Runge Function')
grid on