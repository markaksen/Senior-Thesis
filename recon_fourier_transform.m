%-------------------------------------------------------
    % Step 3: This function computes reconstructed fourier transform
    %-------------------------------------------------------
function [phi_tilde] = recon_fourier_transform(Cl,K, maxphi, maxtheta)

phi_interval = 2*pi/(maxphi-1);
theta_interval = 2*pi/(maxtheta-1); 
theta = [0:theta_interval:2*pi]
phi_tilde = zeros(K, maxphi, maxtheta);
for k = 0:K
    for phi = [0:phi_interval:2*pi]
        sum = 0;
        for l = 1:K
             for m = 0:(2*l)
                  [l,m, phi]
                  size_Cl = size(Cl{l+m})
                  size_ylm = size(ylm(l,m,theta,phi))
                  sum = sum+Cl{l+m}.*ylm(l,m, theta, phi);
             end
        end
        phi_tilde(k,phi) = sum;
    end
end
end