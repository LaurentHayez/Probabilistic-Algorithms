function [ solution, distance ] = shortestEdge( citiesDistances )
%SHORTEDEDGE Solves TSP with shortest edge heuristic
%   input: citiesDistances: nxn matrix containing the distances between all
%   the cities.
%
%   output: solution: solution path for the TSP problem
%           distance: length of path
%
%   detail: for this problem, the simplest approach is to create a
%   structure containing the edges between the different vertices, sort
%   them, and then create an adjacency matrix while adding edges to the
%   path

n = size(citiesDistances, 1);

% sort edges

edges = struct;
i = 1;
for row = 1:n-1
    for col = row+1:n
        edges(i).ends = [row col];
        edges(i).len = citiesDistances(row, col);
        i = i + 1;
    end
end

[edges_sorted, sort_permutation] = sort([edges(:).len]);
edges = edges_sorted;

%TODO: create adjacency matrix from added edge and create function that
%checks the conditions to add the edges.


end

