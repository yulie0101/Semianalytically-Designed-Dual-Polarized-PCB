

%% pram

% [alfa, delta, h, p_over_l, miu, eps, freq, k0, E_in]

miu = 1;
eps = 1;
freq = 20e9;
E_in = 1;
C = physconst('LightSpeed');
k_0 = 2*pi*freq/C;
n = sqrt(miu*eps);
eta_0 = 376.730313412;
eta = eta_0*sqrt(miu/eps);
k = k_0*n;
lambda = C/(n*f);

%% find delta 
% delta is The distance between the atoms on the y-axis in [m]
% theta out in [deg]
function delta = find_delta(theta_out)
    delta = (2*pi)/(k_0*sind(theta_out));
end

%% find h
% h is the  distance between the PEC and the MG;
function h = find_h(theta_out)
    
    % Define the function to solve
    fun = @(h) (sin(k*h)).^2 - 2*cos(deg2rad(theta_out)).*(sin(k*h*cos(deg2rad(theta_out)))).^2;
    % Guessing an initial value according to the solution branch chosen in the article
    h_initial_guess = 0.55 * lambda;
    % Solving the equation
    h = fzero(fun, h_initial_guess);

end

%% alfa/lx
function alfa = find_alfa(theta_out, h)
    
end
    
%% p/lx