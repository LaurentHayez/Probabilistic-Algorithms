function [ solution ] = incMat2Perm( adjacencyMatrix )
%ADJMAT2PERM transform an adjacency matrix to a permutation
%   input:  adjacencyMatrix: nxn adjacency matrix of the graph
%
%   output: solution: permutation of the nodes containing the solution to
%   the TSP problem

n = size(adjacencyMatrix, 1);

solution = zeros(1, n);
solution(1) = 1;
neighbours = find(adjacencyMatrix(solution(1), :) == 1);
solution(2) = neighbours(1);

for i = 2:n-1
    % find neigbours
    neighbours = find(adjacencyMatrix(solution(i), :) == 1);
    disp(neighbours)
    if length(neighbours) > 2
        fprintf('Error, something is wrong with the adjacency matrix!');
        return;
    end
    if neighbours(1) == solution(i-1)
        solution(i+1) = neighbours(2);
    else
        solution(i+1) = neighbours(1);
    end  
end

end

