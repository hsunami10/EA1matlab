% H, N, d already defined
b = (1-d)*ones(N,1);
tol = 1e-4; % tolerance for convergence - smaller to be more accurate

x = ones(N,1); % initial guess
xnew = b + d*H*x; % first update

% Keep updating x until the difference between the two is less than 1e-4
% norm(x-xnew,inf) -> infinity norm -> max(abs(x-xnew)) -> max value of
% distance between vectors
while norm(x-xnew,inf) > tol
    x = xnew;
    xnew = b + d*H*x;
end