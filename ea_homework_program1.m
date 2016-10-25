% Homework Program 1
%
% Name: Hsu, Michael
% Section: 30
% Date: 9/23/2016

% step 1: create the hyperlink matrix H 6x6
H = [0 0 1/2 0 1/3 0;
     0 0 0 0 1/3 0;
    0 1/2 0 1/2 0 1/3;
     0 0 0 0 1/3 1/3;
    0 1/2 0 0 0 1/3;
    1 0 1/2 1/2 0 0]

% step 2: create the vector d of damping factors 1x5
 d = [0.5:0.1:0.9];
 
 % step 3: create the 6-by-5 PageRank matrix
 % Identity matrix and one matrix based off of hyperlink matrix's size
 PageRank = zeros(6,5);
 I = eye(size(H));
 N=size(H,1);
 one = ones(N,1);
 
 % Each "column" goes six rows down
 r1 = (I-d(1)*H)\((1-d(1))*one);
 r2 = (I-d(2)*H)\((1-d(2))*one);
 r3 = (I-d(3)*H)\((1-d(3))*one);
 r4 = (I-d(4)*H)\((1-d(4))*one);
 r5 = (I-d(5)*H)\((1-d(5))*one);
 
 % Assign all values of a column to the corresponding r
 PageRank(:,1) = r1
 PageRank(:,2) = r2
 PageRank(:,3) = r3
 PageRank(:,4) = r4
 PageRank(:,5) = r5
 
 % step 4: plot the results
 plot(d,PageRank,'o-')
 
 % Label, legend, title
 xlabel('d (dampening factor)')
 ylabel('PageRank rating')
 
 legend('show')
 legend('page1', 'page2', 'page3', 'page4', 'page5', 'page6')
 
 title('Changing d sometimes changes the rank order')
 