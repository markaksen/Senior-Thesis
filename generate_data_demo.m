% file = 'C:/Mark/College/Senior Year/Senior Thesis/code/EMD-6454.map';
% [data] = ReadMRC(file);
N = 10;
[x y z]=ndgrid(-N:N);
data=(x.^2+(1.5*y).^2+z.^2)<N^2; %ellipsoid
data = (x.^2)/9 + (y.^2)/16 < 1% cylinder
data = double(data);
data = smooth3(data,'box');
L2_data = norm(data(:));
% data = ((x.^2)/64 + (y.^2)/256 + (z.^2)/100) < 1; %hyperboloid
%data = ((x.^2)/25 + (y.^2)/36 - z/2) < 1; % elliptic paraboloid
WriteMRC(data,1,'cylinder_smooth.mrc');
maxL = maximum_l(N);
[recovered_data,~,~] = recover_data(data,maxL);
%recovered_data_neg = min(real_recovered_v, 0);
WriteMRC(recovered_data,1,'cylinder_exactrecovery_smooth.mrc');
%L2error = norm(recovered_data_neg(:))/L2_data;

