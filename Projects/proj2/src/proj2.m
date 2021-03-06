%% *MATH 3315 Project 2 - Root Acquisition - By Zack Fout*
%% Part 1. The Characteristic Function of a Dielectric Slab Waveguide
% An optical waveguide is a physical structure that guides
% electromagentic waves in the optical spectrum. Optical waveguides have
% many important engineering applications where they are typically used
% as the transmission medium for optical communications systems. The
% Slab Waveguide is a theoretical dielectric structure that is used to
% understand practical rectangular-geometry optical waveguides. The
% characteristic function of this waveguide is given by:
%
% $$f(\beta, \omega) = cos(\alpha_1)(\alpha_1 - {\alpha_1}{\alpha_0})
% + sin(\alpha_1)({\alpha_1}^{2} - {\alpha_0}^{2})$,
%
% where
%
% $$\alpha_0 = \sqrt{\beta^{2} - {n_0}^{2}{\omega}^{2}}$
%
% $$\alpha_1 = \sqrt{{n_1}^{2}{\omega}^{2} - \beta^{2}}$
%
% and $${n_0}$, $${n_1}$ are the refractive indices of the dielectric layers,
% $$\omega$ is the frequency of the guided wave and $$\beta$ is the
% propagation constant. In order to determine which optical waves are
% guided by the waveguide, the equation
%
% $$f(\beta, \omega) = 0$
%
% must be solved for $$\beta$ where $$\omega$ is a given parameter. If the 
% refractive indices are fixed at $$n_0 = 1$ and $$n_1 = 2$, then different
% values of $$\beta$ may be evaluated in order to determine the exact
% $$\beta$ where the characteristic function is equal to zero. Note that
% from the definitions of $$\alpha_0$ and $$\alpha_1$ it is clear that
% real values of $$f(\beta, \omega)$ may only be computed over the interval
% $$[{{n_0}\omega}, {{n_1}\omega}]$. The following MATLAB(R) code evaluates
% the characteristic function for a given value of $$\omega = 1$ and plots
% the resulting curve:
omega = 1.0;
beta = omega * linspace(1, 2, 1000); % calculate interval of betas
for i = 1 : 1000
    y(i) = waveguide(beta(i), omega); % compute waveguide function
end

% The following lines of code plot and format the waveguide function
figure('Units', 'pixels', ...
    'Position', [100 100 750 800]);
hold on;
plot(beta, y, ...
    'LineStyle', '-', ...
    'LineWidth', 2, ...
    'Color', 'c');

hTitle = title('Characteristic Function of a Dielectric Slab Waveguide');
hXLabel = xlabel('Propagation Constant $$(\beta)$$');
hYLabel = ylabel('$$f(\beta, \omega)$$');

set([hXLabel, hYLabel], ...
    'FontSize', 20, ...
    'Interpreter', 'latex');
set(hXLabel, 'Position', get(hXLabel, 'Position') - [0 .3 0]);
set(hYLabel, 'Position', get(hYLabel, 'Position') - [.04 0 0]);
set(hTitle, ...
    'FontName', 'Courier 10 Pitch', ...
    'FontSize', 14, ...
    'FontWeight', 'bold');

drawbrace([1.54, -.45], [1.54, .45], 8, 'Color', 'k');
drawbrace([1.58, .45], [1.58, -.45], 8, 'Color', 'k');

hLegend = legend('$$f(\beta, \omega)$$','Location', 'east');
set(hLegend, ...
    'FontSize', 16, ...
    'Interpreter', 'latex');

set(gca, 'FontName', 'Helvetica');
set(gca, ...
    'Box', 'off', ...
    'TickDir', 'out', ...
    'TickLength', [.02 .02], ...
    'XMinorTick', 'on', ...
    'YMinorTick', 'on', ...
    'YGrid', 'on', ...
    'GridLineStyle', '--', ...
    'YTick', -2:2:6, ...
    'XColor', [.3 .3 .3], ...
    'YColor', [.3 .3 .3], ...
    'LineWidth', 1);
%%
% As you can see by visually inspecting the graph, the solution $$\beta$ 
% to the equation $$f(\beta, \omega) = 0$ lies somewhere between the values
% 1.56 and 1.57.
%% Part 2. Root Acquisition using the Bisection Method
% The Bisection Method is an iterative approach that will be used here to
% approximate the exact root of the characteristic function. The method
% works by following a simple assumption: for a given continuous function 
% over an interval [a, b], if f(a) is less than zero and f(b) is greater
% than zero, then the root of the function _must_ lie within this interval.
% Then, the midpoint of the interval _c_ is computed and the function is
% evaluated at c. If f(a) and f(c) have opposite signs, then the root must
% lie within [a, c] and the original interval [a, b] is split in half.
% Similarly, if instead f(c) and f(b) have opposite signs, then the
% interval is split into [c, b]. By iteratively calculating succesive
% intervals in this way a sufficiently small interval is found, and the 
% function evaluated at the midpoint of this interval is used to
% approximate the true root. The function p2bisect.m implements the
% bisection method for the waveguide function, the results of which are
% shown below. Note that the frequency $$\omega$ is still equal to one:
epsilon = power(10, -12);

a = 1.5;
b = 1.6;
N = 1 + round((log(b - a) - log(epsilon)) / log(2));
[c, res] = p2bisect(a, b, N, omega);
fprintf('For omega = 1:\n');
fprintf('The approximated root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);
%% Part 3. Evaluating Different Frequency Values
% Because $$\omega$ is a given parameter and the propagation constant is
% the value we are trying to find, supplying different values of $$\omega$
% to the waveguide function will produce different curves. If $$\omega$ is
% set to 8, then the following graph is produced:

omega = 8.0;
beta = omega * linspace(1, 2, 1000); % calculate interval of betas
for i = 1 : 1000
    y(i) = waveguide(beta(i), omega); % compute waveguide function
end

% The following lines of code plot and format the waveguide function
figure('Units', 'pixels', ...
    'Position', [100 100 1200 1000]);
hold on;
plot(beta, y, ...
    'LineStyle', '-', ...
    'LineWidth', 2, ...
    'Color', 'r');

hTitle = title('Characteristic Function of a Dielectric Slab Waveguide');
hXLabel = xlabel('Propagation Constant $$(\beta)$$');
hYLabel = ylabel('$$f(\beta, \omega)$$');

set([hXLabel, hYLabel], ...
    'FontSize', 20, ...
    'Interpreter', 'latex');
set(hXLabel, 'Position', get(hXLabel, 'Position') - [0 25 0]);
set(hYLabel, 'Position', get(hYLabel, 'Position') - [.15 0 0]);
set(hTitle, ...
    'FontName', 'Courier 10 Pitch', ...
    'FontSize', 14, ...
    'FontWeight', 'bold');

drawbrace([9.45, -20], [9.45, 20], 8, 'Color', 'k');
drawbrace([9.8, 20], [9.8, -20], 8, 'Color', 'k');

drawbrace([11.5, -20], [11.5, 20], 8, 'Color', 'k');
drawbrace([11.85, 20], [11.85, -20], 8, 'Color', 'k');

drawbrace([13.2, -20], [13.2, 20], 8, 'Color', 'k');
drawbrace([13.55, 20], [13.55, -20], 8, 'Color', 'k');

drawbrace([14.75, -20], [14.75, 20], 8, 'Color', 'k');
drawbrace([15.1, 20], [15.1, -20], 8, 'Color', 'k');

drawbrace([15.55, -20], [15.55, 20], 8, 'Color', 'k');
drawbrace([15.8, 20], [15.8, -20], 8, 'Color', 'k');

hLegend = legend('$$f(\beta, \omega)$$', 'Location', 'northeast');
set(hLegend, ...
    'FontSize', 16, ...
    'Interpreter', 'latex');

set(gca, 'FontName', 'Helvetica');
set(gca, ...
    'Box', 'off', ...
    'TickDir', 'out', ...
    'TickLength', [.02 .02], ...
    'XMinorTick', 'on', ...
    'YMinorTick', 'on', ...
    'YGrid', 'on', ...
    'GridLineStyle', '--', ...
    'YTick', -200:100:200, ...
    'XColor', [.3 .3 .3], ...
    'YColor', [.3 .3 .3], ...
    'LineWidth', 1);
%%
% As you can see by visually inspecting the graph there are five different
% roots of the waveguide function when $$\omega$ is equal to 8. The
% following code will compute the roots of this function using the
% bisection method:
a = 9.0;
b = 10.0;
N = 1 + round((log(b - a) - log(epsilon)) / log(2));
[c, res] = p2bisect(a, b, N, omega);
fprintf('\nFor omega = 8:\n');
fprintf('The first root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);

a = 11.0;
b = 12.0;
N = 1 + round((log(b - a) - log(epsilon)) / log(2));
[c, res] = p2bisect(a, b, N, omega);
fprintf('\nThe second root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);

a = 13.0;
b = 14.0;
N = 1 + round((log(b - a) - log(epsilon)) / log(2));
[c, res] = p2bisect(a, b, N, omega);
fprintf('\nThe third root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);

a = 14.0;
b = 15.0;
N = 1 + round((log(b - a) - log(epsilon)) / log(2));
[c, res] = p2bisect(a, b, N, omega);
fprintf('\nThe fourth root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);

a = 15.0;
b = 16.0;
N = 1 + round((log(b - a) - log(epsilon)) / log(2));
[c, res] = p2bisect(a, b, N, omega);
fprintf('\nThe fifth root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);
%% Part 4. Root Acquisition using the Regula Falsi Method
% The Regula Falsi Method is another iterative approach to calculating the
% root of a function that was developed because the Bisection Method
% converges at a fairly slow rate. Regula Falsi works by computing the
% secant line of the desired function, and computing the values of a and b
% on the secant line. Then, the interval is shrunk by using the same logic
% implemented in the Bisection Method. The results of the Regula Falsi
% Method for the waveguide function are shown below. Note that omega is
% equal to eight:
a = 9.0;
b = 10.0;
[c, N, res] = regulafalsi(a, b, epsilon, omega);
fprintf('\nFor omega = 8 and epsilon = 1e-12:\n');
fprintf('The first root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);

a = 11.0;
b = 12.0;
[c, N, res] = regulafalsi(a, b, epsilon, omega);
fprintf('\nThe second root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);

a = 13.0;
b = 14.0;
[c, N, res] = regulafalsi(a, b, epsilon, omega);
fprintf('\nThe third root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);

a = 14.0;
b = 15.0;
[c, N, res] = regulafalsi(a, b, epsilon, omega);
fprintf('\nThe fourth root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);

a = 14.95;
b = 15.95;
[c, N, res] = regulafalsi(a, b, epsilon, omega);
fprintf('\nThe fifth root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);
%%
% As you can see, the Regula Falsi method requires far fewer iterations
% than are required by the Bisection Method, making it the more
% computationally efficient algorithm.
%% Part 5. Regula Falsi With Extremely Small Epsilon Values
% If the stopping criterium value epsilon is a very small floating point
% number near 1e-17, say 1e-15, then performing a subtraction operation
% with this number will result in catastrophic cancellation and massive
% loss of precision in the computed value. In the regulafalsi.m function
% the stopping criterium is reached when the function value at the midpoint
% c is less than epsilon. However in the last iteration of the function
% where the function value at c is _almost_ less than epsilon, before f(c)
% < epsilon is evaluated the function value at c must be computed. 
% The waveguide function, however, squares c intermediately and subtracts
% it from omega squared thus producing a number less than 1e-15. This 
% produces a catastrophic cancellation error which skews the resulting 
% approximation of the root. While this means that the waveguide function
% cannot be implemented with double-precision floating point numbers less
% than 1e-13, the result of the catastrophic cancellation may be emulated
% by simply setting epsilon equal to one, as is shown below:
epsilon = 1;

a = 9.0;
b = 10.0;
[c, N, res] = regulafalsi(a, b, epsilon, omega);
fprintf('\nFor omega = 8 and epsilon = 1e-15:\n');
fprintf('The first root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);

a = 11.0;
b = 12.0;
[c, N, res] = regulafalsi(a, b, epsilon, omega);
fprintf('\nThe second root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);

a = 13.0;
b = 14.0;
[c, N, res] = regulafalsi(a, b, epsilon, omega);
fprintf('\nThe third root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);

a = 14.0;
b = 15.0;
[c, N, res] = regulafalsi(a, b, epsilon, omega);
fprintf('\nThe fourth root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);

a = 14.95;
b = 15.95;
[c, N, res] = regulafalsi(a, b, epsilon, omega);
fprintf('\nThe fifth root of the waveguide function is: %.15f.\n', c);
fprintf('The number of iterations required ');
fprintf('to compute the root is: %g.\n', N);
fprintf('The residual of the root is: %d.\n', res);
%%
% As you can see, this produces a significantly larger residual on the root
% than the previous computed values with epsilon equal to 1e-12, thus
% approximating the results of catastrophic cancellation.