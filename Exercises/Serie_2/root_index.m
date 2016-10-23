function root_i = root_index( v )
%ROOT_INDEX returns one of the three roots to which the Newton-Raphson
%methods converges for g:R^2 -> R^2. The method returns i if the 
%sequence converges to z_i where i in {1,2,3}
% Input:
%   v: starting vector in R^2
% Output:
%   root_i: integer in {1,2,3}
    
%% Preparing what we need for the algorithm
function x = g( v )
%G is the function defined in the Ex 1 
%returns the evaluation of g at v 
x = [v(1)^3 - 3*v(1)*v(2)^2 - 1 ; 3 * v(1)^2 * v(2) - v(2)^3];
end

function x = jacobian( v )
%JACOBIAN defines the jacobian of the previously defined function g
%Returns the jacobian of G at v
x = [3*v(1)^2 - 3*v(2)^2, -6*v(1)*v(2) ; 6*v(1)*v(2), 3*v(1)^2 - 3*v(2)^2]; 
end

% Roots
z1 = [1;0];
z2 = [-0.5; sqrt(3)/2];
z3 = [-0.5; -sqrt(3)/2];

function root_i = return_closest( root )
%RETURN_CLOSEST return 1, 2 or 3 according to which of z1, z2, z3 the parameter
%root is closest.
norms = [norm(z1-root), norm(z2-root), norm(z3-root)];
min_root = min(norms);
[~, root_i] = ismember(min_root, norms);
end


%% Newton-Raphson method adapted for vector function
M = 1000; % max number of iteration
epsilon = 0.01; % number for which we consider the sequence to converge
d = {v}; % iteration vector
k = 0; % iteration counter

stop_iteration = false;

if norm( g( d{k+1} ) ) <= epsilon || k >= M
    root_i = return_closest(d{k+1});
    stop_iteration = true;
end


while ~stop_iteration
    inverse_jacobian_d = jacobian(d{k+1})^(-1);

    d{k+2} = d{k+1} - inverse_jacobian_d * g(d{k+1});
    
    stop_iteration = ( ( norm( d{k+2} - d{k+1} ) / norm( d{k+1} ) ) < epsilon );
    if ~stop_iteration
        k = k + 1;
    else
        root_i = return_closest(d{k+2});
    end
        
end


end