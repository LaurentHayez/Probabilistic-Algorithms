function x = simplex_old( c, A, b )
%SIMPLEX returns the optimal solution d*

% Getting linearly independent columns of A
% source: http://math.stackexchange.com/questions/1179108/how-to-get-rid-of-linearly-dependent-columns-of-a-given-matrix-on-matlab
[~, col_ind] = rref(A);
B = A(:, col_ind);

% Getting linerarly dependent columns of A
col_dep = find(not(ismember([1:size(A,2)], col_ind)));
N = A(:, col_dep);

% Reshaping A
A = [B N];

n = size(A, 2) - size(A, 1);

% Selecting an extreme point of the simplex
d = [B^(-1)*b ; zeros(n, 1)]'

% splitting d into d_B and d_N
d_B = d(:, col_ind);
d_N = d(:, col_dep);

% counter
k = 0;

% optimality criterion
d_is_optimal = false;

while ~(d_is_optimal)
    if d_N' - d_B'*B^(-1)*N >= 0
        d_is_optimal = true;
        x = d
    elseif find(sum(A)<0)
        
    else
        
    end
end

end