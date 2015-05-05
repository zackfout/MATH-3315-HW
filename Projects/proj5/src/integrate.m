%
% Title: integrate.m
% Summary: function to approximate a definite integral using the midpoint,
% trapezoidal, and simpson quadrature rules
% Author: Zack Fout
% Version: 1.0
% Last Modified: 05/02/2015
% Notes: completed trapezoidal rule, working on midpoint and simpson
% Parameters:
%   N       The number of desired subintervals of equal length
%   a       The first endpoint of the desired interval
%   b       The second endpoint of the desired interval
%   fcn     A function handle for the function to be integrated
%
% Outputs:
%   mpr     The midpoint rule summation
%   trp     The trapezoidal rule summation
%   sim     The simpson rule summation
%
function [mpr, trp, sim] = integrate(N, a, b, fcn)
  % Compute the midpoint rule approximation
  mpr_width = (b - a) / N; % width of the subintervals
  mpr = 0;
  for k = 1 : N
    x = a + ((k - 0.5) * mpr_width); % compute x_k
    mpr = mpr + fcn(x); % evaluate the function at x_k and add to the sum
  end
  mpr = mpr * mpr_width; % multiply the final summation by the width

  % Compute the trapezoidal rule approximation
  trp_width = (b - a) / N; % width of the subintervals
  trp = 0;
  for k = 1 : (N - 1)
      x = a + trp_width * k; % compute x_k
      trp = trp + fcn(x); % evaluate the function at x_k and add t the sum
  end
  trp = trp_width * (fcn(a) + fcn(b)) / 2 + trp_width * trp; % add the end vals

  % Compute the simpson rule approximation
  sim_width = (b - a) / (2 * N); % width of the subintervals
  sim = 0;
  sim1 = 0;
  sim2 = 0;
  for k = 1 : N % compute the rule for odd nodes
    x = a + sim_width * (2 * k - 1); % compute x_k
    sim1 = sim1 + fcn(x); % evaluate the function at x_k and add to odd sum
  end
  for k = 1 : (N - 1) % compute the rule for even nodes
    x = a + sim_width * 2 * k; % compute x_k
    sim2 = sim2 + fcn(x); % evaluate the function at x_k and add to even sum
  end
  sim = sim_width * (fcn(a) + fcn(b) + 4 * sim1 + 2 * sim2) / 3; % final sum
end
