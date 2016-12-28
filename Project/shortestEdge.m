function [ solution, distance ] = shortestEdge( citiesDistances )
%SHORTESTEDGE Solves TSP with shortest edge heuristic
%   input: citiesDistances: nxn matrix containing the distances between all
%   the cities.
%
%   output: solution: solution path for the TSP problem
%           distance: length of path
%
%   detail: for this problem, the simplest approach is to create a
%   structure containing the edges between the different vertices, sort
%   them, and then create an incidence matrix while adding edges to the
%   path
% See also CHECKCONDITIONS, INCMAT2PERM, L.

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

[sortedEdges, permutationMatrix] = sort([edges(:).len]);

%TODO: create incidence matrix from added edge and create function that
%checks the conditions to add the edges.

adjacencyMatrix = zeros(n);
% degree of each node in the graph
nodeDegree = zeros(1, n);
% next edge in the sorted list of edges
nextEdgeCntr = 1;

for i=1:n
    % select next shortest edge
    edgeIsValid = false;
    while(~edgeIsValid)
        if(nextEdge > length(sortedEdges))
            disp('No more valid edges.');
            break;
        end
        nextEdge = edges(nextEdgeCntr);
        edgeIsValid = checkConditions(nextEdge, nodeDegree, ...
            adjacencyMatrix);
        nextEdgeCntr = nextEdgeCntr + 1;
    end
    
    nodeDegree(nextEdge.ends) = nodeDegree(nextEdge.ends) + 1;
    
    adjacencyMatrix(nextEdge.ends(1), nextEdge.ends(2)) = 1;
    adjacencyMatrix(nextEdge.ends(2), nextEdge.ends(1)) = 1;
end

solution = incMat2Perm(adjacencyMatrix);
distance = L(solution, citiesDistances);

end

