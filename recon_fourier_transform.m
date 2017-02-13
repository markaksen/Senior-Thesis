%-------------------------------------------------------
    % Step 3: This function computes reconstructed fourier transform
    %-------------------------------------------------------
function [phi_hat] = recon_fourier_transform(ALM,maxphi, maxtheta)

[cnt,max, nonzero] = count(ALM);
K = max;
phi_interval = 2*pi/(maxphi-1);
theta_interval = 2*pi/(maxtheta-1); 
phi_hat = zeros(K, maxphi, maxtheta);
for k = 1:K
    for phi_index = [0:maxphi-1]
        phi = phi_index*phi_interval;
        for theta_index = [0:maxtheta-1]
            theta = theta_index*theta_interval;
            sum = 0;
            for l = 1:nonzero
                 for m = 1:(2*l-1)
                    x = ALM{l};
                    sz = size(x);
                    if (sz(1)>= k)
                         y = x(k,m);
                        sum = sum+(y.*ylm(l,m-l-1, theta, phi));
                    end
                 end
            end
            phi_hat(k,phi_index+1,theta_index+1) = sum;
        end
    end
end
end