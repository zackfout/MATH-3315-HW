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
function y = waveguide(beta, omega)
  % compute a0 and a1
  a_0 = sqrt(power(beta, 2) - power(omega, 2));
  a_1 = sqrt((4 * power(omega, 2)) - power(beta, 2));
  
  % compute the characteristic equation
  arg1 = cos(a_0) * (a_1 - (a_1 * a_0));
  arg2 = sin(a_1) * (power(a_1, 2) - power(a_0, 2));
  y = arg1 + arg2;
end