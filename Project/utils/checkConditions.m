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
% We use the following property from graph theory: G has a cycle if and
% only if 0.5*trace(L) >= rank(L) + 1, where L is the Laplacian matrix,
% which is obtained by replacing the (i,i) entry of -A (the adjacency
% matrix) with the sum of the entries of row i of A (degree of node i)
if(nodeDegree(nextEdge.ends(1)) == 1 && nodeDegree(nextEdge.ends(2)) == 1)
    % add nextEdge to incidence matrix
    adjacencyMatrix(nextEdge.ends(1), nextEdge.ends(2)) = 1;
    adjacencyMatrix(nextEdge.ends(2), nextEdge.ends(1)) = 1;
    
    laplacianMatrix = -adjacencyMatrix;
    for i = 1:n
        laplacianMatrix(i,i) = nodeDegree(i);
    end
    
    if 0.5 * trace(laplacianMatrix) >= rank(laplacianMatrix) + 1
        edgeIsValid = false;
        return;
    end
end

edgeIsValid = true;

end

