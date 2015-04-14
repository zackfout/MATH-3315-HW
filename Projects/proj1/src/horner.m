%
% evaluate the polynomial
%   y = a(1)*x^(n-1) + ... + a(n-1)*x + a(n) 
% using the horner scheme
%
function p=horner(x,a)
    n = length(a);
    p = a(1);
    for j=2:n
       p = p*x + a(j);
    end
end