function label = cls1nn(sample, train)
    substracted = train(:, 2:end) - repmat(sample, rows(train), 1);
    distance = sumsq(substracted, 2);
    [~, idx] = min(distance, [], 1);
    label = train(idx, 1);
end