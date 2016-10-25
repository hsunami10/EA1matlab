function distance = dist2(x1, y1, x2, y2);
%DIST2: this function calculates the distance between two points

% Nargin returns the actual number of input arguments
if nargin < 4
    error('Please enter 4 arguments');
end
% Output variable -> distance
distance = sqrt(((x2-x1).^2) + ((y2-y1).^2));
return
