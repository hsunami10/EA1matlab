% SUM UP ELEMENTS IN AN ARRAY - Fibonnaci


% For loop: prefer index in for argument
a = -4:3:25;
sum_a = 0;
for ii = 1:length(a)
    sum_a = sum_a + a(ii);
end

% If statement
% b = [1 4 3 6 7 98 4 7];
% sum_b = zeros(1, length(b));
% sum_b(1) = b(1);
% for ii = 1:length(b)
%     
%     if ii == 1
%         sum_b(ii) = b(ii)
%     else
%         sum_b(ii) = sum_b(ii-1) + b(ii)
%     end
% end

% More efficient way to program
% b = [1 4 3 6 7 98 4 7];
% sum_b = zeros(1, length(b));
% sum_b(1) = b(1);
% for ii = 2:length(b)
%     sum_b(ii) = sum_b(ii-1) + b(ii);
% end

% Nested for loops
c = [1 5 2 7 58 2];
sum_c = zeros(1, length(c));

% This for loop runs through sum_c values
for ii = 1:length(c)
    % This for loops runs through c values
    for jj = 1:ii
        sum_c(ii) = sum_c(ii) + c(jj);
    end
end

