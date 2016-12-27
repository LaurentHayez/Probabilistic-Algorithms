dist = zeros(1,maxRun);
sigma = cell(1, maxRun);

for i = 1:maxRun
    [sol, d] = bestInsertion(citiesDistances);
    dist(i) = d;
    sigma{i} = sol;
end

[minL, idx] = min(dist);
maxL = max(dist);
meanL = mean(dist);

plot(citiesCoordinate(1, sigma{idx}), citiesCoordinate(2, sigma{idx}));
title('Solution path: best insertion');