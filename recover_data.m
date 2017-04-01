function [recovered_data,ALM, ALM_tilde, jball] = recover_data(data, maxL,r_cut)

    [ALM, C, N, r_cut, jball, jjorigin,Y, dems_Y, dels_Y, r_select_ratio] = spherical_harm_coeff(data, maxL, r_cut);
    jball_size = numel(jball);
    [ALM_tilde,U] = recon_spherical_harm_coeff(ALM);
    recovered_v = recover_from_ALM_v4(ALM_tilde,N,r_cut,jball,jjorigin,Y,dems_Y,dels_Y,r_select_ratio, length(ALM_tilde)-1, size(data,1));
    recovered_data = real(recovered_v);
end