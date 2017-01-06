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
% See also CHECKCONDITIONS, ADJMAT2PERM, L.

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

%disp([edges(:).len]);

[sortedLengths, permutationMatrix] = sort([edges(:).len]);

% sort edges to keep structure
edges = edges(permutationMatrix);

%disp([edges(:).len]);

adjacencyMatrix = zeros(n);
% degree of each node in the graph
nodeDegree = zeros(1, n);
% next edge in the sorted list of edges
nextEdgeCounter = 1;

% randomly permute the edges that have the same length
% for this, we consider each distance, find the indexes for which the edges
% have the same length, and randomly permute those indexes.
% (if we don't do this the algorithm is deterministic and always yields the
% same result)
uniqueLengths = unique(sortedLengths);
for i = 1:length(uniqueLengths)
    % find indexes where the edges have the same length
    idx = find(sortedLengths == uniqueLengths(i));
    % randomly permute them
    rp = randperm(length(idx));
    edges(idx) = edges(idx(rp));
end

for i=1:n
    % select next shortest edge
    edgeIsValid = false;
    while(~edgeIsValid)
        if(nextEdgeCounter > length(edges))
            disp('No more valid edges.');
            break;
        end
        nextEdge = edges(nextEdgeCounter);
        
        edgeIsValid = checkConditions(nextEdge, nodeDegree, ...
            adjacencyMatrix);
        nextEdgeCounter = nextEdgeCounter + 1;
    end
    
    nodeDegree(nextEdge.ends) = nodeDegree(nextEdge.ends) + 1;
    
    adjacencyMatrix(nextEdge.ends(1), nextEdge.ends(2)) = 1;
    adjacencyMatrix(nextEdge.ends(2), nextEdge.ends(1)) = 1;
end

solution = adjMat2Perm(adjacencyMatrix);
distance = L(solution, citiesDistances);

end

