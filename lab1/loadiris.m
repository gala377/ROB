function iris = loadiris()
    load iris2.txt;
    load iris3.txt;
    iris = [iris2, repmat(1, 50, 1); iris3, repmat(2, 50, 1)](:, 2:6);
endfunction