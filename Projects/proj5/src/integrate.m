function [mpr, trp, sim] = integrate(N, a, b, fcn)
  h = (b - a) / N;
  s = 0;
  for k = 1 : (N - 1)
      x = a + h * k;
      s = s + fcn(x);
  end
  s = h * (fcn(a) + fcn(b)) / 2 + h * s;
end