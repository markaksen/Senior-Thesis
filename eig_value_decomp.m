load('perturbations.mat');
N = 10;
[x y z]=ndgrid(-N:N);
data=(x.^2+(1.5*y).^2+z.^2)<N^2; %ellipsoid
data = double(data);
%data = smooth3(data,'box');
L2_data = norm(data(:));
maxL = maximum_l(N);
[ALM, C, N, r_cut, jball, jjorigin,Y, dems_Y, dels_Y, r_select_ratio] = spherical_harm_coeff(data, maxL);
[ALM_eigval,U] = recon_spherical_harm_coeff(ALM);
recovered_v = recover_from_ALM_v4(ALM_eigval,N,r_cut,jball,jjorigin,Y,dems_Y,dels_Y,r_select_ratio, length(ALM_eigval)-1, size(data,1));
recovered_data = real(recovered_v);
neg_recovery = min(recovered_data, 0);
neg_err = norm(neg_recovery(:));
neg_err= neg_err/norm(recovered_data(:));

err = neg_err;
k = 0;
maxL = length(ALM_eigval);
while (err > neg_err/10 && k <= 100)
    k
    for ii=0:maxL-1
        A = expm(random_skew_symmetric(2*ii+1));
        O = size_vec(max(find(L2_neg<err)))*A/norm(A(:));
        O = O+eye(2*ii+1);
        ALM_eigval_new{ii+1} = ALM_eigval{ii+1}*O;
    end
    recovered_data_new = recover_from_ALM_v4(ALM_eigval_new,N,r_cut,jball,jjorigin,Y,dems_Y,dels_Y,r_select_ratio,length(ALM_eigval)-1 , size(data,1));
    real_recovered_data_new = real(recovered_data_new);
    sz_data = norm(real_recovered_data_new(:));
    diff = data-real_recovered_data_new;
    neg_recovery = min(real_recovered_data, 0);
    err_neg = norm(neg_recovery(:))/sz_data;
    if (err > err_neg)
        err = err_neg; ALM_eigval = ALM_eigval_new;
    end 
    k = k+1;
end