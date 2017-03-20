%-------------------------------------------------------
    % Step 1: This function computes spherical harmonic coefficients
    % resulting matrix Alm is a vector of cells of spherical harmonic 
    % coefficients
    % 1st dimension is l, 2nd dimension is m, 3rd dimension is k
    %-------------------------------------------------------
function [ALM, C, N, r_cut, jball, jjorigin,Y, dems_Y, dels_Y, r_select_ratio] = spherical_harm_coeff(data, maxL)

c = 0.5; % must be between 0 and 0.5
k = size(data,1);
N = floor(size(data,1)/2); r_cut = 2*c;
%data = cryo_downsample(data, ddim);
%data = downsample(data,6);
r_select_ratio = 1;
[jball, jjorigin,Y,dems_Y,dels_Y] = prepare_psilms_cwf(N,r_cut, maxL, size(data,1));
[ALM, C] = find_ALM_v4(data, maxL, r_cut, jball, jjorigin, Y, dems_Y, dels_Y,r_select_ratio);