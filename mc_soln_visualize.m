function mc_soln_visualize(A,b)

% Store the number of rows of "A" in a variable "m", and the number of 
% columns in the variable "n".
m = size(A,1);
n = size(A,2);

if n < 2 || n > 3
    error('Solution set must be 2 or 3 dimensional!');
end

if m == n
    A = [A;zeros(1,n)];
    b = [b;0];
end

[~,piv] = rref([A b]);
% Find particular solution, and store it in the vector "p".  If the system
% is inconsistent, display an error. Hint: use the variable "piv" from 
% above to help determine if the system is inconsistent.
if piv(end)==size([A b],2)
    error('The system is inconsistent.');
else
    p = pinv(A)*b;
end


% NOTHING TO CHANGE.
% This code finds the vectors defining parametric vector form, and stores
% them in "V".
V = null(A,'r');
num_vectors = size(V,2);

figure; hold on;
xlim([p(1)-2 p(1)+2]);ylim([p(2)-2 p(2)+2]);
if n == 4
    zlim([p(3)-2 p(3)+2])
end

if n == 3
    view([-37.5,30]);
    scatter3(0,0,0,'go','LineWidth',3);
    quiver3(0,0,0,p(1),p(2),p(3),1.0,'LineWidth',3,'MaxHeadSize',.5,'Color',[0 0 0]);
else
    plot(0,0,'go','LineWidth',3);
    quiver(0,0,p(1),p(2),1.0,'LineWidth',3,'MaxHeadSize',.5,'Color',[0 0 0]);
end
axis square
xlabel('x1');ylabel('x2');zlabel('x3')

for ii = 1:num_vectors
    if n == 3
        quiver3(p(1),p(2),p(3),V(1,ii),V(2,ii),V(3,ii),1.0,'LineWidth',3,'MaxHeadSize',.5,'Color',[1 0 0]);
    else
        quiver(p(1),p(2),V(1,ii),V(2,ii),1.0,'LineWidth',3,'MaxHeadSize',.5,'Color',[1 0 0]);
    end
end
legend('Origin','Particular solution','Spanning vectors')

num_points = 200;
% Initialize a matrix "points" of zeros with "n" rows and "num_points" columns.
points = zeros(n,num_points);

% Plot points.
ii = 1;
plot(points);
while ii<=num_points
    % Create a variable "r" that is a column vector of random numbers between
    % -50 and 50, with "num_vectors" entries.
    r = rand(num_vectors,1)*100 - 50;
    
    if abs(V*r) < 2*ones(n,1)
        % In the ii'th column of "points", store the linear combination of the
        % columns of "V" weighted by the values in "r", plus your particular solution "p".
        points(:,ii) = V * r + p;
        
        if n == 3
            scatter3(points(1,ii),points(2,ii),points(3,ii),'b*');
        else
            scatter(points(1,ii),points(2,ii),'b*');
        end
        pause(.01)
        % Increment the counter "ii" by 1.
        ii = ii + 1;
    end
end


% Test Cases:
%   3D:
%   A = [1 3 2;0 0 0;-1 -2 -3]'; b = [1;2;3]; mc_soln_visualize(A,b); line
%   A = [-2 2 4;-2 2 5;1 -1 -1]; b = [-6;-7;2]; mc_soln_visualize(A,b);line
%   r = rand(3,1); A = [r 2*r -r]; mc_soln_visualize(A,r); plane
%   A = rand(3,3); b = rand(3,1); mc_soln_visualize(A,b); zero vector
%   r = rand(3,2); A = [r 2*r(:,1)]; b = rand(3,1);mc_soln_visualize(A,b); line
%   r = rand(3,2); A = [r 2*r(:,1)]; b = A(:,1) - A(:,2);
%   mc_soln_visualize(A,b); line
%   c = [1 3 2]; A = [c;-2*c;3*c;6*c]; b = A(:,1)-A(:,2)-A(:,3);
%   mc_soln_visualize(A,b); plane
%
%   2D:
%   A = [1 -2;-2 4]; b = [1;2]; mc_soln_visualize(A,b); line
%   A = [1 -2;-2 4]; b = [3;-6]; mc_soln_visualize(A,b); line
%   A = rand(2,2); b = rand(2,1); mc_soln_visualize(A,b); zero vector
%   A = rand(1,2); b = rand(1,1); mc_soln_visualize(A,b); line
%   A = rand(5,2); b = rand(5,1); mc_soln_visualize(A,b); zero vector
%   r = rand(5,1); A = [r 2*r]; b = 3*r; mc_soln_visualize(A,b); line