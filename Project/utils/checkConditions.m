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
if (nodeDegree(nextEdge.ends(1)) == 2 || nodeDegree(nextEdge.ends(2)) == 2)
    edgeIsValid = false;
    return;
end

% check cycles
% We use the following property from graph theory: G has a cycle if and
% only if 0.5*trace(L) >= rank(L) + 1, where L is the Laplacian matrix,
% which is obtained by replacing the (i,i) entry of -A (the adjacency
% matrix) with the sum of the entries of row i of A (degree of node i)
% $$$ if (nodeDegree(nextEdge.ends(1)) == 1 && nodeDegree(nextEdge.ends(2)) == 1)
% $$$     % add nextEdge to incidence matrix
% $$$     adjacencyMatrix(nextEdge.ends(1), nextEdge.ends(2)) = 1;
% $$$     adjacencyMatrix(nextEdge.ends(2), nextEdge.ends(1)) = 1;
% $$$     
% $$$     laplacianMatrix = -adjacencyMatrix;
% $$$     for i = 1:n
% $$$         laplacianMatrix(i,i) = nodeDegree(i);
% $$$     end
% $$$     
% $$$     if (trace(laplacianMatrix) >= 2 * (rank(laplacianMatrix) + 1))
% $$$         edgeIsValid = false;
% $$$         return;
% $$$     end
% $$$ end
% Does not work

% Other approach: create path from vertex 1 to other neighbours and 
% check if there is a cycle

if (nodeDegree(nextEdge.ends(1)) == 1 && nodeDegree(nextEdge.ends(2)) == 1)
    % Add edge in adjacency matrix
    adjacencyMatrix(nextEdge.ends(1), nextEdge.ends(2)) = 1;
    adjacencyMatrix(nextEdge.ends(2), nextEdge.ends(1)) = 1;
    % Check if cycle was created 
    path = [];
    path(1) = nextEdge.ends(1);
    for i = 1:sum(nodeDegree) / 2
        neighbor = find(adjacencyMatrix(path(i), :));
        if (length(neighbor) < 2) % cannot have a cycle
            break;
        elseif (~ismember(neighbor(1), path)) 
            path(i+1) = neighbor(1);
        elseif (~ismember(neighbor(2), path))
            path(i+1) = neighbor(2);
        else % else there is a cycle in the path => edge is not valid
            edgeIsValid = false;
            return;
        end    
    end
end

edgeIsValid = true;

end

