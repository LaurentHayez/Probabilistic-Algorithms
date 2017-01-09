function [ solution, distance, PPD, temperatures ] = simulatedAnnealing(transitionProba, ...
    smallMove, constrHeur, citiesDistances)
%SIMULATEDANNEALING implements the simulated annealing algorithm
%   input:  - transitionProba: transition probability for SA algo. 
%               type: string, values allowed: 'metropolis', 'heatBath'.
%           - smallMove: small move to be used (swap, translation, ...)
%           - constrHeur: construction heuristic to use for the first
%               solution of the TSP
%           - citiesDistances: distances between the cities
%
%   output: - solution: solution to the TSP problem
%           - distance: distance of the path corresponding to the solution
%               of the TSP problem.
%           - PPD: lengths of paths at each temperature (for perf plot)
%           - temperatures: temperatures used
%

maxMoves = 1000;

% initial configuration with construction heuristic
[solution, ~] = constrHeur(citiesDistances);

% generate initialTemperature
[T, solution] = initialTemperature(solution, smallMove, citiesDistances);

distance = L(solution, citiesDistances);

stop = false;

% keep tracks of paths lengths
distances = [];

% for performance plots
PPD = [];
temperatures = [];
j = 1;

while (~stop)
    
    PPD(j, :) = zeros(1, maxMoves);
    temperatures(j) = T;
    
    for i = 1:maxMoves
        % Step 1: generate new configuration (ed stands for energy
        % difference
        [newConfig, ed] = smallMove(solution, citiesDistances);
        
        % Step 2: accept/reject transition according to transition proba
        proba = transitionProba(ed, T);
        delta = rand;
        
        PPD(j,i) = distance + ed;

        if (delta < proba) 
            % Step 3: check equilibrium
            % (Removed for performance plots to have consistent dimensions)
%             equilibrium = ((transitionProba(ed, T) / ...
%                 transitionProba(-ed, T)) == exp(-ed/T));
            % accept new configuration
            solution = newConfig;
            distance = distance + ed;
 
%             if equilibrium
%                 break;
%             end
        end
                
    end
    
    % check stop (if the 50 last path lengths are really close)
    stop = ((length(distances) > 50) && ...
        abs(std(distances(end-50:end))) < 0.001);
    
    distances = [distances distance];
    
    T = 0.95 * T;   
    j = j + 1;   
end

end
