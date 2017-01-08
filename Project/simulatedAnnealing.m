function [ solution, distance ] = simulatedAnnealing(transitionProba, ...
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

while (~stop)
    
    for i = 1:maxMoves
        % Step 1: generate new configuration (ed stands for energy
        % difference
        [newConfig, ed] = smallMove(solution, citiesDistances);
        
        % Step 2: accept/reject transition according to transition proba
        proba = transitionProba(ed, T);
        delta = rand;
        if (delta < proba) 
            % Step 3: check equilibrium
            equilibrium = ((transitionProba(ed, T) / ...
                transitionProba(-ed, T)) == exp(-ed/T));
            % accept new configuration
            solution = newConfig;
            distance = L(solution, citiesDistances);
            if equilibrium
                break;
            end
        end
                
    end
    
    % check stop (if the 50 last path lengths are really close)
    stop = ((length(distances) > 50) && ...
        abs(std(distances(end-50:end))) < 0.00001);
    
    distances = [distances distance];
    
    T = 0.95 * T;
    
end

end
