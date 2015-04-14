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
% $$p(x) = a_{n}x^{n} + a_{n - 1}x^{n - 1} + a_{n - 2}x^{n - 2} + ...
% + a_{2}x^{2} + a_{1}x + a_{0}$,
%
% it may be transformed into the equivalent expression
%
% $$p(x) = (...((a_{n}x + a_{n - 1})x + a_{n - 2})x + ...)x + a_{2})x +
% a_{1})x +a_{0}$
%
% by means of the Horner Scheme. This method may be easily implemented
% using an iterative approach. Consider the following MATLAB(R) code:
%
%   function p=horner(x,a)
%       n = length(a);
%       p = a(1); % set p to the first element of a
%       for j=2:n % iterate over the remaining elements of a
%           p = p*x + a(j); % store the next part of the scheme in p
%       end
%   end
%
% where x is the input for p(x) and a is an array of the coefficents of
% the Horner Scheme representation of p(x). This function will produce the
% correct outputs for the polynomial $$y = (1 - x)^{4}$, a few of which are
% shown here:
a = [1, -4, 6, -4, 1];
for j = -2 : 4
    p = horner(j, a); % compute Horner scheme representation
    fprintf('The function value for x = %g is %g.\n', j, p);
end
%%
% These output values are congruent with the computed values found using
% traditional methods.
%
% * *Graph of* $$y = (1 - x)^{4}$
x = linspace(-1, 1, 1000);
for i = 1 : 1000
    y(i) = horner(x(i), a); % compute Horner scheme representation
end
semilogy(x, y, 'm');
str = '$$y = (1 - x)^{4}$$'; % latex equation for y = (1 - x)^4
text(-0.2, 0.01, str, 'FontSize', 20, 'Interpreter', 'latex'); % formatting
title('The Graph of y = (1 - x)^4');
xlabel('Independent Variable x');
ylabel('Dependent Variable y');
%%
% This plot shows that as x approaches 1, the limit of $$y = (1 -
% x)^{4}$ converges to zero.
%% Part 2. Applying the Horner Scheme to the Exponential Function
% In order to apply Horner's method to the exponential function $$e^{x}$,
% it must first be converted into a polynomial. The Taylor approximation
% of a function centered at _a_,
%
% $$\sum_{n = 0}^{\infty}\frac{f^{(n)}(a)}{n!}(x - a)^{n}$,
%
% is convenient for representing functions as a sum of terms. If the Taylor
% expansion is centered at 0, then it is a special case of the Taylor
% series called a Mclaurin series. The nth partial sum of the Mclaurin 
% expansion of $$e^{x}$ is
%
% $$e^{x} = \sum_{k = 0}^{n}\frac{x^{k}}{k!} = \frac{x^{n}}{n!} +
% \frac{x^{(n - 1)}}{(n - 1)!} + \frac{x^{(n - 2)}}{(n - 2)!} + ...
% + \frac{x^{2}}{2!} + x + 1$.
%
% By computing the (n - 1)st coefficients of the Mclaurin expansion of
% $$e^{x}$, the horner function described in Part 1 may be used to
% approximate the value of the exponential function at a given x value.
% Consider the following MATLAB(R) code:
%
%   function a=getTaylorCoeff(n)
%       for k = 1 : n % loop from 1 to n
%           a(k) = 1.0/factorial(n - k) % compute the coefficient at k
%       end
%   end
%
% where n is the number of terms to be computed. This method will produce
% correct approximations for  $$e^{13.8}$, a few of which are shown here:
fprintf('exp(13.8) is equal to: %g.\n', exp(13.8));
for i = 10 : 10 : 40
    b = getTaylorCoeff(i); % determine Taylor expansion coefficients
    q = horner(13.8, b); % compute Horner scheme representation
    rel_err1 = abs(q - exp(13.8)) / exp(13.8); % compute relative error
    fprintf('The approximation for exp(13.8) with %g terms is %g, ', i, q);
    fprintf('and the relative error on exp(13.8) with %g terms is %e.\n', i, rel_err1);
end
%%
% It can be seen that while the relative error on $$e^{x}$ is very small
% with 40 terms in the Taylor approximation, it is nonzero and therefore
% it cannot be said that the Taylor series converges to the exact value
% of $$e^{x}$. Interestingly, both the 40 term approximation and the real
% value of $$e^{x}$ appear to be equivalent, yet the relative error is
% nonzero. This is due to loss of significance on the floating point
% calculation, which will be explored further in the following parts.
%% Part 3. Cancellation Errors in the Taylor Approximation
% The approach used in Part 2 will be used here to approximate
% $$e^{-13.8}$. By modifying the above code, the following output is
% produced:
fprintf('exp(-13.8) is equal to: %e.\n', exp(-13.8));
for i = 10 : 10 : 40
    c = getTaylorCoeff(i); % determine Taylor expansion coefficients
    r = horner(-13.8, c); % compute Horner scheme representation
    rel_err2 = abs(r - exp(-13.8)) / exp(-13.8); % compute relative error
    fprintf('The approximation for exp(-13.8) with %g terms is %e, ', i, r);
    fprintf('and the relative error on exp(-13.8) with %g terms is %e.\n', i, rel_err2);
end
%%
% Here, the calculated relative error is much larger than the absolute
% error for exp(-13.8) and  the relative error found for $$e^{13.8}$.
% While the approach used in Part 2 ought to work for this case, it fails
% because the approximated value of $$e^{-13.8}$ is very close to the
% value computed by exp(-13.8) and the subtraction used to calculate
% the relative error produces a cancellation error because the result is a
% number that is too small to be stored as a floating point number. This
% results in a reduction of the accuracy of the subtraction operation, and
% produces the larger than expected value for the relative error.
% Therefore, it may be said that the convergence of the Taylor
% approximation to the exact value of exp(-13.8) is extremely close but not
% equivalent.
%% Part 4. Cancellation Errors in the Taylor Approximation Continued
% Now, the approach used in Part 2 will be used to approximate
% $$\frac{1}{e^{13.8}}$. By modifying the code presented in Part 2 yet
% again, the following output is produced:
fprintf('1/exp(13.8) is equal to %e.\n', 1/exp(13.8));
for i = 10 : 10 : 40
    d = getTaylorCoeff(i); % determine Taylor expansion coefficients
    s = 1/horner(13.8, d); % compute Horner scheme representation
    rel_err3 = abs(s - exp(-13.8)) / exp(-13.8);
    fprintf('The approximation for 1/exp(13.8) with %g terms is %e, ', i, s);
    fprintf('and the relative error on 1/exp(13.8) with %g terms is %e.\n', i, rel_err3);
end
%%
% In this example, $$\frac{1}{e^{13.8}}$ is formed by taking the reciprocal
% of the approximated values calculated in Part 2, rather than determining
% the value produced by the Horner Scheme with -13.8. This method produces
% accurate approximations of $$\frac{1}{e^{13.8}}$, which is confirmed by
% the calculated relative errors, and avoids the cancellation errors
% produced in Part 3 because $$e^{13.8}$ is not prone to limit errors
% caused by loss of accuracy in computing very large numbers, so taking its
% reciprocal does not reduce the accuracy of the final result. Therefore,
% the approximation for $$\frac{1}{e^{13.8}}$ is accurate. These examples
% serve to illustrate the limitations of storing floating point numbers
% with machine precision and how these limitations may be avoided.
