%
% This function computes the number of iterations n to pass to the function
% p2bisect.m. a and b are the inclusive interval endpoints, and eps is an
% optional parameter to specify the desired accuracy of the residual of the
% root calculated by p2bisect.m.
%
function n = bisect_iterations(a, b, varargin)
  % this block of code handles input validation and optional params
  p = inputParser; % initialize a function input parser
  addRequired(p,'a', @isnumeric); % require the a param
  addRequired(p,'b', @isnumeric); % require the b param
  % optional specification of maximum number error on the root must be
  % less than, the default value is 10^(-12)
  addOptional(p, 'eps', @isnumeric);
  parse(p, a, b, varargin{:}); % validate inputs
  
  switch nargin % check the number of input arguments
      case 3
          n = ceil(log((p.Results.b - p.Results.a)/p.Results.eps)/log(2));
      case 2
          n = ceil(log((p.Results.b - p.Results.a)/power(10, -12))/log(2));
      otherwise
          error('bisect_iterations', 'Wrong number of inputs');
  end
end