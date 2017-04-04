N = 10;
maxL_vec = linspace(1,maximum_l(N),maximum_l(N));
L2err = zeros(1,length(maxL_vec));
FSCerr = zeros(floor(N/2),length(maxL_vec)); % fourier shell correlation
[x y z]=ndgrid(-N:N);
%data=(x.^2+(1.5*y).^2+z.^2)<N^2; %ellipsoid
data = (4.25*N^2 - (x.^2 + (1.5*y).^2+z.^2))/(4.25*(N)^2);
%data = double(data);
L2_data = norm(data(:));
r_cut = 1;
for k=1:length(maxL_vec)
    maxL = maxL_vec(k);
    [recovered_data,~,~,~,~] = recover_data(data, maxL,r_cut,1);
    diff = recovered_data-data;
    L2err(k) = norm(diff(:))/L2_data;
    FSCerr(:,k) = FSC_range(N, data, recovered_data);
end
plot(maxL_vec, L2err); 
title('L2 Error of Reconstruction vs Maximum Degree');
xlabel('Maximum degree(l)');
ylabel('L2 error of reconstruction');