%% *MATH 3315 Project 1 - Taylor Series - By Zack Fout*
%% Part 1. The Horner Scheme
% The Horner Scheme is an algorithm for calculating polynomials of the
% form:
%
% $$p(x) = \sum_{i=0}^{n}{a_{i}x^{i}}$$
%
% by transforming the monomial form of p(x) into a computationally
% efficient form.
%
% * *Evaluating polynomials*
%
% Given the polynomial
%
% $$y = (1 - x)^{4}$,
%
% which is equivalent to the polynomial
%
% $$y = x^{4} - 4x^{3} + 6x^{2} - 4x + 1$
% 
% and therefore of the form
%
% $$p(x) = a_{0} + a_{1}x + a_{2}x^{2} + ... + a_{n - 2}x^{n - 2} + 
% a_{n - 1}x^{n - 1} + a_{n}x^{n}$,
%
% it may be transformed into the equivalent expression
%
% $$p(x) = a_{0} + x(a_{1} + x(a_{2} + ... + x(a_{n - 2} + x(a_{n - 1} + 
% a_{n}x) ... )))$
%
% by means of the Horner Scheme. This method may be easily implemented
% using an iterative approach. Consider the following MATLAB(R) code:
%
%   function p=horner(x,a)
%       n = length(a);
%       p = a(1);            % set p to the first element of a
%       for j=2:n            % iterate over the remaining elements of a
%           p = p*x + a(j);  % store the next part of the scheme in p
%       end
%   end
%
% where x is the input for p(x) and a is an array of the coefficents of
% the Horner Scheme representation of p(x). This function will produce the
% correct outputs for the polynomial $$y = (1 - x)^{4}$, a few of which are
% shown here:
a = [1, -4, 6, -4, 1];
for j = -2 : 4
    p = horner(j, a);
    fprintf('The function value for x = %g is %g.\n', j, p);
end
%%
% These output values are congruent with the computed values found using
% traditional methods.
%
% * *Graph of* $$y = (1 - x)^{4}$
x = linspace(-1, 1, 1000);
for i = 1 : 1000
    y(i) = horner(x(i), a);
end
semilogy(x, y, 'm');
title('The Graph of y = (1 - x)^4');
xlabel('Independent Variable x');
ylabel('Dependent Variable y');
%%
% This plot shows that as x approaches 1, the limit of $$y = (1 -
% x)^{4}$ converges to zero.
%% Part 2. Applying the Horner Scheme to the Exponential Function

