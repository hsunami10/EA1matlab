function [E, Image] = mandelbrot(limits, nx, ny, max_esctime);
%MANDELBROT This function calculates E and Image and helps prints a picture
% INPUTS:
% *limits - This is a 4-element vector specifying a rectangular region in the complex plane. It has the form
% [XMIN XMAX YMIN YMAX], where XMIN and XMAX are the minimum and maximum real parts and YMIN
% and YMAX are the minimum and maximum imaginary parts. For example, [-1 2 -2 3] specifies a
% rectangular region in the complex plane with ?1 ? 2i as the lower left corner and 2 + 3i as the upper
% right corner. This is similar to the input to the axis function. Default is [-2.0 0.5 -1.2 1.2]e.
% *nx - The number of points (pixels) in the x-direction. Default is 1000.
% *ny - The number of points (pixels) in the y-direction. Default is 1000.
% *max_esctime - The maximum number of iterations in the sequence allowed when calculating the escape
% times. This will be the maximum effective integer escape time. Default is 1000.
% OUTPUTS:
% *E - An ny-by-nx array containing the real escape times for each pixel.
% *Image - An array containing the color data for the image.

% Homework Program 4
%
% Name: Hsu, Michael
% Section: 30
% Date: 10/13/2016

% Step 2: Set 4 input values do their default value if it does not exist or
% is empty
if ~exist('limits','var') || isempty(limits)
    limits = [-2.0 0.5 -1.2 1.2];
end
if ~exist('nx','var') || isempty(nx)
    nx = 1000;
end
if ~exist('ny','var') || isempty(ny)
    ny = 1000;
end
if ~exist('max_esctime','var') || isempty(max_esctime)
    max_esctime = 1000;
end

% Step 3: Create C (nx by ny) that contains all of the c values in the desired rectangular region
% linspace(x1,x2,n) -> returns linear spaces n times between x1 and x2
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
   %new = false(ny,nx);
   %if abs(Z) > 2 & done == false
       new = abs(Z) > 2 & done == false;
   %end
   E(new) = k - log(log2(abs(Z(new))));
   done = done + new;
end

% plot result as a color image
%
Image = show_mandelbrot(E,limits);
return;