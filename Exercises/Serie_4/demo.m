% clear all;

% d = dim(theta) (should be even)
d = 2;  

% Define function to be minimized.
B = diag(ones(d,1)*0.5)+0.5;
L = @(x) (sum(x(1:round(length(x)/2)).^4) + x*B*x');

theta = nelder_mead(L, d)