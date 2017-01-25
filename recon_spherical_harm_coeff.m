%-------------------------------------------------------
    % Step 2: This function computes reconstructed spherical harmonic 
    % coefficients using Cholesky decomposition
    %-------------------------------------------------------
function [Cl] = recon_spherical_harm_coeff(Alm)
%Cl = chol(Alm'*Alm)
Cl = Alm;
