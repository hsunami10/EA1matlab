limits = [-2.0 0.5 -1.2 1.2];
nx = 1000;
ny = 1000;
max_esctime = 1000;

x = linspace(limits (1) ,limits (2) ,nx);
y = linspace(limits (4) ,limits (3) ,ny);

% Each row in X is a copy of x, each row in Y is a copy of y
% 2D coordinate system
[X,Y] = meshgrid(x,y);
C = X + 1i*Y;

% Step 4: Create a ny-by-nx array E containing the real escape times for each corresponding point
E = zeros(ny,nx);
Z = zeros(ny,nx);
k = 0;
done = false(ny,nx);

while (k < max_esctime && ~all(done(:)))
   Z = Z.*Z + C;
   k = k + 1;
   new = false(ny,nx);
   %if abs(Z) > 2 & done == false  % NEVER GOES THROUGH LOOP
       new = (abs(Z) > 2) & (done == false);
   %end
   E(new) = k - log(log2(abs(Z(new))));
   done = done + new;
end