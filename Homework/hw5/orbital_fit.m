%
% Title: orbital_fit.m
% Summary: function to compute the orbital function for the Sol System
% using the power fit method for input data
% Author: Zack Fout
% Version: 1.1
% Last Modified: 04/13/2015
% Notes: finished basic functionality
% Parameters:
%   t       sampled sidereal period values
%   x       sampled distance values
%
function y = orbital_fit(x, tNodes, dNodes)
  numer_sum = 0.0;
  denom_sum = 0.0;
  c = 0.0;
  N = length(tNodes);
  for k=1:N
      numer_sum = numer_sum + ((dNodes(k) .^ 1.5) * tNodes(k)); % calculate numer
      denom_sum = denom_sum + (dNodes(k) .^ 3); % calculate denom
  end
  c = numer_sum ./ denom_sum; % find the constant
  M = length(x);
  for k=1:M
      y(k) = c * (x(k) .^ 1.5); % find the function values
  end
end