%-------------------------------------------------------
    % Step 4: This function computes reconstructed 3D structure
    %-------------------------------------------------------
function [phi] = recon_3D_structure(phi_tilde)
phi = ifftn(phi_tilde); % need to add parameters for the inverse transforms
