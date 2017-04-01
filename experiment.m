clear all; 
N = 20;
[x y z]=ndgrid(-N:N);
data = (4.25*N^2 - (x.^2 + (1.5*y).^2+z.^2))/(4.25*(N)^2);
%data=double((x.^2+(1.5*y).^2+z.^2)<N^2);
 maxL = maximum_l(N);
 r_cut = 1;
[recovered_data,ALM,ALM_tilde,jball] = recover_data(data,maxL,r_cut);
data_upd = recovered_data;
[recovered_data_upd,ALM,ALM_tilde,jball] = recover_data(data_upd,maxL,r_cut);

diff = recovered_data-data;
diff_upd = recovered_data_upd-data_upd;

error = norm(diff(:))/norm(data(:)) % error = 0.6867, 0.5593
error_upd = norm(diff_upd(:))/norm(data(:)) %error_upd = 1.05e-10, 0.0114

% Psilms_cartesian = zeros(2*N+1,2*N+1,2*N+1);
% Psilms_cartesian(jball) = Psilms(:,1);
% Psilms_cartesian = ifftshift(ifftn(fftshift(Psilms_cartesian)));
% WriteMRC(Psilms_cartesian,1,'Psilms_test.mrc')
