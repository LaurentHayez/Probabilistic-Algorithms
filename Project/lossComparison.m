% Script for the first part of the report: comparison of loss values

algorithms = {'bestInsertion', 'shortestEdge'};
[idx, ~] = listdlg('PromptString', 'Select an algorithm to test', ...
    'SelectionMode', 'single', 'ListString', algorithms);

% function handle for the algorithm to use
algoName = algorithms{idx};
algo = str2func(algoName);

disp(['Running algorithm ', algoName, '...']);

distances = zeros(1,maxRun);
solutions = cell(1, maxRun);

for i = 1:maxRun
    if mod(i, 5) == 0
        disp(['Run ', num2str(i), ' / ', num2str(maxRun)]);
    end
    [sol, d] = algo(citiesDistances);
    distances(i) = d;
    solutions{i} = sol;
end

% min, max and mean
[minLoss, idx] = min(distances);
maxLoss = max(distances);
meanLoss = mean(distances);

% 95% confidence interval computed according to slides given in class
alpha1 = tinv((1 - 0.95) / 2, maxRun - 1); % inverse of Student distribution with 29 dof
alpha2 = tinv((1 + 0.95) / 2, maxRun - 1);
sigma = std(distances);
S1 = meanLoss - alpha2 * sigma / sqrt(maxRun);
S2 = meanLoss - alpha1 * sigma / sqrt(maxRun);


disp(['Showing statistics for ', algoName,' algorithm:']);
disp(['min = ', num2str(minLoss), ', max = ', num2str(maxLoss), ...
    ', mean = ', num2str(meanLoss), ', confidence interval: [', ...
    num2str(S1), ', ', num2str(S2), ']']);

% plot(citiesCoordinate(1, solutions{idx}), citiesCoordinate(2, solutions{idx}));
% title(['Solution path: ', algoName]);