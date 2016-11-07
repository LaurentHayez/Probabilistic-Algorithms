function [ solution ] = nelder_mead( L, p )
%NELDER_MEAD implements the Non-Linear simplex Algorithm
%Minimizes the function L using the non-linear simplex algorithm
% Input:
%   L: function to minimize (passed as a function handle)
%   p: dimension of the space
% Output:
%   solution: points where L is minimized
    
%% Step 0: initialization
%default parameters    
alpha = 1.0;
beta = 0.5;
gamma = 2.0;
delta = 0.5;
%Help variables
max_iterations = 1000;
epsilon = 0.0001;


%Initialization of p+1 points in D (the domain here is R^p)
%As random numbers are generated in (0,1), but we want them in R, we will simply generate them in a "big"
%interval (-a, b), where a = b = c/2.
%The p+1 points will be the p+1 rows of the matrix rand(p+1, p)
c = 5000;
points = rand(p+1, p).*c - (c / 2);

x = L(points)







end