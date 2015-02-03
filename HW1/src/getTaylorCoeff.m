%
% compute the coefficients of the (n - 1)st Taylor polynomial
% of the exponential function y = e^x.
%
function a=getTaylorCoeff(n)
    for k = 1 : n
        a(k) = 1.0/factorial(n - k);
    end
end