% Function to calculate and return various physical parameters based on frequency
% Parameters:
%   freq - The frequency (in Hz) at which to calculate the parameters
% Returns:
%   param - A structure containing the calculated parameters

function param = get_parameters(freq)
    % Electric field amplitude (assumed to be 1)
    param.E_in = 1;  
    
    % Speed of light in vacuum
    param.C = physconst('LightSpeed');
    
    % Permittivity of free space (in Farads per meter)
    param.eps_0 = 8.8541878188e-12;  
    
    % Wavenumber in free space
    param.k_0 = 2*pi*freq/param.C;
    
    % Intrinsic impedance of free space (in Ohms)
    param.eta_0 = 376.730313412;
    
    % Relative permeability (assuming non-magnetic material, miu = 1)
    param.miu = 1;
    
    % Relative permittivity (assuming non-dielectric material, eps = 1)
    param.eps = 1;
    
    % Refractive index
    param.n = sqrt(param.miu*param.eps);
    
    % Impedance of the medium
    param.eta = param.eta_0*sqrt(param.miu/param.eps);
    
    % Wavenumber in the medium
    param.k = param.k_0*param.n;
    
    % Wavelength in the medium
    param.lambda = param.C/(param.n*freq);
    
    % Angular frequency
    param.omega = 2*pi*freq;
end
