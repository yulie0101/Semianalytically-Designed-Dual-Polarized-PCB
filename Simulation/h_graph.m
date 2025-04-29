% Basic parameters
f = 20e9;    % Frequency: 20 GHz
c = physconst('LightSpeed');   % Speed of light
lambda = c / f;
k = 2*pi / lambda;

% Range of output angles
theta_vec_deg = linspace(30, 80, 100);   % Output angles [deg]
theta_vec_rad = deg2rad(theta_vec_deg);  % Convert to radians

% h scan range (searching zeros)
h_scan = linspace(0, 2*lambda, 1000);

% Prepare cell to store solutions
h_all_solutions = cell(length(theta_vec_deg),1);

% Loop over all angles
for j = 1:length(theta_vec_deg)
    theta_out = theta_vec_rad(j);

    % Define the function to solve
    fun = @(h) (sin(k*h)).^2 - 2*cos(theta_out).*(sin(k*h*cos(theta_out))).^2;

    % Evaluate function over scanned h
    fvals = fun(h_scan);

    % Find sign changes (where function crosses zero)
    sign_changes = find(fvals(1:end-1).*fvals(2:end) < 0);

    % Refine the solution near each zero crossing
    h_solutions_this_theta = [];
    for idx = sign_changes
        h_guess = mean([h_scan(idx), h_scan(idx+1)]);
        try
            h_sol = fzero(fun, [h_scan(idx), h_scan(idx+1)]);
            h_solutions_this_theta(end+1) = h_sol; %#ok<SAGROW> store solution
        catch
            % If fzero fails, just skip
        end
    end

    % Store all solutions for this angle
    h_all_solutions{j} = h_solutions_this_theta;
end

%% Smart matching between branches
% Prepare: for each branch, we will collect points along theta
max_branches = max(cellfun(@length, h_all_solutions)); % Max number of branches found
h_branch_data = nan(max_branches, length(theta_vec_deg)); % Preallocate

% For the first theta, just assign in order
h_branch_data(:,1) = nan; 
h_first = h_all_solutions{1};
h_branch_data(1:length(h_first),1) = h_first(:);

% Now go over all thetas and try to match solutions
for j = 2:length(theta_vec_deg)
    h_prev = h_branch_data(:,j-1); % previous h values
    h_curr = h_all_solutions{j};   % current found h values

    assigned = false(size(h_curr)); % flags for already assigned

    for b = 1:max_branches
        if isnan(h_prev(b))
            continue; % no previous branch here
        end

        % Find nearest unassigned current h
        diffs = abs(h_curr - h_prev(b));
        diffs(assigned) = Inf; % ignore already assigned
        [min_diff, min_idx] = min(diffs);

        if min_diff < 0.2*lambda % only if close enough
            h_branch_data(b,j) = h_curr(min_idx);
            assigned(min_idx) = true;
        end
    end

    % If some h_curr are still unassigned -> new branches
    new_h = h_curr(~assigned);
    empty_slots = find(isnan(h_branch_data(:,j)));
    n_new = min(length(new_h), length(empty_slots));
    h_branch_data(empty_slots(1:n_new), j) = new_h(1:n_new);
end

%% Plotting
figure;
hold on;
colors = lines(max_branches); % Nice colors
for b = 1:max_branches
    plot(theta_vec_deg, h_branch_data(b,:)/lambda, 'Color', colors(b,:), 'LineWidth', 2);
end
xlabel('\theta_{out} [deg]');
ylabel('h / \lambda');
title('Smart connected branches of h(\theta_{out})');
grid on;
hold off;
legend(arrayfun(@(x) ['Branch ', num2str(x)], 1:max_branches, 'UniformOutput', false));
