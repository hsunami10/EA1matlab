function Vnew = transform_mesh(A,V,T,C)
%TRANSFORM_MESH This function transforms matrix V into Vnew
% Inputs: matrices A, V, T, C
% Matrix A is the transformation matrix
% Matrix V is the matrix being transformed
% Matrix T is the triangle matrix
% Matrix C is the color matrix
% Outputs: matrix Vnew is the new, transformed version of matrix V

% Homework Program 7
%
% Name: Michael Hsu
% Section: 30
% Date: 11/4/2016

% Step 4
if(ismatrix(A))
    if(size(A,1) ~= 3 && size(A,2) ~= 3)
        error('A has to be a 3x3 matrix.');
    end
elseif(~ismatrix(A))
    error('Make sure that A is a matrix');
elseif(isempty(A))
    error('A is empty.');
end

% Step 5
if(ismatrix(V))
    if(size(A,2) ~= 3)
        error('V has to have 3 columns.');
    end
elseif(~ismatrix(V))
    error('Make sure that V is a matrix');
elseif(isempty(V))
    error('V is empty.');
end

% Step 6
if(ismatrix(T))
    if(size(T,2) ~= 3)
        if(size(T,2) ~= 4)
            error('T has to have 3 or 4 columns.');
        end
    end
elseif(~ismatrix(T))
    error('Make sure that T is a matrix');
elseif(isempty(T))
    error('T is empty.');
end

% Step 7
if(~isempty(C))
    if(ismatrix(C))
        if(size(C,2) ~= 3)
            error('C has to have 3 columns.');
        end
    end
end

% Step 8 - Apply linear transformation A to each vertex in V
for ii = 1:size(V,1)
    Vnew(ii,:) = A * V(ii,:)';
end

% Step 9
% Plot the new and original meshes
if nargin < 4
% User did not provide specific colors
trisurf(T(: ,1:3) ,Vnew (: ,1),Vnew (: ,2),Vnew (: ,3));
hold on
trisurf(T(: ,1:3) ,V(: ,1),V(: ,2),V(: ,3), ...
'EdgeColor','none','FaceAlpha' ,0.2);
hold off
else
% User provided specific colors
trisurf(T(: ,1:3) ,Vnew (: ,1),Vnew (: ,2),Vnew (: ,3),T(: ,4));
hold on
trisurf(T(: ,1:3) ,V(: ,1),V(: ,2),V(: ,3),T(: ,4), ...
'EdgeColor','none','FaceAlpha' ,0.2);
hold off
colormap(C);
end

% A_scale = [0.5 0 0; 0 1.5 0; 0 0 1.5];
% A_refl = [1 0 0; 0 1 0; 0 0 -1];
% A_rot = vrrotvec2mat([1 1 0 pi/3]);
% A = eye([3 3]) * A_scale *  A_refl * A_rot;
% B = eye([3 3]) * A_rot * A_scale * A_refl;
% 
% A_scale
% 
% A_scale =
% 
%     0.5000         0         0
%          0    1.5000         0
%          0         0    1.5000
% 
% A_refl
% 
% A_refl =
% 
%      1     0     0
%      0     1     0
%      0     0    -1
% 
% A_rot
% 
% A_rot =
% 
%     0.7500    0.2500    0.6124
%     0.2500    0.7500   -0.6124
%    -0.6124    0.6124    0.5000
% 
% A
% 
% A =
% 
%     0.3750    0.1250    0.3062
%     0.3750    1.1250   -0.9186
%     0.9186   -0.9186   -0.7500
% 
% B
% 
% B =
% 
%     0.3750    0.3750   -0.9186
%     0.1250    1.1250    0.9186
%    -0.3062    0.9186   -0.7500