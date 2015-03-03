function [c, N, res] = regulafalsi(a, b, epsilon, omega)
  ya = waveguide(a, omega); % determine f(a) for the waveguide function
  yb = waveguide(b, omega); % determine f(b) for the waveguide function

  if (ya*yb > 0) % if they are both positive, the root is not in the interval
    c = nan;
    return;
  end
  
  flag = true;
  N = 0;

  while(flag)
    N = N + 1;
    dx = yb*(b - a)/(yb - ya);
    c = b - dx;
    ac = c - a;
    yc = waveguide(c, omega);
    if (yb*yc > 0) % shrink interval to [a, c]
        yb = yc;
        b = c;
    else % shrink interval to [c, b]
        ya = yc;
        a = c;
    end
    dx = min(abs(dx), ac);
    if (abs(yc) < epsilon)
        flag = false;
        break;
    end
  end

  c; % final approximation of the root
  N; % total number of iterations
  res = abs(waveguide(c, omega)); % final residual on the root
end