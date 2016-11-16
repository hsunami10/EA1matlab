function [basis,coords] = find_coords(A)
% Given a matrix A, find a basis for the column space and write the
% coordinates of all the columns in terms of these basis vectors.

% Find sizes and pivots.
[m,n] = size(A);
[R,pivots] = rref(A);
p = length(pivots);

% *Preallocate a vector of zeros to contain the basis vectors for Col(A).*
basis = zeros(m,p);
for ii = 1:p
    % *Create a random vector of weights to make a linear combination of
    % the pivot columns of A.  Store this linear combination in the current
    % column of the basis matrix.*
    weights = rand([1 p]);
    linear_combo_matrix = [];
    for jj = 1:p
        linear_combo_matrix = [linear_combo_matrix (A(:, pivots(jj)) * weights(jj))];
    end
    basis(:,ii) = sum(linear_combo_matrix, 2);
end

% *Preallocate a vector of zeros to contain the coordinates of the columns
% of A in terms of the new basis.*
coords = zeros(size(A));
for ii = 1:n
    % *Fill in the coords matrix with the coordinates for the columns of
    % A.*
    [x,piv] = rref([basis A(:,ii)]);
    coords(:,ii) = x(:,end);
end
% Check for rows of zeros and delete them
if length(piv) < size(x,1)
    diff = size(x,1) - length(piv);
    for a = 1:diff
        coords(end,:) = [];
    end
end
%%% PLOTTING COMMANDS (DO NOT CHANGE).
if m == 2
    figure;
    plot(0,0,'b*','LineWidth',4,'MarkerSize',12)
    hold on;
    axis equal
    all_vecs = [A basis];
    max_dim = max(max(abs(all_vecs)));
    xlim([-max_dim max_dim])
    ylim([-max_dim max_dim])
    xlabel('x1','FontSize',14)
    ylabel('x2','FontSize',14)
    title('Coordinates','FontSize',16)

    for ii = 1:p
        quiver(0,0,basis(1,ii),basis(2,ii),1.0,'LineWidth',5,'MaxHeadSize',.5,'Color',[1 0 0]);
        text(basis(1,ii),basis(2,ii),sprintf('b%d',ii),'FontSize',20);
    end
    
    for ii = 1:n
        quiver(0,0,A(1,ii),A(2,ii),1.0,'LineWidth',5,'MaxHeadSize',.5,'Color',[0 1 0]);
        if p == 2
            text(A(1,ii),A(2,ii),sprintf('(%.2f,%.2f)',coords(1,ii),coords(2,ii)),'FontSize',14);
        elseif p == 1
            text(A(1,ii),A(2,ii),sprintf('(%.2f)',coords(1,ii)),'FontSize',14);
        end
    end
end

if m == 3
    figure; hold on;
    view([-37.5,30]);
    scatter3(0,0,0,'b*','LineWidth',3);
    axis equal
    all_vecs = [A basis];
    max_dim = max(max(abs(all_vecs)));
    xlim([-max_dim max_dim])
    ylim([-max_dim max_dim])
    zlim([-max_dim max_dim])
    xlabel('x1','FontSize',14)
    ylabel('x2','FontSize',14)
    zlabel('x3','FontSize',14)
    title('Coordinates','FontSize',16)
    
    for ii = 1:p
        quiver3(0,0,0,basis(1,ii),basis(2,ii),basis(3,ii),1.0,'LineWidth',3,'MaxHeadSize',.5,'Color',[1 0 0]);
        text(basis(1,ii),basis(2,ii),basis(3,ii),sprintf('b%d',ii),'FontSize',20);
    end
    
    for ii = 1:n
        quiver3(0,0,0,A(1,ii),A(2,ii),A(3,ii),1.0,'LineWidth',5,'MaxHeadSize',.5,'Color',[0 1 0]);
        if p == 3
            text(A(1,ii),A(2,ii),A(3,ii),sprintf('(%.2f,%.2f,%.2f)',coords(1,ii),coords(2,ii),coords(3,ii)),'FontSize',14);
        elseif p == 2
            text(A(1,ii),A(2,ii),A(3,ii),sprintf('(%.2f,%.2f)',coords(1,ii),coords(2,ii)),'FontSize',14);
        elseif p == 1
            text(A(1,ii),A(2,ii),A(3,ii),sprintf('(%.2f)',coords(1,ii)),'FontSize',14);
        end
    end
end


%%%
%%% Test Cases
%%%
% 1) A = randi([-10 10],2,6); Dimension - 2
% A
% 
% A =
% 
%      7     1    -4     5     1    -9
%      2     9     5    -3    -9     1
% 
% basis
% 
% basis =
% 
%     6.3882    1.4782
%     9.9644    5.3792
% 
% coords
% 
% coords =
% 
%     1.7672   -0.4036   -1.4723    1.5957    0.9515   -2.5410
%    -2.9018    2.4207    3.6568   -3.5136   -3.4357    4.8929

% 2) A = randi([-10 10],3,6); Dimension - 3
% A
% 
% A =
% 
%     -1    -7     1    -5     5    -6
%    -10     6    -7     3    -1     9
%     -3    -4     2     4    -9    -7
% 
% basis
% 
% basis =
% 
%    -3.5981   -3.0703   -0.2194
%   -12.0011    1.1277  -15.0155
%    -2.6386   -1.7919   -1.3544
% 
% coords
% 
% coords =
% 
%    -2.8952   -0.3551    3.5960   12.5503  -22.0452   -7.4493
%     3.4870    2.6899   -4.3445  -12.2822   22.8200   10.2465
%     3.2419    0.0862   -2.7342  -11.1530   19.4000    6.1240

% 3) A = [-2 -2;1 3;0 4]; Dimension - 2
% A
% 
% A =
% 
%     -2    -2
%      1     3
%      0     4
% 
% basis
% 
% basis =
% 
%    -3.3720   -0.9684
%     3.4234    1.2838
%     3.4748    1.5991
% 
% coords
% 
% coords =
% 
%     1.5777   -0.3332
%    -3.4282    3.2254
%          0         0

% 4) A = [-1 3 -1 -6 -1 1;3 -9 4 21 2 -5;2 -6 4 18 0 -6]; Dimension - 2
% A
% 
% A =
% 
%     -1     3    -1    -6    -1     1
%      3    -9     4    21     2    -5
%      2    -6     4    18     0    -6
% 
% basis
% 
% basis =
% 
%    -0.1433   -1.5183
%     0.5270    5.2497
%     0.4809    4.4262
% 
% coords
% 
% coords =
% 
%   -14.5050   43.5150   17.1902    8.0557  -46.2002  -48.8854
%     2.0277   -6.0831   -0.9639    3.1915    5.0192    3.9554

% 5) A = [1 -1 3 2;2 -2 6 4]; Dimension - 1
% A
% 
% A =
% 
%      1    -1     3     2
%      2    -2     6     4
% 
% basis
% 
% basis =
% 
%     0.3171
%     0.6342
% 
% coords
% 
% coords =
% 
%     3.1536   -3.1536    9.4608    6.3072

% 6) A = [8 1 7;8 6 2;4 8 -4;6 10 -4;1 2 -1]; Dimension - 2
% A
% 
% A =
% 
%      8     1     7
%      8     6     2
%      4     8    -4
%      6    10    -4
%      1     2    -1
% 
% basis
% 
% basis =
% 
%     4.5163    1.4519
%     5.2095    2.7394
%     3.2979    2.6572
%     4.6695    3.4708
%     0.8245    0.6643
% 
% coords
% 
% coords =
% 
%     2.1420   -1.2419    3.3839
%    -1.1531    4.5519   -5.7050

% We expect, mathematically, that basis*coords = A. 
% However, if you try the command A - (basis*coords)
% in MATLAB, you may not get all zeros. Why is this?

% Answer: MATLAB rounds off numbers, so basis*coords may not be EXACTLY the
% same as A. Since basis*coords have decimal values, we cannot assume that 
% they are COMPLETELY equal to their corresponding integer values.