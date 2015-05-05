%
% Title: proj5.m
% Summary: driver m-script for Project 5 for MATH 3315
% Author: Zack Fout
% Version: 1.0
% Last Modified: 05/04/2015
% Notes: completed project 5
%
%% *MATH 3315 Project 5 - Numerical Integration - By Zack Fout*
%% Part 1. Approximation of the Integral of sin(pi * x)exp(x)dx
% Integral calculus is an important concept in mathematics with many
% applications in physics and engineering. Integration of a function over an
% interval may be thought of as the area under the curve of the function. For
% many elementary functions the exact value of the integral is known but there
% are many important exceptions, such as the integral of exp(-x^2)dx, which is the
% error function. Therefore, numerical methods are used to approximate the
% value of definite integrals. These quadrature rules first approximate the
% function with an interpolating polynomial, divide the interval of
% integration into n equally spaced sub-intervals, approximate the area under
% the polynomial for each sub-interval, and finally sum these areas to form
% the complete approximation. The following MATLAB(R) code approximates the
% integral of sin(pi * x)exp(x)dx using the Midpoint, Trapezoidal, and Simpson
% quadrature rules for increasingly smaller sub-intervals of a desired interval
% of integration. The errors between the approximation and the actual value of
% the integral are also shown:
N = [10 20 40 80 160 320 640 1280];
fcn1 = @(x) sin(pi*x)*exp(x);
exact_val1 = (pi * (exp(2) - 1)) / (exp(1) * (1 + pi .^2));

for i=1:length(N)
  [mpr, trp, sim] = integrate(N(i), -1, 1, fcn1);
  mpr_arr1(i) = abs(mpr - exact_val1);
  trp_arr1(i) = abs(trp - exact_val1);
  sim_arr1(i) = abs(sim - exact_val1);

  fprintf('For N = %d, the approximation of the integral ', N(i));
  fprintf('of sin(pi*x)*exp(x)dx over the interval [-1, 1] is:\n');
  fprintf('%1.11f for the Midpoint Rule.\n', mpr);
  fprintf('%1.11f for the Trapezoidal Rule.\n', trp);

  if i == length(N)
    fprintf('%1.11f for the Simpson Rule.\n', sim);
  else
    fprintf('%1.11f for the Simpson Rule.\n\n', sim);
  end
end

figure('Units', 'pixels', ...
    'Position', [100 100 600 600]);

loglog(N, mpr_arr1, ...
  'LineStyle', '-', ...
  'LineWidth', 2, ...
  'Color', 'r');
hold on;
loglog(N, trp_arr1, ...
  'LineStyle', '-', ...
  'LineWidth', 2, ...
  'Color', 'g');
loglog(N, sim_arr1, ...
  'LineStyle', '-', ...
  'LineWidth', 2, ...
  'Color', 'b');

hTitle1 = title({'Errors of Numerical Integration Rules', 'for sin({\pi}x)e^xdx'});
hXLabel1 = xlabel('Number of Intervals (N)');
hYLabel1 = ylabel('Approximation Errors');
hLegend1 = legend({'Midpoint', 'Trapezoidal', 'Simpson'}, ...
    'Location', 'northeast');

set([hXLabel1, hYLabel1, hTitle1, hLegend1], ...
    'FontName', 'Courier 10 Pitch', ...
    'FontSize', 14, ...
    'FontWeight', 'bold');

set(gca, ...
    'Box', 'off', ...
    'TickDir', 'out', ...
    'TickLength', [.02 .02], ...
    'XMinorTick', 'on', ...
    'YMinorTick', 'on', ...
    'YTickLabel', num2str(transpose(get(gca, 'YTick'))), ...
    'XTickLabel', num2str(transpose(get(gca, 'XTick'))));
hold off;
%%
% As you can see by visually inspecting the graph above, the error
% values for all three numerical integration rules converge toward zero
% as the number of sub-intervals increases. Note that the rates of
% convergence for the Midpoint and Trapezoidal rules are fairly similar,
% while the Simpson rule converges at a much faster rate. This is due to
% the fact that the errors of the Midpoint and Trapezoidal rules 
% converge toward zero at a rate of h^2, where h is the length of each 
% sub-interval, while the error of the Simpson rule converges toward zero
% at a rate of h^4.
%% Part 2. Approximation of the Integral of abs(3 - x)^(2/3)dx
% The following MATLAB(R) code will determine the Midpoint, Trapezoidal,
% and Simpson rule approximations of the integral of abs(3 - x)^(2/3)dx. 
% The errors between the approximation and the actual value of the integral
% are also shown:
fcn2 = @(x) abs(3 - x).^ (2 ./ 3);
exact_val2 = 0.6 * ((3 .^ (5 ./ 3)) + (2 .^ (5 ./ 3)));

for i=1:length(N)
  [mpr, trp, sim] = integrate(N(i), 0, 5, fcn2);
  mpr_arr2(i) = abs(mpr - exact_val2);
  trp_arr2(i) = abs(trp - exact_val2);
  sim_arr2(i) = abs(sim - exact_val2);

  fprintf('For N = %d, the approximation of the integral ', N(i));
  fprintf('of abs(3 - x)^(2/3)dx over the interval [0, 5] is:\n');
  fprintf('%1.11f for the Midpoint Rule.\n', mpr);
  fprintf('%1.11f for the Trapezoidal Rule.\n', trp);

  if i == length(N)
    fprintf('%1.11f for the Simpson Rule.\n', sim);
  else
    fprintf('%1.11f for the Simpson Rule.\n\n', sim);
  end
end

figure('Units', 'pixels', ...
    'Position', [100 100 600 600]);

loglog(N, mpr_arr2, ...
  'LineStyle', '-', ...
  'LineWidth', 2, ...
  'Color', 'r');
hold on;
loglog(N, trp_arr2, ...
  'LineStyle', '-', ...
  'LineWidth', 2, ...
  'Color', 'g');
loglog(N, sim_arr2, ...
  'LineStyle', '-', ...
  'LineWidth', 2, ...
  'Color', 'b');

hTitle2 = title({'Errors of Numerical Integration Rules', 'for abs(3 - x)^{(2/3)}dx'});
hXLabel2 = xlabel('Number of Intervals (N)');
hYLabel2 = ylabel('Approximation Errors');
hLegend2 = legend({'Midpoint', 'Trapezoidal', 'Simpson'}, ...
    'Location', 'northeast');

set([hXLabel2, hYLabel2, hTitle2, hLegend2], ...
    'FontName', 'Courier 10 Pitch', ...
    'FontSize', 14, ...
    'FontWeight', 'bold');

set(gca, ...
    'Box', 'off', ...
    'TickDir', 'out', ...
    'TickLength', [.02 .02], ...
    'XMinorTick', 'on', ...
    'YMinorTick', 'on', ...
    'YTickLabel', num2str(transpose(get(gca, 'YTick'))), ...
    'XTickLabel', num2str(transpose(get(gca, 'XTick'))));
hold off;
%%
% As you can see by visually inspecting the graph above, the errors for all
% three numerical integration rules converge toward zero at roughly the 
% same rate, a marked difference from the previous plot where the Simpson
% rule converged toward zero at a much faster rate than the Midpoint and
% Trapezoidal rules. This is due to the fact that abs(3 - x)^(2/3) is not
% infinitely many times differentiable over the interval [0, 5]. In
% particular, a vertical asymptote exists for this function at x = 3, where
% the derivatives are undefined.
%% Part 3. Approximation of the Integral of sin(k * pi * x)exp(x)dx
% Now, the function sin(k * pi * x)exp(x) will be integrated using the
% Simpson rule for different values of k, and the errors between the 
% approximation and the actual value of the integral will be shown:
k = [-4 -3 -2 -1 1];
N1 = [10 20 40 80 160 320];

figure('Units', 'pixels', ...
    'Position', [100 100 600 600]);
hold all;
for i=1:length(k)
  fcn = @(x) sin(k(i) * pi * x) * exp(x);
  exact_val = ((-1) .^ (k(i) + 1)) * ((k(i) * pi * (exp(1) - exp(-1))) ./ (1 + (k(i) * pi) .^ 2));
  for j=1:length(N1)
    [mpr, trp, sim] = integrate(N1(j), -1, 1, fcn);
    sim_arr3(j) = abs(sim - exact_val);
  end
  loglog(N1, sim_arr3, ...
    'LineStyle', '-', ...
    'LineWidth', 2);
  ylim([0, .000001]);
end

hTitle3 = title({'Errors of the Simpson Rule', 'for sin(k{\pi}x)e^xdx'});
hXLabel3 = xlabel('Number of Intervals (N)');
hYLabel3 = ylabel('Approximation Errors');
hLegend3 = legend({'k = -4', 'k = -3', 'k = -2', 'k = -1', 'k = 1'}, ...
    'Location', 'northeast');

set([hXLabel3, hYLabel3, hTitle3, hLegend3], ...
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
hold off;
%%
% As you can see by visually inspecting the graph above, the value of N
% needed to reduce the error between the exact value of the integral and
% approximation produced by the Simpson rule to a value less than 10^{-6}
% decreases in size as k increases. For the largest value of k about 100
% sub-intervals are required to reach this tolerance, while less than half
% this number is required to reach the same tolerance for the lowest value
% of k.