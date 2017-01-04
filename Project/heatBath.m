function [ proba ] = heatBath( energyDifference, temperature )
%HEATBATH implements the metropolis criterion for accepting a new state
%in the simulated annealing algorithm.
%   Input:  - energyDifference: difference of path length between the
%               current state and the new state
%           - temperature: current temperature in SA algorithm
%
%   Output: - proba: probability to accept the new state

proba = 1 / (1 + exp(energyDifference / temperature));

end

