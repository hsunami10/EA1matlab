% Homework Program 2
%
% Name: Hsu, Michael
% Section: 30
% Date: 9/30/2016

% User input - Step 1-3
r = input('Input a value for r: ');
u = input('Input a value for u ');
n = input('Input a value for n: ');

% Step 4: Create a random matrix
A = randi(u,n,r);

% Step 5: Compare numbers chosen by other people to your number
B = A(:,2:end);%a
C = repmat(A(:,1),1,size(B,2));%b
D = (B == C);%c
E = sum(D,2);%d

% Step 6:  return the number of times each value in the second argument 
% (0:r-1) appears in the first argument (E), along with the possible values
% of the repetitions
[tally,reps] = hist(E,0:r-1);

% Step 7: Probability
probs = tally/n;

% Step 8: Plot results
bar(reps,probs);
title(sprintf('%u People, Numbers Between 1 and %u, %u Trials',r,u,n));
xlabel('Number of people');
ylabel('Probability');

% Step 9: Create a results matrix
results(:,1) = reps;
results(:,2) = probs;

% r = 20, u = 10, n = 10^4
   % 0    0.1365
   % 1.0000    0.2743
   % 2.0000    0.2912
   % 3.0000    0.1782
   % 4.0000    0.0833
   % 5.0000    0.0275
   % 6.0000    0.0072
   % 7.0000    0.0017
   % 8.0000    0.0001
   % 9.0000         0
   %10.0000         0
   %11.0000         0
   %12.0000         0
   %13.0000         0
   %14.0000         0
   %15.0000         0
   %16.0000         0
   %17.0000         0
   %18.0000         0
   %19.0000         0

   % r = 10, u = 6, n = 10^6
%     0    0.1935
%     1.0000    0.3489
%     2.0000    0.2792
%     3.0000    0.1301
%     4.0000    0.0393
%     5.0000    0.0077
%     6.0000    0.0011
%     7.0000    0.0001
%     8.0000    0.0000
%     9.0000    0.0000