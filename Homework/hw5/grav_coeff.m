%
% Title: grav_coeff.m
% Summary: function to compute the gravitational constant g for Earth
% using the power fit method for input data
% Author: Zack Fout
% Version: 1.1
% Last Modified: 04/13/2015
% Notes: finished basic functionality
% Parameters:
%   t       sampled time values
%   d       sampled distance values
%
function g = grav_coeff(t, d)
  numer_sum = 0.0;
  denom_sum = 0.0;
  alpha = 0.0;
  N = length(t);
  for k=1:N
      numer_sum = numer_sum + ((t(k) .^ 2) * d(k)); % calculate numerator
      denom_sum = denom_sum + (t(k) .^ 4); % calculate denominator
  end
  alpha = numer_sum ./ denom_sum; % find alpha
  g = 2 * alpha; % find g in terms of alpha
end