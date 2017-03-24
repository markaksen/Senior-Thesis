dim = linspace(5,20,16);
L2err = zeros(1, length(dim));
sz_ALM = zeros(1,length(dim));
jball_size_vec = zeros(1,length(dim));
for k=1:length(dim)
    k
    [x y z]=ndgrid(-dim(k):dim(k));
    %data=((x).^2+(1.5*(y)).^2+(z).^2)<(dim(k))^2; %ellipsoid
    %data=((x-2).^2+(1.5*(y+3)).^2+(z-1).^2)<(dim(k))^2; %ellipsoid
    %data=((x-1).^2+(1.5*(y+1)).^2+(z+1).^2)<(dim(k))^2; %ellipsoid
    %data=((x).^2+(y).^2+(z).^2)<(dim(k))^2; % sphere
    data = (4.25*dim(k)^2 - (x.^2 + (1.5*y).^2+z.^2))/(4.25*(dim(k))^2);
    %data = (x.^2)/9 + (y.^2)/16 < 1; %cylinder
    data = double(data);
    
    %sz = num2str(dim(k));
    %str = strcat('ellipsoid_smooth',sz,'.mrc');
    %WriteMRC(data,1,str);
    
    maxL = maximum_l(dim(k));
    [recovered_data,~,~,jball_size] = recover_data(data,maxL);
    jball_size_vec(k) = jball_size;
    
    %str = strcat('ellipsoid_smooth_exact',sz,'.mrc');
    %WriteMRC(recovered_data,1,str);
    
    diff = recovered_data - data;
    L2err(k) = norm(diff(:))/norm(data(:));
    for j = 1:length(ALM)
        sz_ALM(k) = sz_ALM(k)+numel(ALM{j});
    end
    sz_ALM(k) = sz_ALM(k)/((2*dim(k)+1)^3);
end
plot(dim, L2err)
xlabel('Size of data(n)');
ylabel('L2 Error');
axis([5 20 0 0.8]);

plot(dim, sz_ALM)
xlabel('Size of data(n)');
ylabel('Fraction of Recovered Data');
axis([5 20 0 0.3]);

plot(dim, jball_size_vec)
xlabel('Size of data(n)');
ylabel('Size of Ball');