function yout = cubicSplineInterpolation(xin, yin, xout)

N           = length(xin) - 1;
Nout        = length(xout);

% Calculate intervals
h           = xin(2 : end) - xin(1 : end-1);

% Set up tridiagonal system for natural spline (m0 = mN = 0)
lowerDiagonal = h(1:end-1);
mainDiagonal  = 2 * (h(1:end-1) + h(2:end));
upperDiagonal = h(2:end);

A = spdiags([lowerDiagonal(:) mainDiagonal(:) upperDiagonal(:)], [-1 0 1], N-1, N-1);

% Right-hand side
d = (yin(3:end) - yin(2:end-1)) ./ h(2:end) - (yin(2:end-1) - yin(1:end-2)) ./ h(1:end-1);
b = 6 * d(:);

% Solve for m1 through m_{N-1}
m_interior = A \ b;

% Natural spline: m0 = mN = 0
m = [0; m_interior; 0];

% Calculate spline coefficients using standard formulas
% For interval [x_i, x_{i+1}]:
% S_i(x) = a_i + b_i*(x-x_i) + c_i*(x-x_i)^2 + d_i*(x-x_i)^3
a_coeff = yin(1:end-1)';
b_coeff = (yin(2:end) - yin(1:end-1))' ./ h' - h' .* (2*m(1:end-1) + m(2:end)) / 6;
c_coeff = m(1:end-1) / 2;
d_coeff = (m(2:end) - m(1:end-1)) ./ (6 * h');

% Evaluate spline at output points
yout = zeros(1, Nout);
for k = 1 : length(xout)
    % Find which interval xout(k) belongs to
    ind = find(xin <= xout(k), 1, 'last');
    if isempty(ind) || ind == length(xin)
        ind = length(xin) - 1; % Use last interval
    end
    
    % Evaluate using left endpoint xin(ind)
    dx = xout(k) - xin(ind);
    yout(k) = a_coeff(ind) + b_coeff(ind) * dx + c_coeff(ind) * dx^2 + d_coeff(ind) * dx^3;
end
