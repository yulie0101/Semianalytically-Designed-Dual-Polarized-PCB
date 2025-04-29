%% Function to calculate alpha/lx
% alpha_over_lx represents the normalized polarizability per unit cell length (lx)
%
% Inputs:
%   theta_out - The desired outgoing angle (in degrees)
%   freq - The operating frequency (in Hz)
%   delta - The distance between atoms along the y-axis (in meters)
%   h - The distance between the PEC and the Metagrating (in meters)
%   param - A structure containing physical parameters (from get_parameters function)
%
% Returns:
%   alpha_over_lx - The normalized polarizability per unit cell length

function alpha_over_lx = find_alpha(theta_out, freq, delta, h, param)
    
    % Set the maximum number of terms for the series summations
    N_max = 100; % For the Hankel function series
    M_max = 100; % For the Floquet-Bloch modes sum
    
    % Calculate the transverse wavenumber kx for each diffraction order m
    m_vec = -M_max:M_max;
    kx_m = (2*pi*m_vec) / delta;
    
    % Calculate the longitudinal wavenumber beta_m for each m
    beta_m = sqrt(param.k^2 - kx_m.^2);
    
    % Ensure physical consistency:
    % Real parts of beta_m should be positive
    beta_m(real(beta_m) < 0) = -beta_m(real(beta_m) < 0);
    % Imaginary parts of beta_m should be negative (for decaying modes)
    beta_m(imag(beta_m) > 0) = -beta_m(imag(beta_m) > 0);

    % Calculate the Hankel function series sum
    n_vec = 1:N_max;
    Hankel_sum = sum(besselh(1, 2, n_vec * param.k * delta) ./ (n_vec * delta));
    
    % Calculate the sum over beta_m terms, accounting for propagation phases
    beta_m_sum = sum(beta_m .* exp(-2j * beta_m * h));
    
    % Full expression for alpha_over_lx:
    
    % Term1: Related to the wave propagation and boundary condition at h
    term1 = 2j * param.omega * param.eta / delta * sin(param.k*h)^2;
    
    % Term2: Related to the interactions between different atoms via Hankel functions
    term2 = -1j * param.eta * param.omega / 2 * Hankel_sum;
    
    % Term3: Accounts for the contribution of higher-order Floquet-Bloch modes
    term3 = 1j * param.eta * param.C / (2 * delta) * beta_m_sum;
    
    % Combine terms to find the normalized polarizability
    alpha_over_lx = 1 / (term1 + term2 + term3);

end
