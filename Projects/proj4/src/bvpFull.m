%
% Title: bvpFull.m
% Summary: function to solve a boundary value problem by solving a linear
% system of numerical derivatives
% Author: Zack Fout
% Version: 1.0
% Last Modified: 04/21/2015
% Notes: working on basic functionality
% Parameters:
%   N       the number of subintervals to divide the interval [0,1] into
%   beta    a given constant for the first derivative
%   gamma   a given constant for the second derivative
%   fcn     a function handler for the analytic function
%
function [y,x] = bvpFull(N, beta, gamma, flag)
  gridpoints=0:(1/N):1;
  x = gridpoints([2:end-1]);
  
  h_squared = x(1) .^ 2;
  a = -(2 / h_squared) + gamma;
  b = (1 / h_squared) + (beta / (2 * x(1)));
  c = (1 / h_squared) - (beta / (2 * x(1)));
  
  A = full(gallery('tridiag', N - 1, c, a, b));
  
  if flag == 1
    for k=1:N-1
      f(k) = (pi .^ 2) * cos(pi * x(k));
    end
  elseif flag == 2
    for k=1:N-1
      exp_part = exp((20 * x(k)) * (1 - x(k)));
      f(k) = cos(exp_part);
    end
  end
  
  f_col = transpose(f);
  y_col = A \ f_col;
  y = transpose(y_col);
  y = [0 y 0];
  x = gridpoints;
end
  
  
  
