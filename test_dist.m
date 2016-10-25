% This script file tests the distance function

x1 = input('Enter in the 1st x value: ');
y1 = input('Enter in the 1st y value: ');
x2 = input('Enter in the 2nd x value: ');
y2 = input('Enter in the 2nd y value: ');

result = dist2(x1,y1,x2,y2);
fprintf('The distance between the points is %1.2f\n', result);