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
%   - The user enters only the same type of variables (ie only X or only y, etc.)
%   - The variables are entered in ascending order
%   - the constraint is the only number on the right hand side, i.e.
%     x1 + x2 > x3 - 3 is not valid, but x1 + x2 - x3 > -3 is.
%
% Note: This exercise was done with regular expressions. I chose to use
%       regexp just to challenge myself. With a bit more work, some of 
%       the above conditions could be relaxed. But the code is already
%       long and obscure due to the use of regexp, so I chose to have
%       stronger assumptions and a simpler code.

    
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
s = regexprep(s, '^[a-zA-Z]\w*|(?<=(+|-))([a-zA-Z]\w*)', '1$0');

% regex to get the variables
var = regexp(s, '[a-zA-Z]\w*', 'match');
% get last variable
last_var = var{length(var)};
% get last variable index
last_var_index = str2num(cell2mat(regexp(last_var, '(?<=[a-zA-Z]+)[0-9]*', 'match')));
%last_var_index = str2num(last_var_index);
% get variable name
var_name = cell2mat(regexp(last_var, '[a-zA-Z]+(?=[0-9]*)', 'match'));

% regex to get the coefficients corresponding to the variables
c = regexp(s, '(-?[0-9]+)(?=[a-zA-Z]+\w*)', 'match');
% Getting the last coefficients corresponding to the constraint
last_const = regexp(s, '(?<=[<>=]+)-?[0-9]+', 'match');
c = [c last_const];
% c is a cell with string inside => convert to numbers
c = cellfun(@str2num, c);

% add coefficient 0 to missing variables
new_coeffs = [];
for i=1:last_var_index
    [tf, idx] = ismember([var_name num2str(i)], var);
    if tf
        new_coeffs = [new_coeffs c(idx)];
    else
        new_coeffs = [new_coeffs 0];
    end
end

assert(length(c) == length(var) + 1, ['The number of coefficients is not equal to the number of variables. ' ...
                    'Something went wrong.']);
% Adding the constraint to the list of coefficients
new_coeffs = [new_coeffs c(length(c))];

c = new_coeffs;
n = length(c) - 1;

%% Examples to test:
% expression = '4X1 - 5X2 + X3 < 12'; [n c] = parse( expression )
% expression = 'X1 - 7X3 + 2X5 > 3'; [n c] = parse( expression )
% expression = '-5y1 + 2y4 -3*y6 < 9'; [n c] = parse( expression )
% expression = '- 1050 myAwesomeVariable1 + 1291myAwesomeVariable4 + 12*myAwesomeVariable7 > 25'; [n c] = parse( expression )
