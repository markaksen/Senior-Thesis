N = 10;
maxL_vec = linspace(1,maximum_l(N),maximum_l(N));
L2err = zeros(1,length(maxL_vec));
[x y z]=ndgrid(-N:N);
data=(x.^2+(1.5*y).^2+z.^2)<N^2; %ellipsoid
data = double(data);
L2_data = norm(data(:));
for k=1:length(maxL_vec)
    maxL = maxL_vec(k);
    [recovered_data,~,~] = recover_data(data, maxL);
    diff = recovered_data-data;
    L2err(k) = norm(diff(:));
    L2err(k) = L2err(k)/L2_data;
end
%p = polyfit(maxL_vec,L2err_2, 3);
%f = polyval(p,maxL_vec);
plot(maxL_vec, L2err); 
%hold on; plot(maxL_vec, f)
title('L2 Error of Reconstruction vs Maximum Degree');
xlabel('Maximum degree(l)');
ylabel('L2 error of reconstruction');