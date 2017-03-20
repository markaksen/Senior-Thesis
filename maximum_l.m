function maxL = maximum_l(N)

fname='Besselj_L60_S180.mat';
load(fname);

B = B( B(:, 3)<pi*N, :);
l_grid = B(:, 1);
maxL = max(l_grid);
end