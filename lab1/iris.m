load iris2.txt;
load iris3.txt;
iris = [iris2, repmat(1, 50, 1); iris3, repmat(2, 50, 1)](:, 2:6);
 
sample = iris(1, 1:4); # tested values - push there some random values
 
dist = @(sample, matrix) sum(abs(matrix - sample), 2);

distances = dist(sample, iris(:, 1:4));
[~, row] = min(distances);
res_class = iris(row, 5);

