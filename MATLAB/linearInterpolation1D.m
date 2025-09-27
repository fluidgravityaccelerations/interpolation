function yi = linearInterpolation1D(x, y, xi)
    h   = x(2) - x(1);                         % uniform spacing
    idx = floor((xi - x(1)) / h) + 1;          % left index
    idx = min(max(idx, 1), numel(x)-1);        % clamp to [1, numel(x)-1]
    
    alpha = (xi - x(idx)) / h;                 % interpolation weight
    yi    = (1 - alpha) .* y(idx) + alpha .* y(idx+1);
end
