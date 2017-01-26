%file = 'C:/Mark/College/Senior Year/Senior Thesis/code/EMD-6454.map';
%[data] = ReadMRC(file);
%[x y z]=ndgrid(-3:3);
 %data=(x.^2+(y*1.5).^2+z.^2)<2^2
%[ALM_m, C_m] = spherical_harm_coeff(data);
%[Cl] = recon_spherical_harm_coeff(ALM_m);
%save('data3.mat');
load('data3.mat')
K = 50; maxphi = 50; maxtheta = 20;
[phi_tilde] = recon_fourier_transform(Cl, K, maxphi, maxtheta);
[phi] = recon_3D_structure(phi_tilde);
WriteMRC(phi,1,'EMD-6454_2.mrc');
