function [ edgeIsValid ] = checkConditions( nextEdge, nodeDegree, ...
    adjacencyMatrix)
%CHECKCONDITIONS verifies if we can add an edge for the shortest edge
%heuristic.
%   input:  nextEdge: edge to be added
%           nodeDegree: degrees of each node in the graph
%           incidenceMatrix: nxn incidence matrix
%
%   output: edgeIsValid: boolean value, true if we can add edge, false
%   otherwise.

n = size(adjacencyMatrix, 1);

% check degrees
if(nodeDegree(nextEdge.ends(1)) == 2 || nodeDegree(nextEdge.ends(2)) == 2)
    edgeIsValid = false;
    return;
end

% check cycles
% We use the following property from graph theory: if A is an adjacency
% matrix for the graph, A^n(i,j) gives the number of paths of length n from
% i to j. So if for some k < n and some i, A^k(i, i) ~= 0, then there exist
% a cycle of length smaller than n.
% The first condition is to check if we can have a cycle
if(nodeDegree(nextEdge.ends(1)) == 1 && nodeDegree(nextEdge.ends(2)) == 1)
    % add nextEdge to incidence matrix
    adjacencyMatrix(nextEdge.ends(1), nextEdge.ends(2)) = 1;
    adjacencyMatrix(nextEdge.ends(2), nextEdge.ends(1)) = 1;
    Ai = adjacencyMatrix;
    for i = 2:n-1
        Ai = Ai * adjacencyMatrix;
        if(trace(Ai) ~= 0)  % then the path has a cycle
            edgeIsValid = false;
            return;
        end
    end
end

edgeIsValid = true;

end

