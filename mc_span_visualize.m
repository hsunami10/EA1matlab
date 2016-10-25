function mc_span_visualize(A)

% Store the number of rows of "A" in a variable "m", and the number of 
% columns in the variable "n".
m = size(A,1);
n = size(A,2);

if m < 2 || m > 3
    % Create an error message telling the user that the vectors must be 2
    % or 3 dimensional.
    error('The vector must be 2 or 3 dimensional.');
end

figure; hold on;
xlim([-2 2]);ylim([-2 2]);zlim([-2 2])
if m == 3
    view([-37.5,30]);
    scatter3(0,0,0,'go','LineWidth',3);
else
    plot(0,0,'go','LineWidth',3);
end
axis square
xlabel('x1');ylabel('x2');zlabel('x3')

for ii = 1:n
    if m == 3
        quiver3(0,0,0,A(1,ii),A(2,ii),A(3,ii),1.0,'LineWidth',3,'MaxHeadSize',.5,'Color',[1 0 0]);
    else
        quiver(0,0,A(1,ii),A(2,ii),1.0,'LineWidth',3,'MaxHeadSize',.5,'Color',[1 0 0]);
    end
end
legend('Origin','Vectors')

num_points = 200;
% Initialize a matrix "points" of zeros with "m" rows and "num_points" columns.
points = zeros(m,num_points);
ii = 1;
while ii<=num_points
    % Create a variable "r" that is a column vector of random numbers between
    % -50 and 50, with "n" entries.
    r = rand(n,1)*100 - 50;
    if abs(A*r) < 2*ones(m,1)
        % In the ii'th column of "points", store the linear combination of the
        % columns of "A" weighted by the values in "r".
        points(:,ii) = A * r;
        
        if m == 3
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
%   A = [1 3 2;0 0 0;-1 -2 -3]'; mc_span_visualize(A); plane
%   A = [-2 2 4;-2 2 5;1 -1 -1]; mc_span_visualize(A); plane
%   A = rand(3,3); mc_span_visualize(A); R3
%   A = rand(3,2); mc_span_visualize(A); plane
%   A = rand(3,1); mc_span_visualize(A); line
%   r = rand(3,2); A = [r 2*r(:,1)]; mc_span_visualize(A); plane
%
%   2D:
%   A = [1 -2 -1;-2 4 -1]; mc_span_visualize(A); R2
%   A = [1 -2 .5;-2 4 -1]; mc_span_visualize(A); line
%   A = rand(2,2); mc_span_visualize(A); R2
%   A = rand(2,1); mc_span_visualize(A); line
%   A = rand(2,5); mc_span_visualize(A); R2