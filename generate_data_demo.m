%file = 'C:/Mark/College/Senior Year/Senior Thesis/code/EMD-6454.map';
%[data] = ReadMRC(file);
[x y z]=ndgrid(-10:10);
%[az,el,r] = cart2sph(x,y,z)
%data = sin((pi/2)-el)
data=(x.^2+(y*1.5).^2+z.^2)<10^2;
[ALM, ~] = spherical_harm_coeff(data);
[ALM_tilde] = recon_spherical_harm_coefff(ALM);
save('data2.mat');
%load('data.mat')
%maxphi = 50; maxtheta = 20;
%[phi_hat] = recon_fourier_transform(ALM_m, maxphi, maxtheta)
%[phi] = recon_3D_structure(phi_hat)
%save('result.mat')
%WriteMRC(phi,1,'EMD-6454_2.mrc');

