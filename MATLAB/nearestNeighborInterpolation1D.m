function yi = nearestNeighborInterpolation1D(x, y, xi)
    h   = x(2) - x(1);                        % uniform spacing
    idx = round((xi - x(1)) / h) + 1;         % nearest index
    idx = min(max(idx, 1), numel(x));         % clamp to [1, numel(x)]
    yi  = y(idx);                             % direct lookup
end
