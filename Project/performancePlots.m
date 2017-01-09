% Script for the 3rd part of the report: performance plots

algorithms = {'improvement', 'SA'};
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
    [idx, ~] = listdlg('PromptString', 'Select a transition proba to test', ...
        'SelectionMode', 'single', 'ListString', transitionProbas);
    transitionProba = str2func(transitionProbas{idx});
    smallMoves = {'swap', 'translation', 'inversion', 'mixed'};
    [idx, ~] = listdlg('PromptString', 'Select an small move to test', ...
        'SelectionMode', 'single', 'ListString', smallMoves);
    smallMove = str2func(smallMoves{idx});  
    algo = @simulatedAnnealing;
else
    algo = str2func(algoName);
end

disp(['Running algorithm ', algoName, '...']);

distances = zeros(1,maxRun);
solutions = cell(1, maxRun);
CBDs = cell(1, maxRun);

for i = 1:maxRun
    if mod(i, 5) == 0
        disp(['Run ', num2str(i), ' / ', num2str(maxRun)]);
    end
    if (strcmp(algoName, 'improvement'))
        [sol, d, CBD] = algo(smallMove, @bestInsertion, citiesDistances);
        CBDs{i} = CBD;
    elseif (strcmp(algoName, 'SA'))
        [sol, d, CBDs, temperatures] = algo(transitionProba, smallMove, @bestInsertion, ...
            citiesDistances);
        break;
    else
        [sol, d] = algo(citiesDistances);
    end
    distances(i) = d;
    solutions{i} = sol;
end

% performance plots
if (strcmp(algoName, 'improvement'))
    mat = cell2mat(CBDs');
    figure;
    grid on;
    plot(1:size(mat,2),min(mat), 1:size(mat, 2), max(mat), ...
        1:size(mat, 2), mean(mat));
    title(['Performance plot ' algoName, ' heuristic with ', ...
        func2str(smallMove), 'moves']);
    xlabel('Number of moves');
    ylabel('Path length');
    legend('min','max','mean');
else
    algoName = [algoName, ' with ', func2str(transitionProba), ' criterion'];
    mat = CBDs';
    disp(length(temperatures));
    disp(length(min(mat)));
    figure;
    semilogx(temperatures, min(mat), temperatures, max(mat), ...
        temperatures, mean(mat));
    title(['Performance plot ' algoName, ' heuristic with ', ...
        func2str(smallMove), 'moves']);
    xlabel('Temperature');
    ylabel('Path length');
    legend('min', 'max', 'mean');
    set(gca, 'xdir', 'reverse');
    grid on;
end