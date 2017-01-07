function y = f(a)

% This function returns the value of the line search function for a given
% value of function variable.

% y = 2 - 4*a + exp(a); % Example 10.3 in the book (Arora)

% y = (11*a - 5)^2 + 16*a^2; % Homework 3 / Section B - a

% y = 0.1*(5 - a)^2 + (1 - 2*a)^2; % Homework 3 / Section B - b

y = 16*a^2 - 8*a + 1;


end