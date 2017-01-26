%-------------------------------------------------------
    % Step 3: This function computes reconstructed fourier transform
    %-------------------------------------------------------
function [phi_tilde] = recon_fourier_transform(Cl,K, maxphi, maxtheta)

phi_interval = 2*pi/(maxphi-1);
theta_interval = 2*pi/(maxtheta-1);

phi_tilde = zeros(K, maxphi, maxtheta);
for k = 0:K
    for phi = [0:phi_interval:2*pi]
        for theta = [0:theta_interval:2*pi]
            sum = 0;
            for l = 1:K
                for m = 0:(2*l)
                        sum = sum+Cl(l+m).*ylm(l,m, theta, phi);
                end
            end
            phi_tilde(k,phi,theta) = sum;
        end
    end
end
end