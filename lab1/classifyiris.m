function res = classifyiris(i, data, dist)
    sample = data(i, 1:4);
    data(i, :) = [];
    dinstances = dist(sample, data(:, 1:4));
    % dinstances
    [~, row] = min(dinstances);
    res = data(row, end);
endfunction