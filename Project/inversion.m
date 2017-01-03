function [ newSolution, energyDifference ] = inversion( currentSolution, ...
    citiesDistances )
%INVERSION implements the "inversion" improvement heuristic
%   input:  currentSolution: permutation of the cities, which is a current
%               solution to the TSP problem
%           citiesDistances: distances between cities
%
%   output: newSolution: better or equal solution to the TSP problem
%           energyDifference: difference between new solution distance and
%               old solution distance

n = size(citiesDistances, 1);

% determine i
i = randi(n);

% determine j ~= i
j = randi(n);
while (i == j)
    j = randi(n);
end

% determine orientation such that i < j
if (i > j)
    currentSolution = fliplr(currentSolution);
end

% determine successors of i and j
if (1 <= i && i <= n-1); succI = i + 1; else succI = 1; end
if (1 <= j && j <= n-1); succJ = j + 1; else succJ = 1; end

while (succI == j || succJ == i) 
    % determine i
    i = randi(n);

    % determine j ~= i
    j = randi(n);
    while (i == j)
        j = randi(n);
    end

    % determine orientation such that i < j
    if (i > j)
        currentSolution = fliplr(currentSolution);
    end

    % determine successors of i and j
    if (1 <= i && i <= n-1); succI = i + 1; else succI = 1; end
    if (1 <= j && j <= n-1); succJ = j + 1; else succJ = 1; end
end

% compute energy difference
energyDifference = ...
    citiesDistances(currentSolution(i), currentSolution(j)) ...
    + citiesDistances(currentSolution(succI), currentSolution(succJ)) ... 
    - citiesDistances(currentSolution(i), currentSolution(succI)) ...
    - citiesDistances(currentSolution(j), currentSolution(succJ));

% accept or reject new solution
if energyDifference > 0 % new solution is not better
    newSolution = currentSolution;
    disp('New solution is not better -> rejecting');
end

end

