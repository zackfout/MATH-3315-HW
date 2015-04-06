%
% Title: lagrange.m
% Summary: function to compute the Lagrange interpolating polynomial
% Author: Zack Fout
% Version: 1.0
% Last Modified: 04/06/2015
% Notes: Completed basic functionality
% Parameters:
%   x       points where the interpolating polynomial is to be evaluated
%   xNodes  the x-values of the data points
%   fNodes  the y-values of the data points
%   p       the function value of the interpolating polynomial at x
%

function p = lagrange(x, xNodes, fNodes)
  x_size = length(x); % length of the evaluation points
  degree = length(xNodes); % degree of the interpolating polynomial
  for i=1:x_size % loop over the evaluation points
    p_term = 0;
    for j=1:degree % loop over the length of the given points
      lagrange_coeff = 1;
      lagrange_numerator = 1;
      lagrange_denominator = 1;
      % loop over the length of the given points for the current coefficient
      for k=1:degree
        if (k ~= j)
          % compute the numerator term of the lagrange coefficient
          lagrange_numerator = lagrange_numerator * (x(i) - xNodes(k));
          % compute the denominator term of the lagrange coefficient
          lagrange_denominator = lagrange_denominator * (xNodes(j) - xNodes(k));
        end
      end
      % compute the lagrange coefficient for the current evaluation point
      lagrange_coeff = lagrange_numerator / lagrange_denominator;
      % sum the terms of the lagrange polynomial
      p_term = p_term + (fNodes(j) * lagrange_coeff);
    end
    p(i) = p_term; % store the function value in the vector p
  end
end
