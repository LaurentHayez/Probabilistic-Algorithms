function [ newSolution, energyDifference ] = swap( currentSolution, ...
    citiesDistances )
%SWAP implements the "swap" improvement heuristic
%   input:  currentSolution: permutation of the cities, which is a current
%   solution to the TSP problem
%           citiesDistances: distances between cities
%
%   output: newSolution: better or equal solution to the TSP problem
%           energyDifference: difference between new solution distance and
%           old solution distance
%
% See also L.

n = length(currentSolution);

[i, j] = randperm(n, 2);

if (1 <= i && i <= n-1); succI = i + 1; else succI = 1; end
if (2 <= i && i <= n); predI = i - 1; else predI = n; end
if (1 <= j && j <= n-1); succJ = j + 1; else succJ = 1; end
if (2 <= j && j <= n); predJ = j - 1; else predJ = n; end

% swap i and j to obtain newSolution
newSolution = currentSolution;
newSolution([i, j]) = newSolution(fliplr([i, j]));

% compute energy difference 
if (succI == j)
    energyDifference = ...
        citiesDistances(currentSolution(predI), currentSolution(j)) ...
        + citiesDistances(currentSolution(i), currentSolution(succJ)) ... 
        - citiesDistances(currentSolution(predI), currentSolution(i)) ...
        - citiesDistances(currentSolution(j), currentSolution(succJ));
elseif (succJ == i)
    energyDifference = ...
        citiesDistances(currentSolution(predJ), currentSolution(i)) ...
        + citiesDistances(currentSolution(j), currentSolution(succI)) ... 
        - citiesDistances(currentSolution(predJ), currentSolution(j)) ...
        - citiesDistances(currentSolution(i), currentSolution(succI));
else
    energyDifference = ...
        citiesDistances(currentSolution(predI), currentSolution(j)) ...
        + citiesDistances(currentSolution(j), currentSolution(succI)) ...
        + citiesDistances(currentSolution(predJ), currentSolution(i)) ...
        + citiesDistances(currentSolution(i), currentSolution(succJ)) ...
        - citiesDistances(currentSolution(predI), currentSolution(i)) ...
        - citiesDistances(currentSolution(i), currentSolution(succI)) ...
        - citiesDistances(currentSolution(predJ), currentSolution(j)) ...
        - citiesDistances(currentSolution(j), currentSolution(succJ));
end

% accept or reject new solution
if energyDifference > 0 % new solution is not better
    newSolution = currentSolution;
end

end

