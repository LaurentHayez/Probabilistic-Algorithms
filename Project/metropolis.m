function [ proba ] = metropolis( energyDifference, temperature )
%METROPOLIS implements the metropolis criterion for accepting a new state
%in the simulated annealing algorithm.
%   Input:  - energyDifference: difference of path length between the
%               current state and the new state
%           - temperature: current temperature in SA algorithm
%
%   Output: - proba: probability to accept the new state

if (energyDifference > 0)
    proba = exp(- energyDifference / temperature);
else
    proba = 1;
end

end

