% % Normal method 
% try
%     x = input('Enter integers: ');
% catch
%     fprintf('Enter in a vector');
% end
% 
% count = 0; for a = 1:length(x)
%     count = count + 1;
% end y = sum(x)/count; fprintf('This is the average of your %1.0f values %.1f \n', count, y);

% Using a function
function a = average(b);
count = 0;
for c = 1:length(b)
    count = count + 1;
end
y = sum(b)/count;
fprintf('This is the average of your %1.0f values: %.1f \n', count, y);
end
