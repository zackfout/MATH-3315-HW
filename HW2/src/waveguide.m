%
% This function evaluates the characteristic equation of a dielectric
% slab waveguide,
% f(beta, omega) = cos(a1)(a1 - a1*a0) + sin(a1)(a1^2 - a0^2),
% where 
% a0 = sqrt(beta^2 - n0^2*omega^2), 
% a1 = sqrt(n1^2*omega^2 - beta^2).
% beta is the propagation constant, omega is the frequency of the wave
% and n0, n1 are refractive indices.
% note: n0 and n1 are optional parameters whose default values are 1 and
% 2 respectively.
%
function y = waveguide(beta, omega, varargin)
  % this block of code handles input validation and optional params
  p = inputParser; % initialize a function input parser
  addRequired(p,'beta', @isnumeric); % require the beta param
  addRequired(p,'omega', @isnumeric); % require the omega param
  addOptional(p, 'n_0', 1, @isnumeric); % optional
  addOptional(p, 'n_1', 2, @isnumeric); % optional
  parse(p, beta, omega, varargin{:}); % validate inputs
  
  % assign temporary values to input results
  beta = power(p.Results.beta, 2);
  omega = power(p.Results.omega, 2);
  n_0 = power(p.Results.n_0, 2);
  n_1 = power(p.Results.n_1, 2);
  
  % compute a0 and a1
  a_0 = sqrt(beta - (n_0 * omega));
  a_1 = sqrt((n_1 * omega) - beta);
  
  % compute the characteristic equation
  arg1 = cos(a_0) * (a_1 - (a_1 * a_0));
  arg2 = sin(a_1) * (power(a_1, 2) - power(a_0, 2));
  y = arg1 + arg2;
end