%
% Title: proj4.m
% Summary: driver m-script for Project 4 for MATH 3315
% Author: Zack Fout
% Version: 1.1
% Last Modified: 04/21/2014
% Notes: completed project 4
%
%% *MATH 3315 Project 4 - Solution of Two Point BVPs - By Zack Fout*
%% Part 1. Boundary Value Problems and Solution Methods
% Boundary Value Problems are an important class of differential equations
% with many applications in the physical sciences. A two point boundary
% value problem consists of finding the function that satisfies a
% second order differential equation given conditions placed on the
% extremes of the independent variable. These problems are often difficult
% to solve analytically, so numerical differentiation is used to
% approximate the differential equation. This is accomplished by
% subdividing the given interval for x and computing the centered
% differences for each subinterval. This process produces N - 1
% differential equations for each gridpoint over the interval, which may be
% solved simultaneously using a linear system. This process is performed
% for the function f(x) = sin(pi * x), and the maximum errors are shown for
% N = 20, 40, 80, and 160:
beta1 = pi;
gamma1 = pi .^ 2;

[y1,x1] = bvpFull(20, beta1, gamma1, 1);
max1 = norm(y1 - sin(pi * x1), inf);

[y2,x2] = bvpFull(40, beta1, gamma1, 1);
max2 = norm(y2 - sin(pi * x2), inf);

[y3,x3] = bvpFull(80, beta1, gamma1, 1);
max3 = norm(y3 - sin(pi * x3), inf);

[y4,x4] = bvpFull(160, beta1, gamma1, 1);
max4 = norm(y4 - sin(pi * x4), inf);

fprintf('The maximum error for N = 20 is %g\n', max1);
fprintf('The maximum error for N = 40 is %g\n', max2);
fprintf('The maximum error for N = 80 is %g\n', max3);
fprintf('The maximum error for N = 160 is %g\n', max4);
%%
% As you can see, the maximum errors become increasingly smaller with each
% multiple of N, so this method provides good approximations of the
% derivatives.
%% Part 2. Boundary Value Problem for f(x) = cos(exp(20x(1-x)))
% Now the BVP for f(x) = cos(exp(20x(1-x))) will be solved using the linear
% system produced in bvpFull with the given parameters of beta = pi and
% gamma = 100pi^4. The results are shown below for N = 200 and N = 2000:
beta2 = pi;
gamma2 = 100 * (pi .^ 4);

[y5,x5] = bvpFull(200, beta2, gamma2, 2);
[y6,x6] = bvpFull(2000, beta2, gamma2, 2);

%formatting
figure('Units', 'pixels', ...
    'Position', [100 100 600 600]);

plot(x5, y5, ...
  'LineStyle', '-', ...
  'LineWidth', 2, ...
  'Color', 'b');
hold;
plot(x6, y6, ...
  'LineStyle', '-', ...
  'LineWidth', 2, ...
  'Color', 'r');

hTitle = title('The Graph of f(x) = cos(exp(20x(1-x)))');
hXLabel = xlabel('x Values from 0 to 1');
hYLabel = ylabel('Values of f(x)');
hLegend = legend({'N = 200', 'N = 2000'}, ...
    'Location', 'northeast');

set([hXLabel, hYLabel, hTitle, hLegend], ...
    'FontName', 'Courier 10 Pitch', ...
    'FontSize', 14, ...
    'FontWeight', 'bold');

set(gca, ...
    'Box', 'off', ...
    'TickDir', 'out', ...
    'TickLength', [.02 .02], ...
    'XMinorTick', 'on', ...
    'YMinorTick', 'on', ...
    'YTickLabel', num2str(transpose(get(gca, 'YTick'))));
%%
% As you can see by visually inspecting the graph, larger values of N will
% produce increasingly more accurate approximations of the solution to the
% boundary value problem.
%% Part 3. Computational Complexity of Numerical Solutions to BVPs
% Because N must be larger to obtain a good approximation of the solution
% function, the complexity time required to solve the BVP using a linear
% system is significant. If the method is inefficient, then increasingly
% large values of N will result in unacceptably long computation times.
% Therefore, the computation time for this method will be measured below
% using MATLAB(R)'s built-in tic toc function for values of N of increasing
% size:
tic; [y6,x6] = bvpFull(200, beta2, gamma2, 2); toc;
tic; [y6,x6] = bvpFull(2000, beta2, gamma2, 2); toc;
tic; [y6,x6] = bvpFull(15000, beta2, gamma2, 2); toc;
%%
% As you can see from the elapsed times that are produced, the time
% required to compute the values of the bvpFull function increases rapidly
% as N becomes large. After N = 10000, where the elapsed to is
% approximately 2 seconds, the time requirement becomes much more
% significant with 30+ seconds required to compute bvpFull for N = 15000.
% This shows that MATLAB(R)'s method of solving linear systems is somewhat
% inefficient.