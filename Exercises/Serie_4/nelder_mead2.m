function [ w ] = nelder_mead2( L, d )
%Computes the paramters w which minimize L using the non-linear simplex
%method. 
%   Takes a function handle for the function L to be minimised and returns
%   a parameter vector w of dimension d corresponding to the found minimum.

% Set initial parameters
alpha = 1;
beta = 0.5;
gamma = 2;
delta = 0.5;
maxItr = 10000; itr = 0; epsilon = 0.005;

% Calculate d+1 initial points
b = 1000; % coordinates of b will lie in [-b/2,b/2]
points = arrayfun(@(x)rand(1,d)*b-b/2,1:d+1, 'UniformOutput', false);

while(true)    
    % Find maximum, second highest and minimal point
    pVal = cellfun(L,points);
    [v,I] = sort(pVal);
    min = I(1);         wmin = cell2mat(points(min));
    max = I(end);       wmax = cell2mat(points(max)); 
    max2 = I(end-1);    wmax2 = cell2mat(points(max2));
    Lmin = L(wmin); Lmax = L(wmax); 
    
    % Check for termination
    itr = itr+1;    
    simplexSize = sum(std(cell2mat(points'))); % Measure for the size of the simplex
    dL = Lmax-Lmin; % Stop if this is very small
    if(itr>maxItr || simplexSize<epsilon*d || dL<epsilon)
        if itr>maxItr
            disp('too many iterations')
        elseif simplexSize<epsilon*d
            disp('Simplex size converged')
        else
            disp('dL < epsilon')
        end
        break;
    end

    % Compute the centroid
    wcentr = mean(cell2mat(points(I~=max)'));

    % reflect wmax though wcentr
    wrefl = (1+alpha)*wcentr - alpha*wmax;
    Lrefl = L(wrefl);
    
    if(Lmin<Lrefl && Lrefl<L(wmax2))
        % Accept reflection
        points(max) = {wrefl};
        continue;
    elseif(Lrefl<Lmin)
        % Expand reflection
        wexp = gamma*wrefl + (1-gamma)*wcentr;   
        if(L(wexp)<Lrefl)
            points(max) = {wexp};
        else
            points(max) = {wrefl};
        end
        continue;
    else
        % Contraction
        if(Lrefl<Lmax)
            % Outside conatraction
            wcont =  beta*wrefl + (1-beta)*wcentr; 
            if(L(wcont)<Lrefl)
                points(max) = {wcont};
            else
                points(max) = {wrefl};
            end
        else
            % Insde contraction
            wcont =  beta*wmax + (1-beta)*wcentr; 
            if(L(wcont)<Lmax)
                points(max) = {wcont};
            else
                % Shrink the simplex
                points = cellfun(@(x) delta*x+(1-delta)*wmin,points,...
                    'UniformOutput', false);
            end
        end
    end
end

w = wmin;

end