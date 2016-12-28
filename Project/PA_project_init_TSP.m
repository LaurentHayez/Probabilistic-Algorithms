% Author: Laurent Hayez
% Date: 27.12.2016
% File: initialization of TSP problems

clear all;
addpath(genpath('./'));

disp('Initializing TSP problem...');

% generate the distance matrix for the TSP problem
cities = 'TSP_411.txt';

file = fopen(cities, 'r');

disp('Reading file...')

coordinate = fscanf(file, '%f', [3, Inf]);

fclose(file);

citiesCoordinate = coordinate(2:3, :);

disp('Computing distances between cities...');

citiesDistances = computeDistanceMatrix(citiesCoordinate);

% number of times to run the algorithms
maxRun = 1;

disp('End of initialization');
