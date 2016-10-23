function [n c] = parse( s )
%PARSE returns the number of decision variables and the coefficients
%The function receives as input a string s corresponding to a linear 
%constraint and returns two outputs: the number of decision 
%variables n and the vector of corresponding coefficients c.
% Input:
%   s: string corresponding to a linear constraint
% Output:
%   n: number of decision variables
%   c: coefficients of the linear constraint
% Assumptions:
%   - The user does not enter expression such as 3X1 + 6X1, but directly
%     9X1.
%   - x1 and X1 are different variables
%   - the constraint is the only number on the right hand side, i.e.
%     x1 + x2 > x3 - 3 is not valid, but x1 + x2 - x3 > -3 is.

    
%% String preprocessing    
% Removing possible whitespaces at the beggining
i = 1;
while s(i) == ' '
    s = s(i+1:length(s));
    i = i + 1;
end
% Removing all remaining whitespaces and formatting properly
% (Transforming 3*x1 into 3x1)
Xs = [];
new_s = '';
for i = 1:length(s)
    if s(i) ~= ' ' && s(i) ~= '*'
        new_s = strcat(new_s, s(i));
    end
end
s = new_s;

%dynamic regex to replace all expresions such as x1 by 1x1
s = regexprep(s, '^[a-zA-Z]\w*|(?<=(\s[+-])*[^0-9\*])[a-zA-Z]\w*', '1$0');

% regex to get the variables
var = regexp(s, '[a-zA-Z]\w*', 'match');
n = length(var);

%% TODO: make regexp to get the different variables and then create the coefficients accorgingly

% regex to get the coefficients corresponding to the variables
c = regexp(s, '-?[0-9]+(?=[a-zA-Z]\w*)', 'match');
% Getting the last coefficients corresponding to the constraint
last_const = regexp(s, '(?<=[<>=]+)-?[0-9]+', 'match');
c = [c last_const];
% c is a cell with string inside => convert to numbers
c = cellfun(@str2num, c);
