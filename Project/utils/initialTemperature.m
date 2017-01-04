function [ temperature, configuration ] = initialTemperature( ...
    initialConfiguration, smallMove, citiesDistances )
%INITIALTEMPERATURE computes the initial temperature for the SA algorithm
%   Input:  - initialConfiguration: initial permutation of the cities for
%               the TSP problem
%           - smallMove: small move to be used (function handle)
%           - citiesDistances: distances between the cities
%
%   Output: - temperature: initial temperature to be used
%           - configuration: permutation of the cities corresponding to the
%               initial temperature.
%
%   Details:    The initial temperature is computed using the ad-hoc
%               procedure, by performing a random walk and using
%               |Delta(L)|_max (the maximum difference of L occuring
%               between successive configuration).
%               

% number of iterations for the random walk
maxIter = 200;

maxDeltaL = 0;

configuration = initialConfiguration;

for i = 1:maxIter
    [newConfig, tmpDeltaL] = smallMove(configuration, citiesDistances);
    if (abs(tmpDeltaL) >= maxDeltaL)
        configuration = newConfig;
        maxDeltaL = abs(tmpDeltaL);
    end
%     if (tmpDeltaL < 0)
%         configuration = newConfig;
%         if (abs(tmpDeltaL) >= maxDeltaL)
%             maxDeltaL = abs(tmpDeltaL);
%         end
%     end
end

temperature = - maxDeltaL / log(0.9);

end

