function [ solution, distance, CBD ] = greedyLocalSearch( smallMove, ...
    constrHeur, citiesDistances )
%GREEDYLOCALSEARCH implements the generic greedy local search algorithm
%   input:  - smallMove: small move to be used (swap, translation, ...)
%           - constrHeur: construction heuristic to use for the first
%               solution of the TSP
%           - citiesDistances: distances between the cities
%
%   output: - solution: solution to the TSP problem (best one among all
%               solution tested)
%           - distance: distance of the path corresponding to the solution
%               of the TSP problem.
%           - CBD: cumulative best distance (best distance after k moves,
%               for k = 1, ..., nbMoves). Used for performance plots
%

n = size(citiesDistances, 1);

nbMoves = 10 * n^2;

[solution, distance] = constrHeur(citiesDistances);

CBD = zeros(1, nbMoves);

for i = 1:nbMoves
    [newConfig, energyDifference] = smallMove(solution, citiesDistances);
    if (energyDifference < 0)
        solution = newConfig;
        distance = L(solution, citiesDistances);
    end
    CBD(i) = distance;
end

end

