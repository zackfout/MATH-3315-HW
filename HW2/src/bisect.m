function [c, res] = bisect(a,b, N, omega)
ya = waveguide(a, omega);
yb = waveguide(b, omega);

if ( ya*yb > 0 ) 
    c = nan;
    return;
end

for k=0:N
    c = 0.5*(a+b);
    yc = waveguide(c, omega);
    if ( ya*yc < 0 )
        yb = yc;
        b = c;
    else
        ya = yc;
        a = c;
    end
end

c = 0.5*(a+b);
res = abs(waveguide(c, omega));
end