function x = simplex( c, A, b )
%SIMPLEX returns the optimal solution d*

% Get m and n (dimensions)
m = size(b, 1);
n = size(c, 2);

% initialize permutation
sigma = [1:m+n];

% Slack variables to have equality in the constraints
d = [zeros(1,n) b']';

% suppose theta is 0 initially
theta = 0;

% counter
k = 0;

% stop conditions
d_is_optimal = false;
no_finite_solution = false;

% Debugging stuff
debug = false;

while xor(~d_is_optimal,no_finite_solution)
    
    % check if optimal solution
    if all(c >= 0) > 0
        if debug
            disp([int2str(k) 'th run: end of the algorithm'])
            disp('A = ')
            disp(A)
            disp('b = ')
            disp(b)
            disp('c = ')
            disp(c)
            disp('theta = ')
            disp(theta)
        end
        x = [zeros(1, n) b'];
        x = x(sigma);
        d_is_optimal = true;
        break;
    end
    
    % Index of the column where c_s is min
    % Gives us the pivot column
    [~, pivot_col_s] = ismember(min(c), c);
    
    if debug
        disp([int2str(k) 'th run'])
        disp(['Pivot col s = ' num2str(pivot_col_s)])
    end
    
    
    % check if there is no finite solution
    if all(A(:, pivot_col_s) <= 0) > 0
        if debug
            disp(['column ' int2str(pivot_col_s) ' of A: ' mat2str(find(A(:, pivot_col_s) <= 0))])
        end
        x = 'No optimal solution was found!';
        no_finite_solution = true;
        break;
    end
    
    % Compute b_i / a_i,s but only for a_i,s > 0
    div_col = b ./ A(:, pivot_col_s);
    [~, pivot_row_r] = ismember(min(div_col(find(A(:, pivot_col_s) > 0), :)), div_col);
    
    if debug
        disp(['Pivot row r = ' num2str(pivot_row_r)])
        disp('A = ')
        disp(A)
        disp('b = ')
        disp(b)
        disp('c = ')
        disp(c)
        disp('b_i/a_is = ')
        disp(div_col)
        disp('theta = ')
        disp(theta)
    end
    % Refresh simplex tableau
    A_new = A;
    b_new = b;
    c_new = c;
    for i=1:m
        for j = 1:n
            % Update A
            if i ~= pivot_row_r && j ~= pivot_col_s
                A_new(i,j) = A(i,j) - ( A(i, pivot_col_s) * A(pivot_row_r, j) / A(pivot_row_r, pivot_col_s) );
            elseif i == pivot_row_r && j == pivot_col_s
                A_new(i,j) = 1 / A(pivot_row_r, pivot_col_s);
            elseif i ~= pivot_row_r && j == pivot_col_s
                A_new(i,j) = - A(i, pivot_col_s) / A(pivot_row_r, pivot_col_s) ;
            else
                A_new(i,j) = A(pivot_row_r, j) / A(pivot_row_r, pivot_col_s);
            end
        end
        % Update b
        if i ~= pivot_row_r
            b_new(i) = b(i) - ( b(pivot_row_r) * A(i, pivot_col_s) / A(pivot_row_r, pivot_col_s) ) ;
        else
            b_new(i) = b(pivot_row_r) / A(pivot_row_r, pivot_col_s) ;
        end
    end

    
    % Update c
    for i=1:n
        if i ~= pivot_col_s
            c_new(i) = c(i) - ( c(pivot_col_s) * A(pivot_row_r, i) / A(pivot_row_r, pivot_col_s) ) ;
        else
            c_new(i) = - c(pivot_col_s) / A(pivot_row_r, pivot_col_s) ;
        end
    end
    
    % Update theta
    theta = theta + ( c(pivot_col_s) * b(pivot_row_r) / A(pivot_row_r, pivot_col_s) ) ;
    
    A = A_new;
    b = b_new;
    c = c_new;
    
    % interchange d_sigma(s) with d_sigma(n+r)
    tmp = sigma(pivot_col_s);
    sigma(pivot_col_s) = sigma(n + pivot_row_r);
    sigma(n + pivot_row_r) = tmp;
    k = k+1;
    if debug
        disp('==========================================')
    end
end

end