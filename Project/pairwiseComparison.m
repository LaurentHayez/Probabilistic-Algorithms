% Script for the 4th part of the report: pairwise comparison of algorithms

% pairwise comparison to test
bestInsVSshortestEdge = true;
metropolisVSheatBath = true;

%% 1. best insertion vs shortest edge
if (bestInsVSshortestEdge)
    disp('Running pairwise comparison for best insertion and shortest edge');
    distsBI = zeros(1,maxRun);
    distsSE = zeros(1, maxRun);
    for i = 1:maxRun
        if mod(i, 5) == 0
            disp(['Run ', num2str(i), ' / ', num2str(maxRun)]);
        end
        [~, dBI] = bestInsertion(citiesDistances);
        distsBI(i) = dBI;
        [~, dSE] = shortestEdge(citiesDistances);
        distsSE(i) = dSE;
    end
    % computing means
    meanBI = mean(distsBI);
    meanSE = mean(distsSE);
    % computing standard deviations
    stdBI = std(distsBI);
    stdSE = std(distsSE);
    % computing T
    usefulComputation = (stdBI^2 / maxRun) + (stdSE^2 / maxRun);
    T = (meanBI - meanSE) / sqrt(usefulComputation);
    % computing m
    m = (usefulComputation^2 / ((((stdBI^2 / maxRun)^2) / (maxRun + 1))  + ...
        (((stdSE^2 / maxRun)^2) / (maxRun + 1)))) - 2;
    % computing beta
    beta = tinv(0.5/2, m) * sqrt(usefulComputation);
    % Summary
    disp(['Mean BI: ', num2str(meanBI), ', mean SE: ', num2str(meanSE), ...
        'T: ', num2str(T), ', beta: ', num2str(beta)]);
end

%% 2. metropolis vs heat bath
if (metropolisVSheatBath)
    disp('Running pairwise comparison for metropolis and heat bath');
    distsM = zeros(1,maxRun);
    distsH = zeros(1, maxRun);
    for i = 1:maxRun
        if mod(i, 5) == 0
            disp(['Run ', num2str(i), ' / ', num2str(maxRun)]);
        end
        [~, dM] = simulatedAnnealing(@metropolis, @mixed, @bestInsertion, citiesDistances);
        distsM(i) = dM;
        [~, dH] = simulatedAnnealing(@heatBath, @mixed, @bestInsertion, citiesDistances);
        distsH(i) = dH;
    end
    % computing means
    meanM = mean(distsM);
    meanH = mean(distsH);
    % computing standard deviations
    stdM = std(distsM);
    stdH = std(distsH);
    % computing T
    usefulComputation = (stdM^2 / maxRun) + (stdH^2 / maxRun);
    T = (meanM - meanH) / sqrt(usefulComputation);
    % computing m
    m = (usefulComputation^2 / ((((stdM^2 / maxRun)^2) / (maxRun + 1))  + ...
        (((stdH^2 / maxRun)^2) / (maxRun + 1)))) - 2;
    % computing beta
    beta = tinv(0.5/2, m) * sqrt(usefulComputation);
    % Summary
    disp(['Mean M: ', num2str(meanM), ', mean H: ', num2str(meanH), ...
        'T: ', num2str(T), ', beta: ', num2str(beta)]);
end