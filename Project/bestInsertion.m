function [ solution, distance ] = bestInsertion( citiesDistances )
%BESTINSERTION Solves TSP with best insertion heuristic
%   input: citiesDistances: nxn matrix containing the distances between all
%   the cities.
%
%   output: solution: solution path for the TSP problem
%           distance: length of path
%
%   detail: solved with the permutations representation

n = size(citiesDistances, 1);

permutation = randperm(n);

% initial nodes
solution = permutation(1:3);

for c = 3:n-1
    nodeToInsert = permutation(c+1);
    
    % path increase between two successive nodes i and i+1
    pathIncrease = arrayfun(@(x) citiesDistances(permutation(x), ...
        nodeToInsert) + citiesDistances(nodeToInsert, permutation(x+1)) ...
        - citiesDistances(permutation(x), permutation(x+1)), 1:c-1);
    % path increase if x = c
    pathIncrease = [pathIncrease, citiesDistances(permutation(c), ...
        nodeToInsert) + citiesDistances(nodeToInsert, permutation(1)) ...
        - citiesDistances(permutation(c), permutation(1))];
    
    % retrieve minimum of path increase
    [~, idx] = min(pathIncrease);
    
    % add min to solution
    solution = [solution(1:idx), nodeToInsert, solution(idx+1:end)];
end

distance = sum(arrayfun(@(i) citiesDistances(permutation(i), ...
    permutation(mod(i,n)+1)), 1:n)); 

end

