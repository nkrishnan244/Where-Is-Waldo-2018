close all;
len = 11;
a = 5; b = 0;
imagesc(gaborFilter2D(3, -50, [a b; b a], len));
colormap(gray);

figure
imagesc(gaborFilter2D(5, 90, [5 0; 0 5], len));
colormap(gray);