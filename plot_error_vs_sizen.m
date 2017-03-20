dim = linspace(5,20,16);
L2err = zeros(1, length(dim));
L2data = zeros(1,length(dim));
sz_ALM = zeros(1,length(dim));
for k=1:length(dim)
    k
    [x y z]=ndgrid(-dim(k):dim(k));
    data=(x.^2+(1.5*y).^2+z.^2)<(dim(k))^2; %ellipsoid
    data = real(data);
    L2data(k) = norm(data(:));
    data = double(data);
%     str = strcat('ellipsoid_',sz,'.mrc');
%      WriteMRC(data,1,str);
    maxL = maximum_l(dim(k));
    [recovered_data,ALM,ALM_tilde] = recover_data(data,maxL);
      sz = num2str(dim(k));
%      str = strcat('ellipsoid_eigvaluedecomp_',sz,'.mrc');
%      WriteMRC(recovered_data,1,str);
    diff = recovered_data - data;
    L2err(k) = norm(diff(:));
    L2err(k) = L2err(k)/L2data(k);
    for j = 1:length(ALM)
        sz_ALM(k) = sz_ALM(k)+numel(ALM(j));
    end
    sz_ALM(k) = sz_ALM(k)/((2*dim(k)+1)^3);
end
plot(dim, L2err)
xlabel('Size of data(n)');
ylabel('L2 Error');

plot(dim, sz_ALM)
xlabel('Size of data(n)');
ylabel('Fraction of Recovered Data');
