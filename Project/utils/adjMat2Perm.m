function [ solution ] = incMat2Perm( adjacencyMatrix )
%ADJMAT2PERM transform an adjacency matrix to a permutation
%   input:  adjacencyMatrix: nxn adjacency matrix of the graph
%
%   output: solution: permutation of the nodes containing the solution to
%   the TSP problem

n = size(adjacencyMatrix, 1);

solution = zeros(1, n);
solution(1) = 1;

for i = 1:n-1
    % find neigbours
    neigbours = find(adjacencyMatrix(solution(i), :) == 1);
    if length(neigbours) > 2
        fprintf('Error, something is wrong with the adjacency matrix!');
        return;
    end
    if neigbours(1) == i
        solution(i+1) = neighbours(2);
    else
        solution(i+1) = neighbours(1);
    end  
end

end

