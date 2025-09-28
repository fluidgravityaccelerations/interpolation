function yo = lagrangeInterpolation(xi, yi, xo)

Ni              = length(xi);
A               = zeros(Ni, Ni);
for k = 1 : Ni
    temp        = poly(xi((1 : Ni) ~= k));
    A(k, :)     = temp / polyval(temp, xi(k));
end
yo              = polyval(yi * A, xo);
