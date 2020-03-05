function [good, bad] = runmodel(iris, dist)
    good = 0;
    bad = 0;
    for i = 1:size(iris, 1)
        expected = iris(i, end);
        actual = classifyiris(i, iris, dist);
        if expected == actual
            good = good + 1;
        else
            bad = bad + 1;
        endif
    endfor
endfunction
