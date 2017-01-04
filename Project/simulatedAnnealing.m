function [ solution, distance ] = simulatedAnnealing(citiesDistances, ...
    transitionProba)
%SIMULATEDANNEALING implements the simulated annealing algorithm
%   input:  - citiesDistances: distances between cities
%           - transitionProba: transition probability for SA algo. 
%               type: string, values allowed: 'metropolis', 'heatBath'.
%           - 
%
%   output: - solution: solution to the TSP problem
%           - distance: distance of the path corresponding to the solution
%               of the TSP problem.
%

n = size(citiesDistances, 1);

maxMoves = 1000;

initialTemperature = 



end

