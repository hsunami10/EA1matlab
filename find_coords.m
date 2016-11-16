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
    x = rref([basis A(:,ii)]);
    coords(:,ii) = x(:,end);
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
% 1) A = randi([-10 10],2,6);
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

% 2) A = randi([-10 10],3,6);
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

% 3) A = [-2 -2;1 3;0 4];
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

% 4) A = [-1 3 -1 -6 -1 1;3 -9 4 21 2 -5;2 -6 4 18 0 -6];
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
%    -0.4456   -0.2816
%     1.6008    0.9809
%     1.4189    0.8354
% 
% coords
% 
% coords =
% 
%    -9.9684   29.9053   10.6622    2.0814  -30.5991  -31.2929
%    19.3263  -57.9789  -13.3222   18.0124   51.9748   45.9707
%          0         0         0         0         0         0

% 5) A = [1 -1 3 2;2 -2 6 4];
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
%     0.5797
%     1.1594
% 
% coords
% 
% coords =
% 
%     1.7250   -1.7250    5.1750    3.4500
%          0         0         0         0

% 6) A = [8 1 7;8 6 2;4 8 -4;6 10 -4;1 2 -1];
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
%     1.3000    8.0492
%     5.8135   10.5035
%     7.4203    7.7061
%     9.3251   10.5774
%     1.8551    1.9265
% 
% coords
% 
% coords =
% 
%    -0.5925    1.1404   -1.7328
%     1.0896   -0.0599    1.1495
%          0         0         0
%          0         0         0
%          0         0         0