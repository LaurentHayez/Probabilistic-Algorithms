function [ distance ] = L( solution, citiesDistances )
%L returns the total length of the solution path
%   input:  solution: solution path to the TSP problem
%           citiesDistances: nxn matrix containing the distances between 
%           all the cities.
%           
%   output: distance: length of solution path for the TSP problem

n = size(citiesDistances, 1);
distance = sum(arrayfun(@(i) citiesDistances(solution(i), ...
    solution(mod(i,n)+1)), 1:n)); 

end

