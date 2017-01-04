function [ distanceMatrix ] = computeDistanceMatrix( citiesCoordinate )
%COMPUTEDISTANCEMATRIX returns the distance between all the cities in a
%TSP instance
%   input: citiesCoordinate: 2xn matrix containing the coordinate of the
%   cities in R^2.
%
%   output: distanceMatrix: nxn matrix containing the distances between all
%   the cities.
%
%   details: The euclidean distance is used to compute the distance in R^2
%   between all the cities. 

n = size(citiesCoordinate, 2);

% initialize distanceMatrix as a nxn matrix containing zeros
distanceMatrix = zeros(n);

% the distance matrix is symetrical, hence we only need to compute the
% columns i+1 to n (cell [i,i] is always 0)
for i = 1:n
    for j = i+1:n
        distanceMatrix(i, j) = norm(citiesCoordinate(:,i) - citiesCoordinate(:, j)); 
        distanceMatrix(j, i) = distanceMatrix(i, j);
    end
    distanceMatrix(i,i) = 0;
end

end

