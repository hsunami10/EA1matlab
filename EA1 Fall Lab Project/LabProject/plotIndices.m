function plotIndices(scrambledIndices, correctIndices)

axlen = length(correctIndices);
x = 0:axlen-1;
y1 = scrambledIndices(1:100);
y2 = correctIndices(1:100);

figure();
subplot(1,2,1);
axis square;
axis([0 axlen-1 0 axlen-1]);
title('Scrambled Indices');
xlabel('Player ID');
ylabel('Database Column');
plot(x,y1,'o');

subplot(1,2,2);
axis square;
axis([0 axlen-1 0 axlen-1]);
title('Scrambled Indices');
xlabel('Player ID');
ylabel('Database Column');
plot(x,y2,'o');