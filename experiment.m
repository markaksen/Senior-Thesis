%clear all; 
N_min = 3; N_max = 20; 
N_vec = linspace(N_min,N_max,N_max-N_min+1);
error_vec = zeros(N_max-N_min+1,1);
error_upd_vec = zeros(N_max-N_min+1,1);
freq_jball_vec = zeros(N_max-N_min+1,1);
FSC_error_vec = zeros(
elapsed_time = zeros(N_max-N_min+1);
for i=1:18
    tic; i
    N = N_vec(i);
    [x y z]=ndgrid(-N:N);
    data = (4.25*N^2 - (x.^2 + (1.5*y).^2+z.^2))/(4.25*(N)^2);
    %data=double((x.^2+(1.5*y).^2+z.^2)<N^2);
     maxL = maximum_l(N);
     r_cut = 1;
    [recovered_data,ALM,ALM_tilde,jball,freq_jball] = recover_data(data,maxL,r_cut,1);
    freq_jball_vec(i) = freq_jball;
    data_upd = recovered_data;
    [recovered_data_upd,ALM_upd,ALM_tilde_upd,jball_upd,~] = recover_data(data_upd,maxL,r_cut,0);

    diff = recovered_data-data;
    diff_upd = recovered_data_upd-data_upd;

    error_vec(i) = norm(diff(:))/norm(data(:)); % error = 0.6867, 0.5593
    error_upd_vec(i) = norm(diff_upd(:))/norm(data_upd(:)); %error_upd = 1.05e-10, 0.0114, 0.0138
    elapsed_time2 = toc;
end

plot(N_vec,error_vec) 
xlabel('Size of data(n)');
ylabel('L2 Error of Data');
axis([3 20 0 0.8]);

plot(N_vec,error_upd_vec)
xlabel('Size of data(n)');
ylabel('L2 Error of Recovered Data');
axis([3 20 0 0.1]);
% Psilms_cartesian = zeros(2*N+1,2*N+1,2*N+1);
% Psilms_cartesian(jball) = Psilms(:,1);
% Psilms_cartesian = ifftshift(ifftn(fftshift(Psilms_cartesian)));
% WriteMRC(Psilms_cartesian,1,'Psilms_test.mrc')

% WriteMRC(data,1,'ellipsoid_data.mrc');
% WriteMRC(recovered_data,1,'ellipsoid_recovered.mrc');
% WriteMRC(recovered_data_upd,1,'ellipsoid_recovered_twice.mrc');
