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
nb_iterations = 0;
max_iterations = 5000;
epsilon = 0.001;


%Initialization of p+1 points in D (the domain here is R^p)
%As random numbers are generated in (0,1), but we want them in R, we will simply generate them in a "big"
%interval (-a, b), where a = b = c/2.
%The p+1 points will be the p+1 columns of the array generated with
%arrayfun
c = 2000;
points = arrayfun(@(x) rand(1,p) * c - c/2, 1:p+1, 'UniformOutput', false);

while(true)
    nb_iterations = nb_iterations + 1;
    
    x = cellfun(L, points);
    
    %% Step 1: Reflection
    % sort x
    [~, indexes] = sort(x);
    % get max point, min point, and second max point
    %max = I(end); d_max = cell2mat(x(max));
    max_idx = indexes(end);
    min_idx = indexes(1);
    max2_idx = indexes(end-1);
    d_max = cell2mat(points(max_idx));
    d_min = cell2mat(points(min_idx));
    d_2max = cell2mat(points(max2_idx));
    % get centroid (mean) of all points except d_max 
    d_cent = mean( cell2mat( points( indexes ~= max_idx )' ) );
    % generate candidate vertex d_refl by reflecting d_max trough d_cent
    d_refl = (1 + alpha) * d_cent - alpha * d_max;

    % Compute L(d_min), L(d_max), L(d_max2), L(cent) and L(d_refl)
    Lmin = L(d_min); Lmax = L(d_max);
    Lmax2 = L(d_2max); Lrefl = L(d_refl);
    
    %% Step 5: stop condition (convergence criterion or max iterations)
    % Step 5 needs to be here because of the continue operation if the if
    % below
    if (nb_iterations > max_iterations || Lmax - Lmin < epsilon)
        if nb_iterations > max_iterations
            disp('too many operations')
        else
            disp('Reached convergence')
        end
        break;
    end

    %% Step 1a: Accept reflection
    if (Lmin <= Lrefl) && (Lrefl <= Lmax2)
        points(max_idx) = {d_refl};
        continue;
    end
    
    %% Step 2: Expansion
    if Lrefl < Lmin
        d_exp = gamma * d_refl + (1 - gamma) * d_cent;
        %% Step 2a : check expansion
        if L(d_exp) < Lrefl
            points(max_idx) = {d_exp};
        else
            points(max_idx) = {d_refl};
        end
        continue;
    end
    
    %% Step 3 and 3a: Contraction and check contraction
    % outside contraction
    if Lrefl < Lmax
        d_cont = beta * d_refl + (1 - beta) * d_cent;
        if L(d_cont) < Lrefl
            points(max_idx) = {d_cont};
        else
            points(max_idx) = {d_refl};
        end
    end
    % inside contraction
    if Lmax <= Lrefl
        d_cont = beta * d_max + (1 - beta) * d_cent;
        if L(d_cont) < Lmax
            points(max_idx) = {d_cont};
        else
            %% Step 4: Shrink
            points = cellfun(@(x) delta * x + (1 - delta) * d_min, points, 'UniformOutput', false);
        end
    end
    
end

solution = d_min;

end