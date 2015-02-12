function c = bisect(a,b, N)

ya = fcn(a);
yb = fcn(b);

if ( ya*yb > 0 ) 
    c = nan;
    return;
end

for k=0:N
    c = 0.5*(a+b);
    yc = fcn(c);
    if ( ya*yc < 0 )
        yb = yc;
        b = c;
    else
        ya = yc;
        a = c;
    end
end

c = 0.5*(a+b);
end

function y = fcn(x)
   y = x^2 - 2;
end
