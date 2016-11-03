function dependence = check_dep(A,B)
%CHECK_DEP This function checks for linear dependence relations
% Input variables:
% A, B -> two matrices
% Output variables: None

% Step 1: Error checks
if isempty(A)
    error('Matrix A is empty.');
end
if isempty(B)
    error('Matrix B is empty.');
end
if size(B,1) ~= size(A,1)
    error('Number of rows in both matrices must equal.')
end

% Step 2: Check to see if the columns of A span all of Rn
% Rank of a matrix has to equal Rn to span all of Rn

% Rank is the dimension that A spans
if rank(A) == size(A,1)
    fprintf('The span of the columns of A includes all vectors in R%.0f.\n',size(A,1));
end
% [~,piv] = rref(A);
% if length(piv) == size(A,1)
%     fprintf('Spans\n');
% end

% Step 3
% Omit the column that does not have a pivot (free variable)
for ii = 1:size(B,2)
    aug = [A B(:,ii)]; % set up augmented matrix
    [~,piv] = rref(aug);
    rowReduced = rref(aug);
    
    if piv(end) == size(aug,2) % if there's a pivot in the last column
        fprintf('b%.0f is not a linear combination of the columns of A.', ii);
    else
        fprintf('b%.0f =',ii);
        for jj = 1:length(piv)
            fprintf(' %.4f a%.0f ', rowReduced(jj, size(rowReduced,2)), jj);
            if jj ~= length(piv)
                fprintf('+');
            end
        end
    end
    fprintf('\n');
end

% Test 1
% A = [1 0 0;0 1 0;0 0 1], B = [2; 3; 4]
% The span of the columns of A includes all vectors in R3.
% b1 = 2.0000 a1 + 3.0000 a2 + 4.0000 a3 

% Test 2
% A= [1 0; 0 1; 0 0], B = [1 1; 2 2; 3 0]
% b1 is not a linear combination of the columns of A.
% b2 = 1.0000 a1 + 2.0000 a2 

% Test 3
% A= [1 1 2 4 1; -2 -7 1 2 -2; 3 8 -4 -3 -2], B= A*ones(5,1)
% The span of the columns of A includes all vectors in R3.
% b1 = 2.0000 a1 + 1.0000 a2 + 3.0000 a3
% Test 3.1 - swapped first and last columns
% A= [1 1 2 4 1; -2 -7 1 2 -2; -2 8 -4 -3 3], B= A*ones(5,1)
% The span of the columns of A includes all vectors in R3.
% b1 = -1.0000 a1 + 2.0000 a2 + 4.0000 a3
% Test 3.2 - swapped 2nd and 3rd columns
% A= [1 2 1 4 1; -2 1 -7 2 -2; -2 -4 8 -3 3], B= A*ones(5,1)
% The span of the columns of A includes all vectors in R3.
% b1 = -1.0000 a1 + 4.0000 a2 + 2.0000 a3 

% Test 4
% A= rand(3,2), B= ones(3,1)
% b1 is not a linear combination of the columns of A.

% Test 5
% First column
% A= [1 -3 -2.5; 5 -2 -1; 5 0 -1], B= [1; 2; -2]
% The span of the columns of A includes all vectors in R3.
% b1 = 0.0000 a1 + -2.0000 a2 + 2.0000 a3
% Second column
% A= [1 -3 -2.5; 2 -2 -1; -2 0 -1], B= [1; 5; 5]
% b1 is not a linear combination of the columns of A.
% Third column
% A= [1 1 -2.5; 2 5 -1; -2 5 -1], B= [-3; -2; 0]
% The span of the columns of A includes all vectors in R3.
% b1 = -0.5000 a1 + 0.0000 a2 + 1.0000 a3
% Fourth column
% A= [1 1 -3; 2 5 -2; -2 5 0], B= [-2.5; -1; -1]
% The span of the columns of A includes all vectors in R3.
% b1 = 0.5000 a1 + 0.0000 a2 + 1.0000 a3 

% Test 6
% A = [4     0     0;
%      5     1     5;
%      0     3     5;
%      5     5     2;
%      3     5     4]
% First column
% A = [0     0;
%      1     5;
%      3     5;
%      5     2;
%      5     4], B = [4;5;0;5;3]
%b1 is not a linear combination of the columns of A.
% Second column
% A = [4     0;
%      5     5;
%      0     5;
%      5     2;
%      3     4], B = [0;1;3;5;5]
% b1 is not a linear combination of the columns of A.
% Third column
% A = [4     0;
%      5     1;
%      0     3;
%      5     5;
%      3     5], B = [0;5;5;2;4]
% b1 is not a linear combination of the columns of A.

