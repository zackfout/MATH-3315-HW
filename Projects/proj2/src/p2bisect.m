%
% This function approximates the root of the characteristic function of a 
% dielectric slab waveguide using the bisection method. See waveguide.m
% for more details on the waveguide function.
%
function [c, res] = p2bisect(a, b, N, omega)
ya = waveguide(a, omega); % determine f(a) for the waveguide function
yb = waveguide(b, omega); % determine f(b) for the waveguide function

if (ya*yb > 0) % if they are both positive, the root is not in the interval
    c = nan;
    return;
end

for k=0:N
    c = 0.5*(a+b); % find the arithmetic mean of the endpoints
    yc = waveguide(c, omega); % compute f(c)
    if (ya*yc < 0) % shrink interval to [a, c]
        yb = yc;
        b = c;
    else % shrink interval to [c, b]
        ya = yc;
        a = c;
    end
end

c = 0.5*(a+b); % final approximation of the root
res = abs(waveguide(c, omega)); % final error on the root
end