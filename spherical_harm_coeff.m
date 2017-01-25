%-------------------------------------------------------
    % Step 1: This function computes spherical harmonic coefficients
    % resulting matrix Alm is a 3D matrix. 
    % 1st dimension is l, 2nd dimension is m, 3rd dimension is k
    %-------------------------------------------------------
function [ALM_m, C_m] = spherical_harm_coeff(data)

ddim=10009;
% vol_micky=ReadMRC('/scratch/ARCHIVE_from_sdl6/tbhamre/ndice/micky/micky_nose_all.mrc');
% vol_micky=cryo_downsample(vol_micky,ddim);
% vol_ball=ReadMRC('/scratch/ARCHIVE_from_sdl6/tbhamre/ndice/micky/micky_nose_nose.mrc');
% vol_ball=cryo_downsample(vol_ball,ddim);
% vol_only_micky=ReadMRC('/scratch/ARCHIVE_from_sdl6/tbhamre/ndice/micky/micky_nose_micky.mrc');
% vol_only_micky=cryo_downsample(vol_only_micky,ddim);
% c=0.5 % must between 0 and 0.5
% N=floor(size(vol_micky,1)/2);r_cut=2*c;maxL=floor(ddim/4)-1;
% r_select_ratio=1;
% [jball,jjorigin,Y,dems_Y,dels_Y]=prepare_psilms_cwf(N,r_cut,maxL, size(vol_micky,1))
% [ALM_m,C_m]=find_ALM_v4(vol_only_micky,maxL,r_cut,jball,jjorigin,Y,dems_Y,dels_Y, r_select_ratio);
% [ALM_mb,C_mb]=find_ALM_v4(vol_micky,maxL,r_cut,jball,jjorigin,Y,dems_Y,dels_Y, r_select_ratio);

c = 0.5; % must be between 0 and 0.5
N = floor(size(data,1)/2); r_cut = 2*c; maxL = floor(ddim/4)-1;
%data = cryo_downsample(data, ddim);
%data = downsample(data,6);
r_select_ratio = 1;
[jball, jjorigin,Y,dems_Y,dels_Y] = prepare_psilms_cwf(N,r_cut, maxL, size(data,1));
[ALM_m, C_m] = find_ALM_v4(data, maxL, r_cut, jball, jjorigin, Y, dems_Y, dels_Y,r_select_ratio)
