%% Function to calculate h
% h is the distance between the PEC (Perfect Electric Conductor) and the Metagrating (MG) in meters
%
% Inputs:
%   theta_out - The desired outgoing angle (in degrees)
%   freq - The operating frequency (in Hz)
%   param - A structure containing physical parameters (from get_parameters function)
%
% Returns:
%   h - The calculated distance between the PEC and the MG

function h = find_h(theta_out, freq, param)

    % Define the nonlinear equation to solve for h:
    % (sin(k*h))^2 - 2*cos(theta_out)*(sin(k*h*cos(theta_out)))^2 = 0
    % where k is the wavenumber in the medium, and theta_out is in degrees (converted to radians)
    fun = @(h) (sin(param.k*h)).^2 - 2*cos(deg2rad(theta_out)).*(sin(param.k*h*cos(deg2rad(theta_out)))).^2;
    
    % Initial guess for h based on the article's solution branch
    % (typically around half the wavelength)
    h_initial_guess = 0.55 * param.lambda;
    
    % Solve the nonlinear equation using fzero
    % fzero finds the root of the function near the initial guess
    h = fzero(fun, h_initial_guess);

end
