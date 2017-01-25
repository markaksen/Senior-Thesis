%-------------------------------------------------------
    % Step 3: This function computes reconstructed fourier transform
    %-------------------------------------------------------
function [phi_tilde] = recon_fourier_transform(Cl,K, maxphi, maxtheta)

phi_interval = 2*pi/(maxphi-1);
theta_interal = 2*pi/(maxtheta-1);

phi_tilde = zeros(K, maxphi, maxtheta);
for k = 0:K
    for phi = [0:phi_interval:2*pi]
        for theta = [0:theta_interval:2*pi]
            sum = 0;
            for l = 0:K
                for m = -l:l
                    if m < 0
                        sum = sum+Cl[-(m+1)].*Ylm(theta, phi);
                    else 
                        sum =  sum+Cl[l+m].*Ylm(theta,phi);
            phi_tilde(k,phi,theta) = sum;