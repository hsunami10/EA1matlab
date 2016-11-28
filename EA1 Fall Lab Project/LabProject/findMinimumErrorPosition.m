function minPos = findMinimumErrorPosition(imgVec, imageDatabase)

vec = [];
for ii = 1:size(imageDatabase,2)
   MSE = calcMSE(imgVec, imageDatabase(:,ii));
   vec = [vec MSE];
end
[~, index] = ismember(min(vec), vec);
minPos = index;