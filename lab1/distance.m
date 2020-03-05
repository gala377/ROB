function res = distance(sample, data)
    res = sqrt(sum(((data - sample) .^ 2), 2));
endfunction