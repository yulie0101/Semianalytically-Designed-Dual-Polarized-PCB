%{
    -- WORKING PLAN --
This file - takes care of the electric field that's represents the
interactions in the system
Maya's file - drawing the graphs for the different equations and getting
the parameters needed

%}

% geneal constant
theta_out = 60; % degrees
epsilon_0 = 8.854187817e-12;  % Permittivity of free space [F/m]
mu_0 = 4*pi*1e-7;             % Permeability of free space [H/m]
c = physconst('LightSpeed');

% function [alfa, delta, h, p_over_l, miu, eps, freq, k0, E_in] = Mayas (theta_out)
% 
%     alfa = 1;
%     E_in = 1;
%     eps = 1;
%     miu = 1;
%     c = physconst('LightSpeed');
%     freq = 20e9;
%     lambda = physconst('LightSpeed') / freq;
%     k = 2 * pi / lambda;
%     h = 0.66 * lambda;
%     delta = 1.15 * lambda;
%     k0 = 2*pi*freq/physconst('LightSpeed');  % free-space wavenumber
%     epsilon_0 = 8.854187817e-12;  % Permittivity of free space [F/m]
%     mu_0 = 4*pi*1e-7;             % Permeability of free space [H/m]
%     eta = sqrt((mu_0 * miu) / (epsilon_0 * eps));
%     p_over_l = delta/(2*pi*freq*eta);
% end
% 
% [alfa, delta, h, p_over_l, miu, eps, freq, k0, E_in] = Mayas(theta_out);

[delta, h, alpha_over_l, p_over_lx, param] = MA_param(theta_out, freq);

% constant deriven:
E_in = param.E_in;
eta = param.eta;
omega = param.omega;
lambda = param.lambda;
k = param.k;

% axes
z = linspace(-3 * lambda, 0, 1500);     % [1 X 1500]
y = linspace(-0.5 * lambda, 0.5 * lambda, 500);     % [1 X 500]
% meshgrid - craetes a tenzor thats covers all the possiable combinations of of Z, Y 
[Y, Z] = meshgrid(y, z);    % Each [1500 X 500]

% Different modes
M = 50;
m = -M:M; % [1 X 2M + 1]
kt_m_vals = (2 .* pi .* m) ./ delta;    % [1 X 2M + 1]
beta_m_vals = sqrt(k^2 - kt_m_vals .^ 2);      % [1 X 2M + 1]
beta_m_vals(imag(beta_m_vals) > 0) = -beta_m_vals(imag(beta_m_vals) > 0);

% Creating grids for future multiplications
[Yg, Zg, Mg] = ndgrid(y, z, m);     % Each [1500 x 500 X 101]
beta_m_grid = reshape(beta_m_vals, 1, 1, []);   % [1 X 1 X 101]
kt_m_grid = reshape(kt_m_vals, 1, 1, []);   % [1 X 1 X 101]


% above coefficients
coeff_m = -0.5j * ((eta * c * p_over_lx) / delta) .* beta_m_grid; 
y_exp = exp(-1j * kt_m_grid .* Y);     
z_exp = exp(-1j * beta_m_grid .* abs(Z + h)) - exp(-1j * beta_m_grid .* abs(Z - h));     
sum_terms = coeff_m .* z_exp .* y_exp;
E_sum = sum(sum_terms, 3);


% Total field
E_tot = -2j * E_in * sin(k * Z) + E_sum;


% Plot
figure;
imagesc(y/lambda, z/lambda, abs(real(E_tot)));
colorbar;
xlabel('y [\lambda]');
ylabel('z [\lambda]');
set(gca, 'YDir', 'reverse');
title('|Re(E_y(y,z))| Field Distribution (Vectorized)');
clim([0, 3])





