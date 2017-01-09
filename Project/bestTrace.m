% Script for the 2nd part of the report: best trace

algorithms = {'bestInsertion', 'shortestEdge', 'improvement', 'SA'};
[idx, ~] = listdlg('PromptString', 'Select an algorithm to test', ...
    'SelectionMode', 'single', 'ListString', algorithms);

% function handle for the algorithm to use
algoName = algorithms{idx};
if (strcmp(algoName, 'improvement'))
    smallMoves = {'swap', 'translation', 'inversion', 'mixed'};
    [idx, ~] = listdlg('PromptString', 'Select an small move to test', ...
        'SelectionMode', 'single', 'ListString', smallMoves);
    smallMove = str2func(smallMoves{idx});
    algo = @greedyLocalSearch;
elseif (strcmp(algoName, 'SA'))
    transitionProbas = {'metropolis', 'heatBath'};
    [idx, ~] = listdlg('PromptString', 'Select an small move to test', ...
        'SelectionMode', 'single', 'ListString', transitionProbas);
    transitionProba = str2func(transitionProbas{idx});
    algo = @simulatedAnnealing;
else
    algo = str2func(algoName);
end


disp(['Running algorithm ', algoName, '...']);

distances = zeros(1,maxRun);
solutions = cell(1, maxRun);

for i = 1:maxRun
    if mod(i, 5) == 0
        disp(['Run ', num2str(i), ' / ', num2str(maxRun)]);
    end
    if (strcmp(algoName, 'improvement'))
        [sol, d] = algo(smallMove, @bestInsertion, citiesDistances);
    elseif (strcmp(algoName, 'SA'))
        [sol, d] = algo(transitionProba, @mixed, @bestInsertion, ...
            citiesDistances);
    else
        [sol, d] = algo(citiesDistances);
    end
    distances(i) = d;
    solutions{i} = sol;
end

% min and idx of min
[minLoss, idx] = min(distances);

plot(citiesCoordinate(1, solutions{idx}), citiesCoordinate(2, solutions{idx}));
if (strcmp(algoName, 'improvement'))
    title(['Solution path, greedy local search with ', ...
        func2str(smallMove), ' moves']);
elseif (strcmp(algoName, 'SA'))
    title(['Solution path, SA with ', func2str(transitionProba), ...
        ' condition and mixed moves']);
else
    title(['Solution path: ', algoName]);
end