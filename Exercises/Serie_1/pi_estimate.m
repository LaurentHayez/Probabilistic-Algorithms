function pi = pi_estimate( N )
%PI_ESTIMATE generates random points in [0,1] x [0,1] and it is used to 
%approximate PI by using the fact that the probability that a point is 
%in the quarter circle is PI/4.
% Input:
%   N: an integer > 0 that represents the number of times the estimate 
%      must be repeated
% Output:
%   pi: an estimate of PI.

count_in = 0; % nb of pts randomly generated in the quarter disk C

for i=1:N
    rand_point = rand(1,2);
    if norm(rand_point) <= 1 % (x,y) is in C if its 2-norm is <= 1
        count_in = count_in + 1;
    end
end

pi = 4 * count_in / N;
end

% For other points of exercise 1, use the following commands:
% estimate_n = arrayfun(@pi_estimate, repmat(100, 1, n)); (creates a 1xn matrix with an estimate of pi
% using 100 approx)
% min(estimate_n), max(estimate_n), mean(estimate_n), std(estimate_n) to fill the array

%% Correction
% matlab way: without for
% X = rand(1,n);
% Y = rand(1, n);
% R = X.^2 + Y.^2;
% inside = (R <= 1);
% count_in = sum(inside);