N = 10;
[x y z]=ndgrid(-N:N);
data=(x.^2+(1.5*y).^2+z.^2)<N^2; %ellipsoid
%data = (x.^2)/9 + (y.^2)/16 < 1 %cylinder
%data = ((x.^2)/64 + (y.^2)/256 + (z.^2)/100) < 1; %hyperboloid
data = double(data);
%data = smooth3(data,'box');
L2_data = norm(data(:));
maxL = maximum_l(N);
[ALM, C, N, r_cut, jball, jjorigin,Y, dems_Y, dels_Y, r_select_ratio] = spherical_harm_coeff(data, maxL);

x = linspace(0,20,21);
size_vec = (2.^x)/2^15;
size_vec(1) = 0;
L2_neg_avg = zeros(1,length(size_vec));
L2err_avg = zeros(1,length(size_vec));
for i=1:100
    L2err = zeros(1, length(size_vec));
    L2_neg = zeros(1,length(size_vec));
    for k=1:length(size_vec)
        if k == 1
            ALM_tilde = ALM;
        else
            for ii=0:maxL
                A = expm(random_skew_symmetric(2*ii+1));
            O = size_vec(k)*A/norm(A);
            O = O+eye(2*ii+1);
            ALM_tilde{ii+1} = ALM{ii+1}*O;
            end
        end
        recovered_data = recover_from_ALM_v4(ALM_tilde,N,r_cut,jball,jjorigin,Y,dems_Y,dels_Y,r_select_ratio,length(ALM_tilde)-1 , size(data,1));
        real_recovered_data = real(recovered_data);
        sz = num2str(size_vec(k));
        %str = strcat('perturbation_',sz,'.mrc');
        %WriteMRC(real_recovered_data,1,str);
        diff = data-real_recovered_data;
        L2err(k) = norm(diff(:))/L2_data;
        neg_recovery = min(real_recovered_data, 0);
        L2_neg_recovery = norm(neg_recovery(:));
        L2_neg(k) = L2_neg_recovery/norm(real_recovered_data(:));
        L2err_avg(k) = L2err_avg(k)+L2err(k);
        L2_neg_avg(k) = L2_neg_avg(k)+L2_neg(k);
    end

    plot(size_vec, L2_neg);
    xlabel('Size of Perturbations');
    ylabel('Size of Negative Element');
    index = num2str(i);
    %str = strcat('trial_hyperboloid_',index,'.png');
    %saveas(gcf,str)
    clf
end
L2err_avg = L2err_avg/100;
L2_neg_avg = L2_neg_avg/100;
plot(size_vec,L2_neg_avg);
xlabel('Size of Perturbations');
ylabel('Size of Negative Element');
%saveas(gcf,'trial_hyperboloid_avg.png');