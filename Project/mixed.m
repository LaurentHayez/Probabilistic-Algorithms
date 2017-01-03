function [ newSolution, energyDifference ] = mixed( currentSolution, ...
    citiesDistances )
%MIXED implements the "mixed" improvement heuristic
%it selects swap/translation/inversion move each with proba 1/3
%   input:  currentSolution: permutation of the cities, which is a current
%               solution to the TSP problem
%           citiesDistances: distances between cities
%
%   output: newSolution: better or equal solution to the TSP problem
%           energyDifference: difference between new solution distance and
%               old solution distance

proba = rand;

if (proba < 1/3) 
    [newSolution, energyDifference] = swap(currentSolution, citiesDistances);
elseif (proba < 2/3)
    [newSolution, energyDifference] = translation(currentSolution, citiesDistances);
else
    [newSolution, energyDifference] = inversion(currentSolution, citiesDistances);
end


end

