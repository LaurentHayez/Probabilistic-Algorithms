function [ newSolution, energyDifference ] = translation( currentSolution, ...
    citiesDistances )
%TRANSLATION implements the "translation" improvement heuristic
%   input:  currentSolution: permutation of the cities, which is a current
%               solution to the TSP problem
%           citiesDistances: distances between cities
%
%   output: newSolution: better or equal solution to the TSP problem
%           energyDifference: difference between new solution distance and
%               old solution distance

n = size(citiesDistances, 1);

% determine i and successor
i = randi(n);
if (1 <= i && i <= n-1); succI = i + 1; else succI = 1; end

% determine j ~= i and i+, and its predecessor and successor
j = randi(n);
while (i == j || succI == j)
    j = randi(n);
end
if (1 <= j && j <= n-1); succJ = j + 1; else succJ = 1; end
if (2 <= j && j <= n); predJ = j - 1; else predJ = n; end

% compute translation
newSolution = currentSolution;
if (succI < j)
    newSolution(succI) = currentSolution(j);
    newSolution(succI+1:j) = currentSolution(succI:predJ);
else
    newSolution(j) = currentSolution(succJ);
    newSolution(succJ:i-1) = currentSolution(succJ+1:i);
    newSolution(i) = currentSolution(j);
end

% compute energy difference 
if (succI == predJ)
    energyDifference = ...
        citiesDistances(currentSolution(i), currentSolution(j)) ...
        + citiesDistances(currentSolution(succI), currentSolution(succJ)) ... 
        - citiesDistances(currentSolution(i), currentSolution(succI)) ...
        - citiesDistances(currentSolution(j), currentSolution(succJ));
elseif (succJ == i)
    energyDifference = ...
        citiesDistances(currentSolution(predJ), currentSolution(i)) ...
        + citiesDistances(currentSolution(j), currentSolution(succI)) ... 
        - citiesDistances(currentSolution(predJ), currentSolution(j)) ...
        - citiesDistances(currentSolution(i), currentSolution(succI));
else
    energyDifference = ...
        citiesDistances(currentSolution(i), currentSolution(j)) ...
        + citiesDistances(currentSolution(j), currentSolution(succI)) ...
        + citiesDistances(currentSolution(predJ), currentSolution(succJ)) ...
        - citiesDistances(currentSolution(i), currentSolution(succI)) ...
        - citiesDistances(currentSolution(predJ), currentSolution(j)) ...
        - citiesDistances(currentSolution(j), currentSolution(succJ));
end

% accept or reject new solution
if energyDifference > 0 % new solution is not better
    newSolution = currentSolution;
    disp('New solution is not better -> rejecting');
end

end

