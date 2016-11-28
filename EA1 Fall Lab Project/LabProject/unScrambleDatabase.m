function [newDatabase,indices] = unScrambleDatabase(imagePath,database)
% UNSCRAMBLEDATABASE reorders the columns of the image database so each
% column corresponds to the correct player name
% 1 -> PlayerName1
% 2 -> PlayerName2
% 3 -> PlayerName3
% ...

% Inputs: 
%          imagePath   : Folder under which the images have been saved
%          database    : Image database
% Outputs:
%          newDatabase : Reordered database
%          indices     : indices for reordering



indices = zeros(1,size(database,2));
newDatabase = zeros(size(database));
for ii = 1:100
   x = readImage(strcat(imagePath, strrep('player0.png', '0', num2str(ii))));
   minPos = findMinimumErrorPosition(x(:), database);
   indices(ii) = minPos;
end
for ii = 1:length(indices)
   newDatabase(:,ii) = database(:,indices(ii)); 
end
% You have to write this part of code for this function to run properly