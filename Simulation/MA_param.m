%% Function to calculate all Metagrating (MG) design parameters
%
% Inputs:
%   theta_out - Desired outgoing angle (in degrees)
%   freq - Operating frequency (in Hz)
%
% Outputs:
%   delta - Distance between atoms along the y-axis (in meters)
%   h - Distance between the PEC and the Metagrating (in meters)
%   alpha_over_lx - Normalized polarizability per unit cell length
%   p_over_lx - Normalized electric dipole moment per unit cell length
%   param - Structure containing physical constants and computed parameters

function [delta, h, alpha_over_lx, p_over_lx, param] = MA_param(theta_out, freq)
    
    % Add path to library functions (adjust the path as needed)
    addpath('C:\Users\mayag\OneDrive - Technion\technion\projectA\prep\realization_article\lib_funnc');
    
    % Retrieve basic physical parameters based on the operating frequency
    param = get_parameters(freq);
    
    % Calculate the atom periodicity (delta) along the y-axis
    delta = find_delta(theta_out, freq, param);
    
    % Calculate the height (h) between the PEC and the MG
    h = find_h(theta_out, freq, param);
    
    % Calculate the normalized polarizability (alpha/lx)
    alpha_over_lx = find_alpha(theta_out, freq, delta, h, param);
    
    % Calculate the normalized dipole moment (p/lx)
    p_over_lx = find_p(delta, h, param);

end
