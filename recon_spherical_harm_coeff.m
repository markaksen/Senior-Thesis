%-------------------------------------------------------
    % Step 2: This function computes reconstructed spherical harmonic 
    % coefficients using eigenvalue decomposition
    %-------------------------------------------------------
function [ALM_tilde,U] = recon_spherical_harm_coeff(Alm)

% ALM_tilde = Alm;
% U = [];
MACHINEEPS = 1e-16;
 for ii=1:length(Alm)
    sz = size(Alm{ii});
    if (sz(1) >= sz(2))
        Cl = Alm{ii}*(Alm{ii})';
        [V,D]=eig(Cl);
        V1 =  V(:,(end-2*(ii-1)):end); D1 = D((end-2*(ii-1)):end,(end-2*(ii-1)):end);
        ALM_tilde{ii} = V1*sqrt(D1);
        if (max(max(Alm{ii}))>MACHINEEPS)
            U{ii} = Alm{ii}\ALM_tilde{ii};
        else 
            U{ii} = Alm{ii};
        end
    end
 end
end