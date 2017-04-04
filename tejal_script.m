%Initialize parameters
%vol_micky=ReadMRC('/scratch/ARCHIVE_from_sdl6/tbhamre/ndice/emd_8117.map');
%vol_micky=ReadMRC('C:/Mark/College/Senior Year/data/emd_8117.map');
vol_micky=ReadMRC('C:\Mark\College\Senior Year\Senior Thesis\data\emd_8117.map');
%N = 20;
%[x y z]=ndgrid(-N:N);
%data = (4.25*N^2 - (x.^2 + (1.5*y).^2+z.^2))/(4.25*(N)^2);
%vol_micky = data;
ddim=95;
vol_micky=cryo_downsample(vol_micky,ddim);
c=0.5 % Full support in frequency space
R=floor(ddim/2)-2
N=floor(size(vol_micky,1)/2);r_cut=2*c;maxL=floor(ddim/4)-1; 
r_select_ratio=1;

tic;[jball,jjorigin,Y,dems_Y,dels_Y]=prepare_psilms_cwf(N,r_cut,maxL, size(vol_micky,1));toc %Elapsed time is 210.657866 seconds.
[ALM_m,C_m]=find_ALM_v4(vol_micky,maxL,r_cut,jball,jjorigin,Y,dems_Y,dels_Y, r_select_ratio);

%Reconstruct
vol_re=recover_from_ALM_v4(ALM_m,N,r_cut,jball,jjorigin,Y,dems_Y,dels_Y, r_select_ratio, maxL, ddim);
norm(vol_re(:)-vol_micky(:))/norm(vol_micky(:)) % Error here is ~55%

% Express molecule that's already in basis this time, so error should be small
[ALM_m2,C_m]=find_ALM_v4(vol_re,maxL,r_cut,jball,jjorigin,Y,dems_Y,dels_Y, r_select_ratio);
vol_re2=recover_from_ALM_v4(ALM_m2,N,r_cut,jball,jjorigin,Y,dems_Y,dels_Y, r_select_ratio, maxL, ddim);
norm(vol_re2(:)-vol_re(:))/norm(vol_re(:)) % Error here is 0.2%