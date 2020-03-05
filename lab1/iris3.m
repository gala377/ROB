iris = loadiris();

dist = @(sample, matrix) sum(abs(matrix - sample), 2);

good = 0;
bad = 0;

for i = 1:100
    expected = iris(i, end);
    actual = classifyiris(i, iris, dist);
    if expected == actual
        good = good + 1;
    else
        bad = bad + 1;
    endif
endfor
